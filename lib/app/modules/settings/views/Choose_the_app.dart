import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:parent_bridge/app/modules/sign_up_process/views/bridge_mode_view.dart';
import 'package:parent_bridge/app/modules/sign_up_process/views/independent_mode_view.dart';
import 'package:parent_bridge/common/appColors.dart';
import 'package:parent_bridge/common/customFont.dart';
import 'package:parent_bridge/common/widgets/customButton.dart';

import '../../sign_up_process/controllers/sign_up_process_controller.dart';

class ChooseTheApp extends GetView<SignUpProcessController> {
  const ChooseTheApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpProcessController());

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          child: Center(
            child: Obx(() {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Choose How You Want to Use the App',
                    style: h1.copyWith(
                      color: AppColors.textColor51,
                      fontSize: 30.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 22.h),

                  Text(
                    'Select the option that best fits your co-parenting situation. You can always change it later.',
                    style: h4.copyWith(
                      color: AppColors.textColor52,
                      fontSize: 14.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 30.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.isBridgeMode.value = false;
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 9.w,
                            vertical: 16.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.75.r),
                            gradient: LinearGradient(
                              colors: [
                                controller.isBridgeMode.value
                                    ? AppColors.clrWhite
                                    : AppColors.buttonColor,
                                controller.isBridgeMode.value
                                    ? AppColors.clrWhite
                                    : AppColors.buttonColor2,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            border: Border.all(color: AppColors.borderColor51),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.boxShadowColor51.withAlpha(64),
                                blurRadius: 4.r,
                                offset: Offset(0.w, 4.h),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                'assets/images/sign_up_process/independent_mode.svg',
                              ),

                              SizedBox(height: 7.4.h),

                              Text(
                                'Independent mode',
                                style: h1.copyWith(
                                  color: AppColors.textColor51,
                                  fontSize: 14.sp,
                                ),
                              ),

                              SizedBox(height: 4.h),

                              SizedBox(
                                width: 173.w,
                                child: Text(
                                  'Use the app on your own to stay organized, track important information, and prepare for better communication. You\'ll receive a secure number to connect with our support team when needed — no need to involve your co-parent right away.',
                                  style: h4.copyWith(
                                    color: controller.isBridgeMode.value
                                        ? AppColors.textColor53
                                        : AppColors.textColor51,
                                    fontSize: 8.sp,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          controller.isBridgeMode.value = true;
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 9.w,
                            vertical: 16.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.75.r),
                            gradient: LinearGradient(
                              colors: [
                                controller.isBridgeMode.value
                                    ? AppColors.buttonColor
                                    : AppColors.clrWhite,
                                controller.isBridgeMode.value
                                    ? AppColors.buttonColor2
                                    : AppColors.clrWhite,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            border: Border.all(color: AppColors.borderColor51),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.boxShadowColor51.withAlpha(64),
                                blurRadius: 4.r,
                                offset: Offset(0.w, 4.h),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/sign_up_process/bridge_mode.png',
                                scale: 4,
                              ),

                              SizedBox(height: 7.4.h),

                              Text(
                                'Bridge mode',
                                style: h1.copyWith(
                                  color: AppColors.textColor51,
                                  fontSize: 14.sp,
                                ),
                              ),

                              SizedBox(height: 4.h),

                              SizedBox(
                                width: 173.w,
                                child: Text(
                                  'Invite your co-parent to join the app so you can both communicate, coordinate schedules, and manage responsibilities in one place. Just add their name and phone number to get started — we\'ll send them an invitation.',
                                  style: h4.copyWith(
                                    color: controller.isBridgeMode.value
                                        ? AppColors.textColor51
                                        : AppColors.textColor53,
                                    fontSize: 8.sp,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 33.h),

                  CustomPBButton(
                    text: 'Set Up Together',
                    onPressed: () {
                      if (controller.isBridgeMode.value) {
                        Get.to(() => const BridgeModeView());
                      } else {
                        Get.to(() => const IndependentModeView());
                      }
                    },
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
