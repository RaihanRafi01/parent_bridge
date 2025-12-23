import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:parent_bridge/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:parent_bridge/app/modules/authentication/controllers/sign_up_controller.dart';
import 'package:parent_bridge/app/modules/authentication/views/sign_in_view.dart';

import '../../../../common/appColors.dart';
import '../../../../common/customFont.dart';
import '../../../../common/widgets/customButton.dart';
import '../../../../common/widgets/customTextField.dart';

class SignUpView extends GetView<AuthenticationController> {
  const SignUpView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(SignUpController());

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

                SizedBox(height: 5.h),

                Text(
                  'Create your account',
                  style: h2.copyWith(
                    color: AppColors.textColor7,
                    fontSize: 30.sp,
                  ),
                ),

                SizedBox(height: 12.h),

                SizedBox(
                  width: 303.w,
                  child: Text(
                    'We need some basic information to personalize your experience',
                    style: h4.copyWith(
                      color: AppColors.textColor18,
                      fontSize: 16.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: 20.h),

                CustomTextField(
                  controller: controller.emailController,
                  hintText: 'abc@email.com',
                  prefixIcon: 'assets/images/auth/mail_icon.svg',
                ),

                Obx(
                  () => CustomTextField(
                    controller: controller.passwordController,
                    hintText: 'Enter your password',
                    prefixIcon: 'assets/images/auth/lock_icon.svg',
                    suffixIcon: 'assets/images/auth/eye_close_icon.svg',
                    isPassword: true,
                    onSuffixTap: () => controller.togglePasswordVisibility(),
                    obscureText: !controller.isPasswordVisible.value,
                  ),
                ),

                Obx(
                  () => CustomTextField(
                    controller: controller.confirmPasswordController,
                    hintText: 'Confirm password',
                    prefixIcon: 'assets/images/auth/lock_icon.svg',
                    suffixIcon: 'assets/images/auth/eye_close_icon.svg',
                    isPassword: true,
                    onSuffixTap: () =>
                        controller.toggleConfirmPasswordVisibility(),
                    obscureText: !controller.isConfirmPasswordVisible.value,
                  ),
                ),

                Row(
                  children: [
                    Obx(
                      () => Transform.scale(
                        scale: 0.7, // Scale down the switch to make it smaller
                        child: Switch(
                          value: controller.rememberMe.value,
                          onChanged: (value) => controller.toggleRememberMe(),
                          activeThumbColor: AppColors.clrWhite,
                          activeTrackColor: AppColors.appColor,
                          inactiveTrackColor: AppColors.appColor.withOpacity(
                            .5,
                          ),
                          inactiveThumbColor: AppColors.clrWhite,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ),
                    Text(
                      'Remember Me',
                      style: h4.copyWith(
                        color: AppColors.textColor2,
                        fontSize: 12.84.sp,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 27.h),

                Obx(
                  () => CustomPBButton(
                    text: controller.isSignUpLoading.value
                        ? 'Creating Account...'
                        : 'Continue',
                    onPressed: controller.isSignUpLoading.value
                        ? () {}
                        : () => controller.signUp(),
                  ),
                ),

                SizedBox(height: 14.h),

                SvgPicture.asset('assets/images/auth/or_continue_with.svg'),

                SizedBox(height: 32.h),

                CustomGoogleAppleButton(
                  text: 'Sign in with Google',
                  icon: 'assets/images/auth/google_icon.svg',
                ),

                SizedBox(height: 16.h),

                CustomGoogleAppleButton(
                  text: 'Sign in with Apple',
                  icon: 'assets/images/auth/apple_icon.svg',
                ),

                SizedBox(height: 60.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(
                        color: AppColors.textColorHint,
                        fontFamily: 'lato',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    GestureDetector(
                      onTap: () => Get.to(SignInView()),
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: AppColors.switchColorBg,
                          fontFamily: 'lato',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 64.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
