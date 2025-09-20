import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:parent_bridge/app/modules/settings/views/Choose_the_app.dart';
import 'package:parent_bridge/common/appColors.dart';
import 'package:parent_bridge/common/customFont.dart';
import '../../../../common/widgets/customButton.dart';

enum AppMode { bridge, independent }

class ChooseTheAppMain extends GetView<SignUpProcessController> {
  const ChooseTheAppMain({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpProcessController());

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16).r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: Get.back,
                    child: SvgPicture.asset('assets/images/common/back_icon.svg',width: 40.w,),
                  ),
                  Text(
                    'Choose the App',
                    style: h2.copyWith(fontSize: 30, color: AppColors.txtclr4),
                  ),
                  SizedBox(width: 40.h),
                ],
              ),
            ),
            SizedBox(height: 50.h),

            /// ---------------- Bridge Mode ----------------
            Obx(() {
              final isSelected =
                  controller.selectedMode.value == AppMode.bridge;
              return GestureDetector(
                onTap: () => controller.selectedMode.value = AppMode.bridge,
                child: Container(
                  height: 104.h,
                  width: 384.w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        isSelected ? AppColors.buttonColor : AppColors.clrWhite,
                        isSelected
                            ? AppColors.buttonColor2
                            : AppColors.clrWhite,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(4.75.r),
                    border: Border.all(color: AppColors.customBox),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.boxShadowColor51.withAlpha(64),
                        blurRadius: 4.r,
                        offset: Offset(0.w, 4.h),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Image.asset(
                              'assets/images/sign_up_process/bridge_mode.png',
                              scale: 2,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(right: 20.w),
                              // space for dot
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'BridgeMode',
                                    style: h1.copyWith(
                                      color: AppColors.textColor51,
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 270.w,
                                    height: 47.h,
                                    child: Text(
                                      "Invite your co-parent to join the app so you can both communicate,"
                                      "coordinate schedules, and manage responsibilities in one place. "
                                      "Just add their name and phone number to get started — we'll send "
                                      "them an invitation.",
                                      style: h4.copyWith(
                                        color: AppColors.textColor23,
                                        fontSize: 8.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (isSelected)
                        Positioned(
                          top: 4.h,
                          right: 4.w,
                          child: Container(
                            height: 14.h,
                            width: 14.w,
                            decoration: BoxDecoration(
                              color: AppColors.buttonColor4,
                              borderRadius: BorderRadius.circular(100.r),
                              border: Border.all(
                                color: AppColors.white,
                                width: 2.w,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.boxShadowColor51.withAlpha(
                                    64,
                                  ),
                                  blurRadius: 4.r,
                                  offset: Offset(0.w, 4.h),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }),

            SizedBox(height: 20.h),

            /// ---------------- Independent Mode ----------------
            Obx(() {
              final isSelected =
                  controller.selectedMode.value == AppMode.independent;
              return GestureDetector(
                onTap: () =>
                    controller.selectedMode.value = AppMode.independent,
                child: Container(
                  height: 104.h,
                  width: 394.w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        isSelected ? AppColors.buttonColor : AppColors.clrWhite,
                        isSelected
                            ? AppColors.buttonColor2
                            : AppColors.clrWhite,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(4.75.r),
                    border: Border.all(color: AppColors.customBox),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.boxShadowColor51.withAlpha(64),
                        blurRadius: 4.r,
                        offset: Offset(0.w, 4.h),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(12.0),
                            child: SvgPicture.asset(
                              'assets/images/sign_up_process/independent_mode.svg',
                              height: 44.34.h,
                              width: 51.w,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(right: 20.w),
                              // space for dot
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Independent mode',
                                    style: h1.copyWith(
                                      color: AppColors.textColor51,
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 270.w,
                                    height: 37.h,
                                    child: Text(
                                      "Invite your co-parent to join the app so you can both communicate, "
                                      "coordinate schedules, and manage responsibilities in one place. "
                                      "Just add their name and phone number to get started — we'll send "
                                      "them an invitation.",
                                      style: h4.copyWith(
                                        color: AppColors.textColor23,
                                        fontSize: 8.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (isSelected)
                        Positioned(
                          top: 4.h,
                          right: 4.w,
                          child: Container(
                            height: 14.h,
                            width: 14.w,
                            decoration: BoxDecoration(
                              color: AppColors.buttonColor4,
                              borderRadius: BorderRadius.circular(100.r),
                              border: Border.all(
                                color: AppColors.white,
                                width: 2.w,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.boxShadowColor51.withAlpha(
                                    64,
                                  ),
                                  blurRadius: 4.r,
                                  offset: Offset(0.w, 4.h),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }),

            SizedBox(height: 450.h),
            InkWell(
              onTap: () {
               // Get.to(ChooseTheApp());
              },
              child: Container(
                width: 387.w,
                height: 52.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.appColor, AppColors.appColor2],
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Text(
                    'Update',
                    style: h1.copyWith(fontSize: 18, color: AppColors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ---------------- Controller ----------------
class SignUpProcessController extends GetxController {
  var selectedMode = AppMode.bridge.obs; // default selected
}
