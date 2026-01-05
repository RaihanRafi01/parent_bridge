import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:parent_bridge/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:parent_bridge/app/modules/home/views/home_view.dart';
import 'package:parent_bridge/common/widgets/customButton.dart';

import '../../../../common/appColors.dart';
import '../../../../common/customFont.dart';

class IndependentModeView extends GetView<AuthenticationController> {
  const IndependentModeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50.h),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 25.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  gradient: LinearGradient(
                    colors: [AppColors.buttonColor, AppColors.buttonColor2],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  spacing: 8.h,
                  children: [
                    SvgPicture.asset(
                      'assets/images/sign_up_process/independent_mode.svg',
                    ),

                    Text(
                      'Independent Mode',
                      style: h1.copyWith(
                        color: AppColors.clrWhite,
                        fontSize: 20.sp,
                      ),
                    ),

                    Text(
                      'Add your co-parent to start communicating. You can call them right away, and they\'ll get an invitation to join for full app features like shared calendars and filtered messaging.',
                      style: h4.copyWith(
                        color: AppColors.clrWhite,
                        fontSize: 12.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 89.h),

              Container(
                padding: EdgeInsets.all(19.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColors.card52,
                ),
                child: Column(
                  spacing: 20.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Assigned Number:',
                      style: h3.copyWith(
                        color: AppColors.textColor51,
                        fontSize: 16.63.sp,
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 291.6587829589844.w,
                          padding: EdgeInsets.all(14.r),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.41.r),
                            color: AppColors.card53,
                            border: Border.all(
                              color: AppColors.borderColor52,
                              width: 0.84.r,
                            ),
                          ),
                          child: Text(
                            controller
                                    .onboardingResponse
                                    ?.data
                                    .twilioPhoneNumber ??
                                '+1 (000) 000-0000',
                            style: h3.copyWith(
                              color: AppColors.textColor51,
                              fontSize: 13.33.sp,
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            final phoneNumber =
                                controller
                                    .onboardingResponse
                                    ?.data
                                    .twilioPhoneNumber ??
                                '';
                            if (phoneNumber.isNotEmpty) {
                              Clipboard.setData(
                                ClipboardData(text: phoneNumber),
                              );
                              Get.snackbar(
                                'Copied',
                                'Phone number copied to clipboard',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppColors.appColor.withOpacity(
                                  0.9,
                                ),
                                colorText: AppColors.clrWhite,
                                duration: const Duration(seconds: 2),
                              );
                            }
                          },
                          child: Container(
                            width: 51.w,
                            padding: EdgeInsets.symmetric(
                              horizontal: 18.w,
                              vertical: 15.h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.58.r),
                              color: AppColors.card53,
                              border: Border.all(
                                color: AppColors.borderColor52,
                                width: 0.86.r,
                              ),
                            ),
                            child: SvgPicture.asset(
                              'assets/images/sign_up_process/copy.svg',
                            ),
                          ),
                        ),
                      ],
                    ),

                    Text(
                      'Give this number to your co-parent for texting. All communication will be filtered and recorded through the app for your protection.',
                      style: h4.copyWith(
                        color: AppColors.textColor51,
                        fontSize: 8.58.sp,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 52.h),

              CustomPBButton(
                text: 'Continue',
                onPressed: () => Get.offAll(() => const HomeView()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
