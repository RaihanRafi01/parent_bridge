import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart' as rtc;
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../core/services/base_client.dart';
import '../../../core/services/webRTCService.dart';
import '../views/incoming_ongoing_call.dart';

class CallController extends GetxController {
  final WebRTCService _webRTCService = WebRTCService();
  WebSocketChannel? _channel;

  // UI States
  var isCallAccepted = false.obs;
  var isAcceptingCall = false.obs;
  var isMuted = false.obs;
  var isSpeakerOn = true.obs;

  // Timer States
  var callDuration = 0.obs;
  Timer? _timer;

  // Stream Reference
  var remoteStream = Rxn<rtc.MediaStream>();

  String? currentCallId;
  String targetUserId = "42";
  String? remoteSdpOffer;

  @override
  void onInit() {
    super.onInit();
    _connectWebSocket(); // Assuming your websocket connection logic is here

    // 1. Listen for ICE Candidates generated locally to send to the other peer
    _webRTCService.onIceCandidate = (candidate) {
      _sendSignaling({
        "type": "ice_candidate",
        "candidate": candidate.toMap(),
        "receiver_id": targetUserId,
        "call_id": currentCallId
      });
    };

    // 2. Listen for the Remote Audio Track to update the UI/Renderer
    _webRTCService.onRemoteStream = (stream) {
      remoteStream.value = stream;
    };
  }

  // --- Timer Logic ---
  void _startTimer() {
    _timer?.cancel();
    callDuration.value = 0;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      callDuration.value++;
    });
  }

  String get formatDuration {
    int minutes = callDuration.value ~/ 60;
    int seconds = callDuration.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // --- Signaling Handler ---
  void _handleSignaling(Map<String, dynamic> data) async {
    final type = data['type'];
    debugPrint("Signaling Received: $type");

    switch (type) {
      case 'incoming_call':
        currentCallId = data['call_id']?.toString();
        remoteSdpOffer = data['sdp'];
        targetUserId = data['caller_id'].toString();
        isCallAccepted.value = false;
        Get.to(() => const IncomingOngoingCallView());
        break;

      case 'call_accepted':
        await _webRTCService.peerConnection?.setRemoteDescription(
            rtc.RTCSessionDescription(data['sdp'], 'answer'));
        isCallAccepted.value = true;
        _startTimer();
        break;

      case 'ice_candidate':
        if (data['candidate'] != null && _webRTCService.peerConnection != null) {
          await _webRTCService.peerConnection!.addCandidate(rtc.RTCIceCandidate(
            data['candidate']['candidate'],
            data['candidate']['sdpMid'],
            data['candidate']['sdpMLineIndex'],
          ));
        }
        break;

      case 'call_ended':
        _cleanUpCall();
        break;

      case 'error':
        debugPrint("Server Error: ${data['message']}");
        _cleanUpCall();
        break;
    }
  }

  // --- Call Actions ---

  Future<void> makeCall() async {
    if (await Permission.microphone.request().isGranted) {
      await _webRTCService.initialize();
      await _webRTCService.getUserMedia();
      final offer = await _webRTCService.createOffer();

      _sendSignaling({
        "type": "offer",
        "sdp": offer.sdp,
        "receiver_id": targetUserId,
      });
      Get.to(() => const IncomingOngoingCallView());
    }
  }


  Future<void> acceptCall() async {
    try {
      isAcceptingCall.value = true;
      await _webRTCService.initialize();
      await _webRTCService.getUserMedia();

      await _webRTCService.peerConnection!.setRemoteDescription(
          rtc.RTCSessionDescription(remoteSdpOffer, 'offer'));

      var answer = await _webRTCService.peerConnection!.createAnswer();
      await _webRTCService.peerConnection!.setLocalDescription(answer);

      _sendSignaling({
        "type": "answer",
        "sdp": answer.sdp,
        "call_id": currentCallId,
        "receiver_id": targetUserId
      });

      isCallAccepted.value = true;
      isAcceptingCall.value = false;
      _startTimer();
    } catch (e) {
      isAcceptingCall.value = false;
      debugPrint("Error accepting call: $e");
    }
  }

  void endCall() {
    _sendSignaling({
      "type": "call_end",
      "call_id": currentCallId,
      "receiver_id": targetUserId
    });
    _cleanUpCall();
  }

  void _cleanUpCall() {
    _timer?.cancel();
    _webRTCService.dispose();
    remoteStream.value = null;
    isCallAccepted.value = false;
    // Close the screen if we are currently on the call view
    if (Get.currentRoute.contains('IncomingOngoingCallView')) {
      Get.back();
    }
  }

  // --- Device Toggles ---
  void toggleMute() {
    isMuted.value = !isMuted.value;
    _webRTCService.localStream?.getAudioTracks().forEach((track) {
      track.enabled = !isMuted.value;
    });
  }

  void toggleSpeaker() {
    isSpeakerOn.value = !isSpeakerOn.value;
    rtc.Helper.setSpeakerphoneOn(isSpeakerOn.value);
  }

  void _sendSignaling(Map<String, dynamic> data) {
    _channel?.sink.add(jsonEncode(data));
  }

  Future<void> _connectWebSocket() async {
    try {
      // 1. Get the REAL token from your service
      final accessToken = await BaseClient.getAccessToken();

      // 2. Use ws:// (unsecure) or wss:// (secure)
      // Ensure there are no trailing '#' or 'YOUR_TOKEN' placeholders
      final wsUrl = 'ws://10.10.13.73:7000/ws/call/webrtc/?token=$accessToken';

      debugPrint("Connecting to WS: $wsUrl");

      _channel = WebSocketChannel.connect(Uri.parse(wsUrl));

      _channel!.stream.listen(
            (message) {
          debugPrint("WS Message Received: $message");
          _handleSignaling(jsonDecode(message));
        },
        onError: (e) {
          debugPrint("WS Connection Error: $e");
          // Retry after 5 seconds
          Future.delayed(const Duration(seconds: 5), () => _connectWebSocket());
        },
        onDone: () {
          debugPrint("WS Connection Closed. Reconnecting...");
          Future.delayed(const Duration(seconds: 5), () => _connectWebSocket());
        },
      );
    } catch (e) {
      debugPrint("Error establishing WS: $e");
    }
  }
}