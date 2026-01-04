import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parent_bridge/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:parent_bridge/app/modules/authentication/views/join_partner_info_view.dart';
import 'package:parent_bridge/common/app_colors.dart';
import 'package:parent_bridge/common/custom_font.dart';
import 'package:parent_bridge/common/widgets/custom_button.dart';

class JoinAccountView extends GetView<AuthenticationController> {
  const JoinAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    final accountCodeController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              GestureDetector(
                onTap: () => Get.back(),
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.textColor7,
                  size: 28.sp,
                ),
              ),

              SizedBox(height: 20.h),

              // Title centered
              Center(
                child: Text(
                  'Join Account',
                  style: h2.copyWith(
                    color: AppColors.textColor7,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              SizedBox(height: 40.h),

              // Logo
              Center(
                child: Image.asset(
                  'assets/images/auth/parent_bridge_logo.png',
                  scale: 4,
                ),
              ),

              SizedBox(height: 40.h),

              // Main heading
              Center(
                child: Text(
                  'Join Your Co-Parent\'s\nAccount',
                  style: h2.copyWith(
                    color: AppColors.textColor7,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: 16.h),

              // Description
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    'Your co-parent can share their account code with you. Enter it below to connect and start co-parenting together without needing to provide additional information.',
                    style: h4.copyWith(
                      color: AppColors.textColor18,
                      fontSize: 16.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              SizedBox(height: 40.h),

              // Account Code label
              Text(
                'Account Code',
                style: h3.copyWith(
                  color: AppColors.textColor7,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: 12.h),

              // Account code input
              Container(
                decoration: BoxDecoration(
                  color: AppColors.card3,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.borderColor),
                ),
                child: TextField(
                  controller: accountCodeController,
                  style: h4.copyWith(
                    color: AppColors.textColor7,
                    fontSize: 16.sp,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter Your Partner\'s ID To Connect',
                    hintStyle: h4.copyWith(
                      color: AppColors.textColorHint,
                      fontSize: 16.sp,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 18.h,
                    ),
                  ),
                ),
              ),

              Spacer(),

              // Next button
              CustomPBButton(
                text: 'Next',
                onPressed: () {
                  if (accountCodeController.text.trim().isEmpty) {
                    Get.snackbar(
                      'Required',
                      'Please enter the account code',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red.withAlpha(28),
                      colorText: Colors.red,
                    );
                  } else {
                    // Store partner code in controller
                    controller.partnerCode = accountCodeController.text.trim();

                    // Set mode to bridge since joining partner's account
                    controller.selectedMode = 'bridge';

                    // Navigate to join partner info view
                    Get.to(() => const JoinPartnerInfoView());
                  }
                },
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
