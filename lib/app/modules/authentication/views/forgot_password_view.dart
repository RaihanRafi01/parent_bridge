import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:parent_bridge/app/modules/authentication/views/otp_verifications_view.dart';
import 'package:parent_bridge/app/modules/authentication/views/sign_in_view.dart';

import '../../../../common/appColors.dart';
import '../../../../common/customFont.dart';
import '../../../../common/widgets/customButton.dart';
import '../../../../common/widgets/customTextField.dart';
import '../../home/views/home_view.dart';

class ForgotPasswordView extends GetView {
  final TextEditingController emailController;

  const ForgotPasswordView({
    required this.emailController,
    super.key
  });

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
                  'Forgot password',
                  style: h2.copyWith(
                    color: AppColors.textColor7,
                    fontSize: 30.sp,
                  ),
                ),

                SizedBox(height: 11.h),

                SizedBox(
                  width: 327.w,
                  child: Text(
                    'Don\'t worry! Please enter the email address linked with your account.',
                    style: h4.copyWith(
                      color: AppColors.textColor18,
                      fontSize: 16.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: 30.h),

                CustomTextField(
                  controller: emailController,
                  prefixIcon: 'assets/images/auth/mail_icon.svg', hintText: 'abc@email.com',
                ),

                SizedBox(height: 10.h),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30).r,
                  child: CustomPBButton(
                    text: 'Send',
                    onPressed: () => Get.to(OtpVerificationsView(isAuth: false,)),
                  ),
                ),

                SizedBox(height: 350.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Remember password? ',
                      style: h4.copyWith(
                        color: AppColors.textColorHint,
                        fontSize: 16.sp,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.to(SignInView()),
                      child: Text(
                        'Login',
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
