import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:parent_bridge/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:parent_bridge/app/modules/authentication/controllers/otp_verifications_controller.dart';
import 'package:parent_bridge/app/modules/authentication/views/new_password_view.dart';

import '../../../../common/appColors.dart';
import '../../../../common/customFont.dart';
import '../../../../common/widgets/customButton.dart';

class OtpVerificationsView extends GetView<OtpVerificationsController> {
  final bool isAuth;
  const OtpVerificationsView({super.key, required this.isAuth});

  @override
  Widget build(BuildContext context) {
    Get.put(OtpVerificationsController());
    final authController = Get.find<AuthenticationController>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24).r,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/auth/parent_bridge_logo.png',
                  scale: 4,
                ),

                SizedBox(height: 10.h),

                Text(
                  'OTP verifications',
                  style: h2.copyWith(
                    color: AppColors.textColor7,
                    fontSize: 30.sp,
                  ),
                ),

                SizedBox(height: 11.h),

                SizedBox(
                  width: 327.w,
                  child: Text(
                    'Enter the verification code we just sent on your email address.',
                    style: h4.copyWith(
                      color: AppColors.textColor18,
                      fontSize: 16.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: 30.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    4,
                    (index) => Container(
                      padding: EdgeInsets.all(1.r),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        gradient: LinearGradient(
                          colors: [
                            AppColors.buttonColor,
                            AppColors.buttonColor2,
                          ],
                        ),
                      ),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: AppColors.clrWhite,
                        ),
                        child: TextField(
                          controller:
                              controller.verificationCodeControllers[index],
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          decoration: const InputDecoration(
                            counterText: '',
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            if (value.length == 1 && index < 3) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10.h),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30).r,
                  child: Obx(
                    () => CustomPBButton(
                      text: authController.isOtpVerifying.value
                          ? 'Verifying...'
                          : 'Send',
                      isLoading: authController.isOtpVerifying.value,
                      onPressed: () {
                        // Get OTP from controllers
                        String otp = controller.verificationCodeControllers
                            .map((c) => c.text)
                            .join();

                        if (isAuth) {
                          // Call verify OTP for signup
                          authController.verifyOTP(otp);
                        } else {
                          // Call verify OTP for password reset
                          authController.verifyPasswordResetOTP(otp);
                        }
                      },
                    ),
                  ),
                ),

                SizedBox(height: 350.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Didn\'t receive code? ',
                      style: h4.copyWith(
                        color: AppColors.textColorHint,
                        fontSize: 16.sp,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Resend',
                        style: h4.copyWith(
                          color: AppColors.switchColorBg,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
