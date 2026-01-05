import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:parent_bridge/app/modules/authentication/controllers/new_password_controller.dart';

import '../../../../common/appColors.dart';
import '../../../../common/customFont.dart';
import '../../../../common/widgets/customButton.dart';
import '../../../../common/widgets/customTextField.dart';

class NewPasswordView extends GetView<NewPasswordController> {
  const NewPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NewPasswordController());

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
                  'Create new password',
                  style: h2.copyWith(
                    color: AppColors.textColor7,
                    fontSize: 30.sp,
                  ),
                ),

                SizedBox(height: 11.h),

                SizedBox(
                  width: 327.w,
                  child: Text(
                    'Your new password must be unique from those previously used.',
                    style: h4.copyWith(
                      color: AppColors.textColor18,
                      fontSize: 16.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: 30.h),

                Obx(
                  () => CustomTextField(
                    controller: controller.newPasswordController,
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
                    controller: controller.confirmNewPasswordController,
                    hintText: 'Confirm password',
                    prefixIcon: 'assets/images/auth/lock_icon.svg',
                    suffixIcon: 'assets/images/auth/eye_close_icon.svg',
                    isPassword: true,
                    onSuffixTap: () =>
                        controller.toggleConfirmPasswordVisibility(),
                    obscureText: !controller.isConfirmPasswordVisible.value,
                  ),
                ),

                SizedBox(height: 10.h),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30).r,
                  child: Obx(
                    () => CustomPBButton(
                      text: 'Send',
                      isLoading: controller.isLoading.value,
                      onPressed: () => controller.resetPassword(),
                    ),
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
