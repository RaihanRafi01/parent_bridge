import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:parent_bridge/app/modules/home/views/home_view.dart';
import 'package:parent_bridge/common/widgets/customButton.dart';
import 'package:parent_bridge/common/widgets/customTextField.dart';

import '../../../../common/appColors.dart';

class SignInView extends GetView {
  const SignInView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 23.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 101.h,),
          
              Image.asset(
                'assets/images/auth/parent_bridge_logo.png',
                scale: 4,
              ),
          
              SizedBox(height: 20.h,),
          
              Text(
                'Welcome Back',
                style: TextStyle(
                  color: AppColors.textColor7,
                  fontFamily: 'lato',
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
          
              SizedBox(height: 11.h,),
          
              Text(
                'Sign in to continue your co-parenting journey',
                style: TextStyle(
                  color: AppColors.textColor18,
                  fontFamily: 'lato',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
          
              SizedBox(height: 52.h,),
          
              CustomTextField(
                hintText: 'Enter your email',
                prefixIcon: 'assets/images/auth/mail.png',
              ),
          
              SizedBox(height: 22.h,),
          
              CustomTextField(
                hintText: 'Enter your password',
                prefixIcon: 'assets/images/auth/password.png',
                suffixIcon: 'assets/images/auth/hidden.png',
              ),
          
              SizedBox(height: 20.h,),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          top: 3.58.h,
                          bottom: 3.58.h,
                          left: 13.94.w,
                          right: 3.58.w,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(87.12.r),
                          color: AppColors.switchColorBg,
                        ),
                        child: Container(
                          padding: EdgeInsets.all(6.9694.r),
                          decoration: BoxDecoration(
                            color: AppColors.clrWhite,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
          
                      SizedBox(width: 5.5.w,),
          
                      Text(
                        'Remember Me',
                        style: TextStyle(
                          color: AppColors.textColor2,
                          fontFamily: 'lato',
                          fontSize: 12.84.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
          
                  Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: AppColors.switchColorBg,
                      fontFamily: 'lato',
                      fontSize: 12.84.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
          
              SizedBox(height: 43.h,),
          
              CustomPBButton(text: 'Log In',),
          
              SizedBox(height: 32.h,),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 2.w,
                children: [
                  Image.asset(
                    'assets/images/auth/or_continue_with_left.png',
                    scale: 4,
                  ),
          
                  Text(
                    'Or continue with',
                    style: TextStyle(
                      color: AppColors.textColor19,
                      fontFamily: 'lato',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          
                  Image.asset(
                    'assets/images/auth/or_continue_with_right.png',
                    scale: 4,
                  ),
                ],
              ),
          
              SizedBox(height: 32.h,),
          
              CustomGoogleAppleButton(text: 'Sign in with Google', icon: 'assets/images/auth/google.png',),
          
              SizedBox(height: 16.h,),
          
              CustomGoogleAppleButton(text: 'Sign in with Apple', icon: 'assets/images/auth/apple.png',),

              SizedBox(height: 69.h,),

              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Don’t have an account? ',
                      style: TextStyle(
                        color: AppColors.textColorHint,
                        fontFamily: 'lato',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      )
                    ),

                    TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(
                          color: AppColors.switchColorBg,
                          fontFamily: 'lato',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        )
                    ),
                  ]
                ),
              ),

              SizedBox(height: 64.h,),
            ],
          ),
        ),
      ),
    );
  }
}
