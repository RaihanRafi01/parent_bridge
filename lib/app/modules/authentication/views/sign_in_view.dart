import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:parent_bridge/app/modules/authentication/views/forgot_password_view.dart';
import 'package:parent_bridge/app/modules/authentication/views/sign_up_view.dart';
import 'package:parent_bridge/app/modules/home/views/home_view.dart';
import 'package:parent_bridge/common/widgets/customButton.dart';
import 'package:parent_bridge/common/widgets/customTextField.dart';

import '../../../../common/appColors.dart';
import '../../../../common/customFont.dart';
import '../controllers/authentication_controller.dart';

class SignInView extends GetView<AuthenticationController> {
  const SignInView({super.key});
  @override
  Widget build(BuildContext context) {
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
                  'Welcome Back',
                  style: h2.copyWith(
                    color: AppColors.textColor7,
                    fontSize: 30.sp,
                  ),
                ),
        
                SizedBox(height: 11.h),
        
                Text(
                  'Sign in to continue your co-parenting journey',
                  style: h4.copyWith(
                    color: AppColors.textColor18,
                    fontSize: 16.sp,
                  ),
                ),
        
                SizedBox(height: 30.h),
        
                CustomTextField(
                  controller: controller.emailController,
                  prefixIcon: 'assets/images/auth/mail_icon.svg', hintText: 'abc@email.com',
                ),

            Obx(() => CustomTextField(
                  controller: controller.passwordController,
                  prefixIcon: 'assets/images/auth/lock_icon.svg',
                  suffixIcon: 'assets/images/auth/eye_close_icon.svg',
                  isPassword: true, hintText: 'Enter your password',
                  onSuffixTap: () =>
                      controller.togglePasswordVisibility(),
                  obscureText: !controller.isPasswordVisible.value,
                )),
        
                SizedBox(height: 10.h),
        
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Obx(() => Transform.scale(
                          scale: 0.7, // Scale down the switch to make it smaller
                          child: Switch(
                            value: controller.rememberMe.value,
                            onChanged: (value) =>
                                controller.toggleRememberMe(),
                            activeColor: AppColors.clrWhite,
                            activeTrackColor: AppColors.appColor,
                            inactiveTrackColor:
                            AppColors.appColor.withOpacity(.5),
                            inactiveThumbColor: AppColors.clrWhite,
                            materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                          ),
                        )),
                        Text(
                          'Remember Me',
                          style: h4.copyWith(
                            color: AppColors.textColor2,
                            fontSize: 12.84.sp,
                          ),
                        ),
                      ],
                    ),
        
                    GestureDetector(
                      onTap: () => Get.to(
                          ForgotPasswordView(
                            emailController: controller.emailController,
                          )
                      ),
                      child: Text(
                        'Forgot Password?',
                        style: h2.copyWith(
                          color: AppColors.switchColorBg,
                          fontSize: 12.84.sp,
                        ),
                      ),
                    ),
                  ],
                ),
        
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30).r,
                  child: CustomPBButton(text: 'Log In', onPressed: () => Get.to(HomeView()),),
                ),

        
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
        
                SizedBox(height: 50.h),
        
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don’t have an account?  ',
                      style: h3.copyWith(
                        color: AppColors.textColorHint,
                        fontSize: 16.sp,
                      ),
                    ),
        
                    GestureDetector(
                      onTap: () => Get.to(SignUpView()),
                      child: Text(
                        'Sign Up',
                        style: h1.copyWith(
                          color: AppColors.switchColorBg,
                          fontSize: 16.sp,
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
