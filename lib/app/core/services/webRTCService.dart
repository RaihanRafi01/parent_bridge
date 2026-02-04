import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart' as rtc;

class WebRTCService {
  rtc.RTCPeerConnection? _peerConnection;
  rtc.MediaStream? _localStream;

  rtc.RTCPeerConnection? get peerConnection => _peerConnection;
  rtc.MediaStream? get localStream => _localStream;

  // Callbacks for the Controller
  Function(rtc.MediaStream)? onRemoteStream;
  Function(rtc.RTCIceCandidate)? onIceCandidate;
  Function(rtc.RTCPeerConnectionState)? onConnectionStateChange;

  Future<bool> initialize() async {
    try {
      // 1. Configure Audio for Android Communication Mode
      if (rtc.WebRTC.platformIsAndroid) {
        await rtc.Helper.setAndroidAudioConfiguration(
          rtc.AndroidAudioConfiguration(
            manageAudioFocus: true,
            androidAudioMode: rtc.AndroidAudioMode.inCommunication,
            androidAudioAttributesUsageType: rtc.AndroidAudioAttributesUsageType.voiceCommunication,
            androidAudioAttributesContentType: rtc.AndroidAudioAttributesContentType.speech,
          ),
        );
      }

      // 2. Create Peer Connection with STUN/TURN servers
      _peerConnection = await rtc.createPeerConnection({
        'iceServers': [
          {'urls': 'stun:stun.l.google.com:19302'},
          {'urls': 'stun:stun1.l.google.com:19302'},
          {
            'urls': 'turn:openrelay.metered.ca:80',
            'username': 'openrelayproject',
            'credential': 'openrelayproject',
          },
        ],
        'sdpSemantics': 'unified-plan',
      });

      // 3. Set up Event Listeners
      _peerConnection!.onIceCandidate = (candidate) {
        if (candidate != null) onIceCandidate?.call(candidate);
      };

      _peerConnection!.onTrack = (event) {
        if (event.streams.isNotEmpty) {
          onRemoteStream?.call(event.streams[0]);
          debugPrint("Remote track received");
        }
      };

      _peerConnection!.onConnectionState = (state) {
        onConnectionStateChange?.call(state);
      };

      await rtc.Helper.setSpeakerphoneOn(false);

      return true;
    } catch (e) {
      debugPrint("WebRTC Init Error: $e");
      return false;
    }
  }

  Future<rtc.MediaStream> getUserMedia() async {
    final constraints = {
      'audio': {'echoCancellation': true, 'noiseSuppression': true, 'autoGainControl': true},
      'video': false,
    };

    _localStream = await rtc.navigator.mediaDevices.getUserMedia(constraints);

    // Attach local tracks to the connection
    for (final track in _localStream!.getTracks()) {
      await _peerConnection?.addTrack(track, _localStream!);
    }
    return _localStream!;
  }

  Future<rtc.RTCSessionDescription> createOffer() async {
    final offer = await _peerConnection!.createOffer();
    await _peerConnection!.setLocalDescription(offer);
    return offer;
  }

  Future<rtc.RTCSessionDescription> createAnswer() async {
    final answer = await _peerConnection!.createAnswer();
    await _peerConnection!.setLocalDescription(answer);
    return answer;
  }

  Future<void> dispose() async {
    await _localStream?.dispose();
    await _peerConnection?.close();
    _peerConnection = null;
    _localStream = null;
  }
}