import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:parent_bridge/app/modules/authentication/views/sign_in_view.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/custom_font.dart';
import '../../../../common/widgets/custom_button.dart';

class PasswordResetSuccessfulView extends GetView {
  const PasswordResetSuccessfulView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24).r,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 283.h),

                Image.asset(
                  'assets/images/auth/password_reset_success.png',
                  scale: 3,
                ),

                SizedBox(height: 10.h),

                Text(
                  'Password reset successful!',
                  style: h2.copyWith(
                    color: AppColors.textColor7,
                    fontSize: 30.sp,
                  ),
                ),

                SizedBox(height: 11.h),

                SizedBox(
                  width: 327.w,
                  child: Text(
                    'You can proceed to login with your new password credentials',
                    style: h4.copyWith(
                      color: AppColors.textColor18,
                      fontSize: 16.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: 30.h),

                SizedBox(height: 10.h),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30).r,
                  child: CustomPBButton(
                    text: 'Back to Login',
                    onPressed: () => Get.to(SignInView()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
