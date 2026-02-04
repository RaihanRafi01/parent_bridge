import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/call/audio_renderer.dart';
import '../controllers/call_controller.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/custom_font.dart';

class IncomingOngoingCallView extends GetView<CallController> {
  const IncomingOngoingCallView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Audio routing (Invisible layer to handle the stream)
          Obx(() => controller.remoteStream.value != null
              ? AudioRenderer(stream: controller.remoteStream.value!)
              : const SizedBox.shrink()),

          // Main UI
          Obx(() => Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.lightPurplePink2, AppColors.customSkyBlue3],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: controller.isCallAccepted.value
                ? _buildOngoingCallUI()
                : _buildIncomingCallUI(),
          )),
        ],
      ),
    );
  }

  Widget _buildIncomingCallUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
            radius: 60.r,
            backgroundImage: const AssetImage("assets/images/auth/img.png")
        ),
        SizedBox(height: 20.h),
        Text("Incoming Call...", style: h2.copyWith(fontSize: 30.sp)),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _actionButton(Icons.call_end, Colors.red, "Decline", controller.endCall),
            _actionButton(
              Icons.call,
              Colors.green,
              "Accept",
              controller.acceptCall,
              isLoading: controller.isAcceptingCall.value,
            ),
          ],
        ),
        SizedBox(height: 80.h),
      ],
    );
  }

  Widget _buildOngoingCallUI() {
    return Column(
      children: [
        SizedBox(height: 80.h),
        CircleAvatar(
            radius: 70.r,
            backgroundImage: const AssetImage("assets/images/auth/img.png")
        ),
        SizedBox(height: 20.h),
        Text("Michael", style: h2.copyWith(fontSize: 32.sp)),

        // Dynamic Timer Display
        Text(
            controller.formatDuration,
            style: TextStyle(
                fontSize: 22.sp,
                color: Colors.black87,
                fontWeight: FontWeight.bold
            )
        ),

        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _iconToggle(
              Icons.volume_up,
              "Speaker",
              controller.isSpeakerOn.value,
              controller.toggleSpeaker,
            ),
            // Centered Large End Button
            _actionButton(
                Icons.call_end,
                Colors.red,
                "End",
                controller.endCall,
                isLarge: true
            ),
            _iconToggle(
              Icons.mic_off,
              "Mute",
              controller.isMuted.value,
              controller.toggleMute,
            ),
          ],
        ),
        SizedBox(height: 80.h),
      ],
    );
  }

  Widget _actionButton(
      IconData icon,
      Color color,
      String label,
      VoidCallback onTap, {
        bool isLoading = false,
        bool isLarge = false,
      }) {
    return Column(
      children: [
        SizedBox(
          width: isLarge ? 85.r : 65.r,
          height: isLarge ? 85.r : 65.r,
          child: FloatingActionButton(
            heroTag: label,
            onPressed: isLoading ? null : onTap,
            backgroundColor: color,
            elevation: 4,
            shape: const CircleBorder(),
            child: isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : Icon(icon, size: isLarge ? 40 : 25, color: Colors.white),
          ),
        ),
        SizedBox(height: 8.h),
        Text(label, style: h4),
      ],
    );
  }

  Widget _iconToggle(IconData icon, String label, bool isActive, VoidCallback onTap) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: isActive ? Colors.white.withOpacity(0.3) : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: onTap,
            icon: Icon(
              icon,
              color: isActive ? Colors.blueAccent : Colors.black87,
              size: 32,
            ),
          ),
        ),
        Text(label, style: h4),
      ],
    );
  }
}