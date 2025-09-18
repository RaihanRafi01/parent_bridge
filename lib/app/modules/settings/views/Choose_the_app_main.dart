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

class ChooseTheAppMain extends GetView<SignUpProcessController> {
  const ChooseTheAppMain({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpProcessController());

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.arrow_back_outlined),
                ),
                SizedBox(width: 40.h),
                Text(
                  'Choose the App',
                  style: h2.copyWith(fontSize: 30, color: AppColors.txtclr4),
                ),
              ],
            ),
            SizedBox(height: 50.h),
            Container(
              height: 104.h,
              width: 384.w,
              decoration: BoxDecoration(
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
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 4.0, right: 4.0),
                        child: Container(
                          height: 16.h,
                          width: 16.w,
                          decoration: BoxDecoration(
                            color: AppColors.buttonColor4,
                            borderRadius: BorderRadius.circular(100.r),

                            border: Border.all(
                              color: AppColors.white,
                              width: 2.w,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.boxShadowColor51.withAlpha(64),
                                blurRadius: 4.r,
                                offset: Offset(0.w, 4.h),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),

                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Image.asset(
                          'assets/images/sign_up_process/bridge_mode.png',
                          scale: 2,
                        ),
                      ),

                      SizedBox(width: 10.4.w),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'BridgeMode',
                            style: h1.copyWith(
                              color: AppColors.textColor51,
                              fontSize: 20.sp,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Padding(
                            padding: EdgeInsets.all(2.0),
                            child: SizedBox(
                              width: 270.w,
                              height: 34.h,
                              child: Text(
                                "Invite your co-parent to join the app so you can both communicate, coordinate schedules, and manage responsibilities in one place. Just add their name and phone number to get started — we'll send them an invitation.",
                                style: h4.copyWith(
                                  color: AppColors.textColor23,
                                  fontSize: 8.sp,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            Container(
              height: 104.h,
              width: 384.w,
              decoration: BoxDecoration(
                color: AppColors.customBox,
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
              child: Column(
                children: [
                  SizedBox(height: 20.h),

                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(
                          'assets/images/sign_up_process/independent_mode.svg',
                          height: 44.34.h,
                          width: 51.w,
                        ),
                      ),

                      SizedBox(height: 7.4.h),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Independent mode',
                            style: h1.copyWith(
                              color: AppColors.textColor51,
                              fontSize: 20.sp,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Padding(
                            padding: EdgeInsets.all(2.0),
                            child: SizedBox(
                              width: 270.w,
                              height: 37.h,
                              child: Text(
                                "Invite your co-parent to join the app so you can both communicate, coordinate schedules, and manage responsibilities in one place. Just add their name and phone number to get started — we'll send them an invitation.",
                                style: h4.copyWith(
                                  color: AppColors.textColor23,
                                  fontSize: 8.sp,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
