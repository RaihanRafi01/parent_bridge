import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:parent_bridge/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:parent_bridge/app/modules/authentication/controllers/sign_up_controller.dart';
import 'package:parent_bridge/app/modules/authentication/views/sign_in_view.dart';
import 'package:parent_bridge/app/modules/sign_up_process/views/sign_up_process_view.dart';

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
            child: Obx(() {
              return Column(
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
                    controller: controller.nameController,
                    hintText: 'Enter your full name',
                    prefixIcon: 'assets/images/auth/user_icon.svg',
                  ),
        
                  CustomTextField(
                    controller: controller.emailController,
                    hintText: 'abc@email.com',
                    prefixIcon: 'assets/images/auth/mail_icon.svg',
                  ),
        
        
                  CustomTextField(
                    controller: controller.phoneController,
                    hintText: 'Contact number',
                    prefixIcon: 'assets/images/auth/phone_icon.svg',
                  ),


              Obx(() => CustomTextField(
                    controller: controller.passwordController,
                    hintText: 'Enter your password',
                    prefixIcon: 'assets/images/auth/lock_icon.svg',
                    suffixIcon: 'assets/images/auth/eye_close_icon.svg',
                    isPassword: true,
                    onSuffixTap: () =>
                    controller.togglePasswordVisibility(),
                    obscureText: !controller.isPasswordVisible.value,
                  )),


              Obx(() =>CustomTextField(
                    controller: controller.confirmPasswordController,
                    hintText: 'Confirm password',
                    prefixIcon: 'assets/images/auth/lock_icon.svg',
                    suffixIcon: 'assets/images/auth/eye_close_icon.svg',
                    isPassword: true,
                    onSuffixTap: () =>
                    controller.toggleConfirmPasswordVisibility(),
                    obscureText: !controller.isConfirmPasswordVisible.value,
                  )),
        
                  CustomTextField(
                    controller: controller.childNameController,
                    hintText: 'Enter child\'s full name',
                    prefixIcon: 'assets/images/auth/children_icon.svg',
                  ),
        
        
                  CustomTextField(
                    controller: controller.childAgeController,
                    hintText: 'Enter child\'s Ages',
                    prefixIcon: 'assets/images/auth/children_icon.svg',
                  ),
        
        
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
                              SvgPicture.asset('assets/images/auth/children_icon.svg'),
        
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

                          SvgPicture.asset('assets/images/auth/more_icon.svg'),
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
                      children: [
                        CustomTextField(hintText: 'Child name', controller: controller.childNameController,prefixIcon: 'assets/images/auth/children_icon.svg',),
                        CustomTextField(hintText: 'Child age', controller: controller.childAgeController,prefixIcon: 'assets/images/auth/children_icon.svg',),
                      ],
                    ),
                  ) : SizedBox.shrink(),
        
                  SizedBox(height: 20.h),
        
                  CustomTextField(
                    controller: controller.sateController,
                    hintText: 'Enter your state',
                    prefixIcon: 'assets/images/auth/map_icon.svg',
                  ),
        
                  SizedBox(height: 20.h),

                  // ... (Previous code remains unchanged until the "Court Mandated" section)

                  GestureDetector(
                    onTap: () {
                      controller.courtMandatedActive.value = !controller.courtMandatedActive.value;
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.18.w, vertical: 17.h),
                      decoration: BoxDecoration(
                        color: AppColors.clrWhite,
                        borderRadius: BorderRadius.circular(50.r),
                        border: Border.all(color: AppColors.borderColor),
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
                              SvgPicture.asset('assets/images/auth/court_icon.svg'),
                              Text(
                                'Is use of this app court mandated?',
                                style: h4.copyWith(
                                  color: AppColors.textColorHint,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                          SvgPicture.asset('assets/images/auth/dropdown_icon.svg'),
                        ],
                      ),
                    ),
                  ),

                  Obx(() => controller.courtMandatedActive.value
                      ? Container(
                    padding: EdgeInsets.all(20.r),
                    decoration: BoxDecoration(
                      color: AppColors.clrWhite,
                      borderRadius: BorderRadius.circular(50.r),
                      border: Border.all(color: AppColors.borderColor),
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
                        GestureDetector(
                          onTap: () {
                            controller.isCourtMandated2.value = true;
                            controller.isVoluntaryUse2.value = false;
                          },
                          child: Container(
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
                                Container(
                                  padding: EdgeInsets.all(3.5.r),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.radioColor,
                                      width: 0.62.r,
                                    ),
                                  ),
                                  child: controller.isCourtMandated2.value
                                      ? Container(
                                    padding: EdgeInsets.all(7.42.r),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.radioColor,
                                    ),
                                  )
                                      : SizedBox(width: 14.84.w, height: 14.84.h),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.isCourtMandated2.value = false;
                            controller.isVoluntaryUse2.value = true;
                          },
                          child: Container(
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
                                Container(
                                  padding: EdgeInsets.all(3.5.r),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.radioColor,
                                      width: 0.62.r,
                                    ),
                                  ),
                                  child: controller.isVoluntaryUse2.value
                                      ? Container(
                                    padding: EdgeInsets.all(7.42.r),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.radioColor,
                                    ),
                                  )
                                      : SizedBox(width: 14.84.w, height: 14.84.h),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                      : SizedBox.shrink()),

                  SizedBox(height: 20.h),

// Select Role Section
                  GestureDetector(
                    onTap: () {
                      controller.roleActive.value = !controller.roleActive.value;
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.18.w, vertical: 17.h),
                      decoration: BoxDecoration(
                        color: AppColors.clrWhite,
                        borderRadius: BorderRadius.circular(50.r),
                        border: Border.all(color: AppColors.borderColor),
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
                              SvgPicture.asset('assets/images/auth/role_icon.svg'),
                              Text(
                                'Select your role',
                                style: h4.copyWith(
                                  color: AppColors.textColorHint,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                          SvgPicture.asset('assets/images/auth/dropdown_icon.svg'),
                        ],
                      ),
                    ),
                  ),

                  Obx(() => controller.roleActive.value
                      ? Container(
                    padding: EdgeInsets.all(20.r),
                    decoration: BoxDecoration(
                      color: AppColors.clrWhite,
                      borderRadius: BorderRadius.circular(50.r),
                      border: Border.all(color: AppColors.borderColor),
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
                        GestureDetector(
                          onTap: () {
                            controller.role1.value = true;
                            controller.role2.value = false;
                          },
                          child: Container(
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
                                  'Mom',
                                  style: h4.copyWith(
                                    color: AppColors.textColorHint,
                                    fontSize: 12.22.sp,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(3.5.r),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.radioColor,
                                      width: 0.62.r,
                                    ),
                                  ),
                                  child: controller.role1.value
                                      ? Container(
                                    padding: EdgeInsets.all(7.42.r),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.radioColor,
                                    ),
                                  )
                                      : SizedBox(width: 14.84.w, height: 14.84.h),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.role1.value = false;
                            controller.role2.value = true;
                          },
                          child: Container(
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
                                  'Dad',
                                  style: h4.copyWith(
                                    color: AppColors.textColorHint,
                                    fontSize: 12.22.sp,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(3.5.r),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.radioColor,
                                      width: 0.62.r,
                                    ),
                                  ),
                                  child: controller.role2.value
                                      ? Container(
                                    padding: EdgeInsets.all(7.42.r),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.radioColor,
                                    ),
                                  )
                                      : SizedBox(width: 14.84.w, height: 14.84.h),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                      : SizedBox.shrink()),

        
                  SizedBox(height: 20.h),
        
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
        
                  SizedBox(height: 27.h),
        
                  CustomPBButton(text: 'Sign Up', onPressed: () => Get.to(SignUpProcessView()),),
        
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
              );
            }),
          ),
        ),
      ),
    );
  }
}
