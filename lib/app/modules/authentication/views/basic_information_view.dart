import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:parent_bridge/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:parent_bridge/app/modules/authentication/controllers/sign_up_controller.dart';
import 'package:parent_bridge/app/modules/sign_up_process/views/sign_up_process_view.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/custom_font.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_text_field.dart';

class BasicInformationView extends GetView<AuthenticationController> {
  const BasicInformationView({super.key});
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
                    controller: controller.phoneController,
                    hintText: 'Enter your phone number',
                    prefixIcon: 'assets/images/auth/phone_icon.svg',
                  ),

                  CustomTextField(
                    controller: controller.childNameController,
                    hintText: 'Enter child\'s full name',
                    prefixIcon: 'assets/images/auth/children_icon.svg',
                  ),

                  GestureDetector(
                    onTap: () => controller.pickChildDateOfBirth(context),
                    child: AbsorbPointer(
                      child: CustomTextField(
                        controller: controller.childAgeController,
                        hintText: 'Select child\'s date of birth',
                        prefixIcon: 'assets/images/auth/children_icon.svg',
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      controller.addChild();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.18.w,
                        vertical: 17.h,
                      ),
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
                              SvgPicture.asset(
                                'assets/images/auth/children_icon.svg',
                              ),

                              Text(
                                'Add Child',
                                style: TextStyle(
                                  color: AppColors.textColorHint,
                                  fontFamily: 'lato',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),

                          Icon(Icons.add, color: AppColors.textColorHint),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // Display added children
                  controller.childrenList.isNotEmpty
                      ? Container(
                          padding: EdgeInsets.all(20.r),
                          decoration: BoxDecoration(
                            color: AppColors.clrWhite,
                            borderRadius: BorderRadius.circular(24.r),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Added Children (${controller.childrenList.length})',
                                style: h4.copyWith(
                                  color: AppColors.textColor7,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 12.h),
                              ...List.generate(controller.childrenList.length, (
                                index,
                              ) {
                                final child = controller.childrenList[index];
                                return Container(
                                  margin: EdgeInsets.only(bottom: 8.h),
                                  padding: EdgeInsets.all(12.r),
                                  decoration: BoxDecoration(
                                    color: AppColors.card3,
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(
                                      color: AppColors.borderColor,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              child.name,
                                              style: h4.copyWith(
                                                color: AppColors.textColor7,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(height: 4.h),
                                            Text(
                                              'DOB: ${child.dateOfBirth}',
                                              style: h4.copyWith(
                                                color: AppColors.textColorHint,
                                                fontSize: 11.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.delete_outline,
                                          color: Colors.red,
                                          size: 20.sp,
                                        ),
                                        onPressed: () =>
                                            controller.removeChild(index),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ],
                          ),
                        )
                      : SizedBox.shrink(),

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
                      controller.courtMandatedActive.value =
                          !controller.courtMandatedActive.value;
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.18.w,
                        vertical: 17.h,
                      ),
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
                              SvgPicture.asset(
                                'assets/images/auth/court_icon.svg',
                              ),
                              Text(
                                'Is use of this app court mandated?',
                                style: h4.copyWith(
                                  color: AppColors.textColorHint,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                          SvgPicture.asset(
                            'assets/images/auth/dropdown_icon.svg',
                          ),
                        ],
                      ),
                    ),
                  ),

                  Obx(
                    () => controller.courtMandatedActive.value
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
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 23.56.w,
                                      vertical: 18.33.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.card3,
                                      borderRadius: BorderRadius.circular(
                                        43.63.r,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.boxShadowColor
                                              .withAlpha(36),
                                          blurRadius: 11.r,
                                          offset: Offset(0.w, 6.98.h),
                                        ),
                                      ],
                                      border: Border.all(
                                        color: AppColors.borderColor,
                                        width: 0.87.r,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                          child:
                                              controller.isCourtMandated2.value
                                              ? Container(
                                                  padding: EdgeInsets.all(
                                                    7.42.r,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: AppColors.radioColor,
                                                  ),
                                                )
                                              : SizedBox(
                                                  width: 14.84.w,
                                                  height: 14.84.h,
                                                ),
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
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 23.56.w,
                                      vertical: 18.33.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.card3,
                                      borderRadius: BorderRadius.circular(
                                        43.63.r,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.boxShadowColor
                                              .withAlpha(36),
                                          blurRadius: 11.r,
                                          offset: Offset(0.w, 6.98.h),
                                        ),
                                      ],
                                      border: Border.all(
                                        color: AppColors.borderColor,
                                        width: 0.87.r,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                          child:
                                              controller.isVoluntaryUse2.value
                                              ? Container(
                                                  padding: EdgeInsets.all(
                                                    7.42.r,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: AppColors.radioColor,
                                                  ),
                                                )
                                              : SizedBox(
                                                  width: 14.84.w,
                                                  height: 14.84.h,
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SizedBox.shrink(),
                  ),

                  SizedBox(height: 20.h),

                  // Select Role Section
                  GestureDetector(
                    onTap: () {
                      controller.roleActive.value =
                          !controller.roleActive.value;
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.18.w,
                        vertical: 17.h,
                      ),
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
                              SvgPicture.asset(
                                'assets/images/auth/role_icon.svg',
                              ),
                              Text(
                                'Select your role',
                                style: h4.copyWith(
                                  color: AppColors.textColorHint,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                          SvgPicture.asset(
                            'assets/images/auth/dropdown_icon.svg',
                          ),
                        ],
                      ),
                    ),
                  ),

                  Obx(
                    () => controller.roleActive.value
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
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 23.56.w,
                                      vertical: 18.33.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.card3,
                                      borderRadius: BorderRadius.circular(
                                        43.63.r,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.boxShadowColor
                                              .withAlpha(36),
                                          blurRadius: 11.r,
                                          offset: Offset(0.w, 6.98.h),
                                        ),
                                      ],
                                      border: Border.all(
                                        color: AppColors.borderColor,
                                        width: 0.87.r,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                                  padding: EdgeInsets.all(
                                                    7.42.r,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: AppColors.radioColor,
                                                  ),
                                                )
                                              : SizedBox(
                                                  width: 14.84.w,
                                                  height: 14.84.h,
                                                ),
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
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 23.56.w,
                                      vertical: 18.33.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.card3,
                                      borderRadius: BorderRadius.circular(
                                        43.63.r,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.boxShadowColor
                                              .withAlpha(36),
                                          blurRadius: 11.r,
                                          offset: Offset(0.w, 6.98.h),
                                        ),
                                      ],
                                      border: Border.all(
                                        color: AppColors.borderColor,
                                        width: 0.87.r,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                                  padding: EdgeInsets.all(
                                                    7.42.r,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: AppColors.radioColor,
                                                  ),
                                                )
                                              : SizedBox(
                                                  width: 14.84.w,
                                                  height: 14.84.h,
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SizedBox.shrink(),
                  ),

                  SizedBox(height: 20.h),

                  Row(
                    children: [
                      Obx(
                        () => Transform.scale(
                          scale:
                              0.7, // Scale down the switch to make it smaller
                          child: Switch(
                            value: controller.rememberMe.value,
                            onChanged: (value) => controller.toggleRememberMe(),
                            activeThumbColor: AppColors.clrWhite,
                            activeTrackColor: AppColors.appColor,
                            inactiveTrackColor: AppColors.appColor.withAlpha(128),
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

                  CustomPBButton(
                    text: 'Create Account',
                    onPressed: () => Get.to(SignUpProcessView()),
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
