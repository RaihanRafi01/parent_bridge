import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:parent_bridge/app/modules/authentication/controllers/sign_up_controller.dart';
import 'package:parent_bridge/app/modules/authentication/views/sign_in_view.dart';

import '../../../../common/appColors.dart';
import '../../../../common/widgets/customButton.dart';
import '../../../../common/widgets/customTextField.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(SignUpController());

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 23.w),
        child: SingleChildScrollView(
          child: Obx(() {
            return Column(
              children: [
                SizedBox(height: 67.h),

                Image.asset(
                  'assets/images/auth/parent_bridge_logo.png',
                  scale: 4,
                ),

                SizedBox(height: 5.h),

                Text(
                  'Create your account',
                  style: TextStyle(
                    color: AppColors.textColor7,
                    fontFamily: 'lato',
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 12.h),

                SizedBox(
                  width: 303.w,
                  child: Text(
                    'We need some basic information to personalize your experience',
                    style: TextStyle(
                      color: AppColors.textColor18,
                      fontFamily: 'lato',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: 37.h),

                CustomTextField(
                  hintText: 'Enter your full name',
                  prefixIcon: 'assets/images/auth/full_name.png',
                ),

                SizedBox(height: 20.h),

                CustomTextField(
                  hintText: 'abc@email.com',
                  prefixIcon: 'assets/images/auth/mail.png',
                ),

                SizedBox(height: 20.h),

                CustomTextField(
                  hintText: 'Contact number',
                  prefixIcon: 'assets/images/auth/contact_number.png',
                ),

                SizedBox(height: 20.h),

                CustomTextField(
                  hintText: 'Enter your password',
                  prefixIcon: 'assets/images/auth/password.png',
                  suffixIcon: 'assets/images/auth/hidden.png',
                  obscureText: true,
                ),

                SizedBox(height: 20.h),

                CustomTextField(
                  hintText: 'Confirm password',
                  prefixIcon: 'assets/images/auth/password.png',
                  suffixIcon: 'assets/images/auth/hidden.png',
                  obscureText: true,
                ),

                SizedBox(height: 20.h),

                CustomTextField(
                  hintText: 'Enter child\'s full name',
                  prefixIcon: 'assets/images/auth/children.png',
                ),

                SizedBox(height: 20.h),

                CustomTextField(
                  hintText: 'Enter child\'s Ages',
                  prefixIcon: 'assets/images/auth/children.png',
                ),

                SizedBox(height: 20.h),

                GestureDetector(
                  onTap: () {
                    controller.addMoreDropdownActive.value = !controller.addMoreDropdownActive.value;
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.18.w, vertical: 17.h,),
                    decoration: BoxDecoration(
                      color: AppColors.clrWhite,
                      borderRadius: BorderRadius.circular(50.r),
                      border: Border.all(color: AppColors.borderColor,),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.boxShadowColor.withAlpha(36),
                          blurRadius: 12.6.r,
                          offset: Offset(0.w, 8.h),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          spacing: 12.62.w,
                          children: [
                            Image.asset(
                              'assets/images/auth/children.png',
                              scale: 4,
                            ),

                            Text(
                              'Add child’s more',
                              style: TextStyle(
                                color: AppColors.textColorHint,
                                fontFamily: 'lato',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),

                        Image.asset(
                          'assets/images/auth/add_more.png',
                          scale: 4,
                        ),
                      ],
                    ),
                  ),
                ),

                controller.addMoreDropdownActive.value ? SizedBox(height: 12.h) : SizedBox.shrink(),

                controller.addMoreDropdownActive.value ? Container(
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                    color: AppColors.clrWhite,
                    borderRadius: BorderRadius.circular(50.r),
                    border: Border.all(color: AppColors.borderColor,),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.boxShadowColor.withAlpha(36),
                        blurRadius: 12.6.r,
                        offset: Offset(0.w, 8.h),
                      ),
                    ],
                  ),
                  child: Column(
                    spacing: 13.h,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 23.56.w, vertical: 18.33.h),
                        decoration: BoxDecoration(
                          color: AppColors.card3,
                          borderRadius: BorderRadius.circular(43.63.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.boxShadowColor.withAlpha(36),
                              blurRadius: 11.r,
                              offset: Offset(0.w, 6.98.h),
                            ),
                          ],
                          border: Border.all(color: AppColors.borderColor, width: 0.87.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Yes, court mandated',
                              style: TextStyle(
                                color: AppColors.textColorHint,
                                fontFamily: 'lato',
                                fontSize: 12.22.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),

                            GestureDetector(
                              onTap: () {
                                controller.isCourtMandated.value = true;
                                controller.isVoluntaryUse.value = false;
                              },
                              child: Container(
                                padding: EdgeInsets.all(3.5.r),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.radioColor,
                                    width: 0.62.r,
                                  ),
                                ),
                                child: controller.isCourtMandated.value ? Container(
                                  padding: EdgeInsets.all(7.42.r),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.radioColor,
                                  ),
                                ) : SizedBox(width: 14.84.w, height: 14.84.h,),
                              ),
                            )
                          ],
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 23.56.w, vertical: 18.33.h),
                        decoration: BoxDecoration(
                          color: AppColors.card3,
                          borderRadius: BorderRadius.circular(43.63.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.boxShadowColor.withAlpha(36),
                              blurRadius: 11.r,
                              offset: Offset(0.w, 6.98.h),
                            ),
                          ],
                          border: Border.all(color: AppColors.borderColor, width: 0.87.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'No, voluntary use',
                              style: TextStyle(
                                color: AppColors.textColorHint,
                                fontFamily: 'lato',
                                fontSize: 12.22.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),

                            GestureDetector(
                              onTap: () {
                                controller.isCourtMandated.value = false;
                                controller.isVoluntaryUse.value = true;
                              },
                              child: Container(
                                padding: EdgeInsets.all(3.5.r),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.radioColor,
                                    width: 0.62.r,
                                  ),
                                ),
                                child: controller.isVoluntaryUse.value ? Container(
                                  padding: EdgeInsets.all(7.42.r),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.radioColor,
                                  ),
                                ) : SizedBox(width: 14.84.w, height: 14.84.h,),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ) : SizedBox.shrink(),

                SizedBox(height: 20.h),

                CustomTextField(
                  hintText: 'Enter your state',
                  prefixIcon: 'assets/images/auth/location.png',
                ),

                SizedBox(height: 20.h),

                GestureDetector(
                  onTap: () {
                    controller.courtMandatedActive.value = !controller.courtMandatedActive.value;
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.18.w, vertical: 17.h,),
                    decoration: BoxDecoration(
                      color: AppColors.clrWhite,
                      borderRadius: BorderRadius.circular(50.r),
                      border: Border.all(color: AppColors.borderColor,),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.boxShadowColor.withAlpha(36),
                          blurRadius: 12.6.r,
                          offset: Offset(0.w, 8.h),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          spacing: 12.62.w,
                          children: [
                            Image.asset(
                              'assets/images/auth/court.png',
                              scale: 4,
                            ),

                            Text(
                              'Is use of this app court mandated?',
                              style: TextStyle(
                                color: AppColors.textColorHint,
                                fontFamily: 'lato',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),

                        Image.asset(
                          'assets/images/auth/dropdown.png',
                          scale: 4,
                        ),
                      ],
                    ),
                  ),
                ),

                controller.courtMandatedActive.value ? SizedBox(height: 12.h) : SizedBox.shrink(),

                controller.courtMandatedActive.value ? Container(
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                    color: AppColors.clrWhite,
                    borderRadius: BorderRadius.circular(50.r),
                    border: Border.all(color: AppColors.borderColor,),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.boxShadowColor.withAlpha(36),
                        blurRadius: 12.6.r,
                        offset: Offset(0.w, 8.h),
                      ),
                    ],
                  ),
                  child: Column(
                    spacing: 13.h,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 23.56.w, vertical: 18.33.h),
                        decoration: BoxDecoration(
                          color: AppColors.card3,
                          borderRadius: BorderRadius.circular(43.63.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.boxShadowColor.withAlpha(36),
                              blurRadius: 11.r,
                              offset: Offset(0.w, 6.98.h),
                            ),
                          ],
                          border: Border.all(color: AppColors.borderColor, width: 0.87.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Yes, court mandated',
                              style: TextStyle(
                                color: AppColors.textColorHint,
                                fontFamily: 'lato',
                                fontSize: 12.22.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),

                            GestureDetector(
                              onTap: () {
                                controller.isCourtMandated2.value = true;
                                controller.isVoluntaryUse2.value = false;
                              },
                              child: Container(
                                padding: EdgeInsets.all(3.5.r),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.radioColor,
                                    width: 0.62.r,
                                  ),
                                ),
                                child: controller.isCourtMandated2.value ? Container(
                                  padding: EdgeInsets.all(7.42.r),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.radioColor,
                                  ),
                                ) : SizedBox(width: 14.84.w, height: 14.84.h,),
                              ),
                            )
                          ],
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 23.56.w, vertical: 18.33.h),
                        decoration: BoxDecoration(
                          color: AppColors.card3,
                          borderRadius: BorderRadius.circular(43.63.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.boxShadowColor.withAlpha(36),
                              blurRadius: 11.r,
                              offset: Offset(0.w, 6.98.h),
                            ),
                          ],
                          border: Border.all(color: AppColors.borderColor, width: 0.87.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'No, voluntary use',
                              style: TextStyle(
                                color: AppColors.textColorHint,
                                fontFamily: 'lato',
                                fontSize: 12.22.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),

                            GestureDetector(
                              onTap: () {
                                controller.isCourtMandated2.value = false;
                                controller.isVoluntaryUse2.value = true;
                              },
                              child: Container(
                                padding: EdgeInsets.all(3.5.r),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.radioColor,
                                    width: 0.62.r,
                                  ),
                                ),
                                child: controller.isVoluntaryUse2.value ? Container(
                                  padding: EdgeInsets.all(7.42.r),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.radioColor,
                                  ),
                                ) : SizedBox(width: 14.84.w, height: 14.84.h,),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ) : SizedBox.shrink(),

                SizedBox(height: 20.h),

                CustomTextField(
                  hintText: 'Select your role.',
                  prefixIcon: 'assets/images/auth/adoption.png',
                  suffixIcon: 'assets/images/auth/dropdown.png',
                ),

                SizedBox(height: 25.h),

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

                    SizedBox(width: 5.5.w),

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

                SizedBox(height: 27.h),

                CustomPBButton(text: 'Sign Up'),

                SizedBox(height: 14.h),

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

                SizedBox(height: 32.h),

                CustomGoogleAppleButton(
                  text: 'Sign in with Google',
                  icon: 'assets/images/auth/google.png',
                ),

                SizedBox(height: 16.h),

                CustomGoogleAppleButton(
                  text: 'Sign in with Apple',
                  icon: 'assets/images/auth/apple.png',
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
            );
          }),
        ),
      ),
    );
  }
}
