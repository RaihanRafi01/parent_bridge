import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:parent_bridge/common/customFont.dart'; // আপনার কাস্টম ফন্ট ফাইল

import '../../../../common/appColors.dart';
import '../controllers/call_controller.dart';

class IncomingOngoingCallView extends StatelessWidget {
  const IncomingOngoingCallView({super.key});

  @override
  Widget build(BuildContext context) {
    final CallController controller = Get.put(CallController());

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.lightPurplePink2, AppColors.customSkyBlue3],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Obx(() {
          return controller.isCallAccepted.value
              ? _buildOngoingCallUI(controller)
              : _buildIncomingCallUI(controller);
        }),
      ),
    );
  }

  Widget _buildOngoingCallUI(CallController controller) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(top: 40.h, left: 16.w),
            child: IconButton(
              onPressed: controller.endCall,
              icon: const Icon(Icons.arrow_back),
            ),
          ),
        ),
        SizedBox(height: 60.h),
        Center(
          child: CircleAvatar(
            radius: 70.r,
            backgroundImage: const AssetImage("assets/images/auth/img.png"),
          ),
        ),
        SizedBox(height: 30.h),
        Text(
          "Michael",
          style: h2.copyWith(fontSize: 41.sp, color: AppColors.txtclr5),
        ),
        SizedBox(height: 8.h),
        Text(
          "8:30",
          style: h2.copyWith(fontSize: 24.sp, color: AppColors.txtclr5),
        ),
        const Spacer(),
        Padding(
          padding: EdgeInsets.only(bottom: 90.0.h),
          child: SizedBox(
            height: 160.h,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  bottom: 0,
                  left: 40.w,
                  right: 40.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => _buildSmallActionButton(
                          asset: "assets/svg/speaker.svg",
                          label: "Speaker",
                          onPressed: controller.toggleSpeaker,
                          isActive: controller.isSpeakerOn.value,
                        ),
                      ),
                      Obx(
                        () => _buildSmallActionButton(
                          asset: "assets/svg/speaker2.svg",
                          label: "Speaker",
                          onPressed: controller.toggleMute,
                          isActive: controller.isMuted.value,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  child: _buildEndCallButton(onPressed: controller.endCall),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIncomingCallUI(CallController controller) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(top: 40.h, left: 16.w),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.blackactive),
              onPressed: Get.back,
            ),
          ),
        ),
        SizedBox(height: 60.h),
        Center(
          child: Container(
            padding: EdgeInsets.all(15.r),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0x14000000),
            ),
            child: Container(
              padding: EdgeInsets.all(15.r),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0x19000000),
              ),
              child: CircleAvatar(
                radius: 55.r,
                backgroundColor: AppColors.clrWhite,
                child: CircleAvatar(
                  radius: 55.r,
                  backgroundImage: const AssetImage(
                    "assets/images/auth/img.png",
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 30.h),
        Text(
          "Incoming Call...",
          textAlign: TextAlign.center,
          style: h2.copyWith(fontSize: 41.sp, color: AppColors.txtclr5),
        ),
        const Spacer(),
        Padding(
          padding: EdgeInsets.only(bottom: 40.0.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildDeclineButton(onPressed: controller.endCall),
              Obx(
                () => _buildAcceptButton(
                  onPressed: controller.isAcceptingCall.value
                      ? null
                      : controller.acceptCall,
                  isLoading: controller.isAcceptingCall.value,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDeclineButton({required VoidCallback onPressed}) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(15.0.r),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xff0909091a),
          ),
          child: SizedBox(
            height: 70.r,
            width: 70.r,
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: onPressed,
              shape: const CircleBorder(),
              child: Icon(Icons.call_end, size: 30.sp, color: AppColors.white),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          "Decline",
          style: h2.copyWith(color: AppColors.txtclr5, fontSize: 14.sp),
        ),
      ],
    );
  }

  Widget _buildAcceptButton({VoidCallback? onPressed, bool isLoading = false}) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(15.0.r),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.crklclr,
          ),
          child: SizedBox(
            height: 70.r,
            width: 70.r,
            child: FloatingActionButton(
              backgroundColor: Colors.green,
              onPressed: onPressed,
              shape: const CircleBorder(),
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Icon(Icons.call, size: 30.sp, color: Colors.white),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          "Accept",
          style: h2.copyWith(color: AppColors.txtclr5, fontSize: 14.sp),
        ),
      ],
    );
  }

  Widget _buildEndCallButton({required VoidCallback onPressed}) {
    return Container(
      padding: EdgeInsets.all(15.0.r),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.crklclr,
      ),
      child: SizedBox(
        height: 80.r,
        width: 80.r,
        child: FloatingActionButton(
          backgroundColor: AppColors.declineclr,
          onPressed: onPressed,
          shape: const CircleBorder(),
          child: Icon(Icons.call_end, size: 35.sp),
        ),
      ),
    );
  }

  Widget _buildSmallActionButton({
    required String asset,
    required String label,
    required VoidCallback onPressed,
    bool isActive = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(15.0.r),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xff0909091a),
          ),
          child: SizedBox(
            height: 50.r,
            width: 50.r,
            child: FloatingActionButton(
              backgroundColor: isActive
                  ? Colors.white.withOpacity(0.3)
                  : const Color(0x29FFFFFF),
              onPressed: onPressed,
              shape: const CircleBorder(),
              elevation: 0,
              child: SvgPicture.asset(asset, height: 25.h, width: 25.w),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          style: h2.copyWith(color: AppColors.txtclr5, fontSize: 14.sp),
        ),
      ],
    );
  }
}
