import 'package:get/get.dart';

class CallController extends GetxController {
  var isCallAccepted = false.obs;
  var isAcceptingCall = false.obs;

  var isMuted = false.obs;
  var isSpeakerOn = false.obs;

  Future<void> acceptCall() async {
    isAcceptingCall.value = true;
    await Future.delayed(const Duration(milliseconds: 500));
    isCallAccepted.value = true;
    isAcceptingCall.value = false;
  }

  void toggleMute() {
    isMuted.value = !isMuted.value;
  }

  void toggleSpeaker() {
    isSpeakerOn.value = !isSpeakerOn.value;
  }

  void endCall() {
    isCallAccepted.value = false;
    isMuted.value = false;
    isSpeakerOn.value = false;
    Get.back();
  }
}