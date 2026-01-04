import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:parent_bridge/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:parent_bridge/app/modules/authentication/controllers/sign_up_controller.dart';
import 'package:parent_bridge/app/modules/authentication/views/basic_information_view.dart';
import 'package:parent_bridge/app/modules/authentication/views/join_account_view.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/custom_font.dart';
import '../../../../common/widgets/custom_button.dart';

class ChooseMode extends GetView<AuthenticationController> {
  const ChooseMode({super.key});

  // Unified radio button
  Widget _buildRadio(bool isSelected) {
    return Container(
      width: 26.w,
      height: 26.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? AppColors.radioColor : Colors.grey[400]!,
          width: 1.5,
        ),
      ),
      child: isSelected
          ? Container(
              width: 14.w,
              height: 14.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.radioColor,
              ),
            )
          : null,
    );
  }

  // Reusable card with consistent shadow
  Widget _buildOptionCard({
    required bool isSelected,
    required Widget icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16).r,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.buttonColor : Colors.white,
          borderRadius: BorderRadius.circular(16).r,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFBCBCBC).withAlpha(64), // #BCBCBC40
              offset: const Offset(0, 4),
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(padding: const EdgeInsets.all(8.0).r, child: icon),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: h2.copyWith(
                      color: AppColors.textColor24,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: h4.copyWith(
                      color: AppColors.textColor24,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            _buildRadio(isSelected),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpController());
    final RxInt selectedOption = 0.obs;

    return Scaffold(
      backgroundColor: Colors.white,
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
                  'Connect with Your Co-Parent',
                  style: h2.copyWith(
                    color: AppColors.textColor7,
                    fontSize: 30.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  width: 303.w,
                  child: Text(
                    'We make it easy for co-parents to connect. If your co-parent has already created an account, you can join theirs directly without entering additional information. Otherwise, create your own account profile.',
                    style: h4.copyWith(
                      color: AppColors.textColor18,
                      fontSize: 16.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 30.h),

                // Option 1
                Obx(
                  () => _buildOptionCard(
                    isSelected: selectedOption.value == 1,
                    onTap: () => selectedOption.value = 1,
                    icon: SvgPicture.asset(
                      'assets/images/auth/partner_icon.svg',
                    ),
                    title: 'Connect To A Partner',
                    subtitle: 'Enter your co-parent\'s code to connect.',
                  ),
                ),

                SizedBox(height: 16.h),

                // Option 2
                Obx(
                  () => _buildOptionCard(
                    isSelected: selectedOption.value == 2,
                    onTap: () => selectedOption.value = 2,
                    icon: SvgPicture.asset('assets/images/auth/info_icon.svg'),
                    title: 'Continue And Invite Them',
                    subtitle: 'I\'ll set up my profile first',
                  ),
                ),

                SizedBox(height: 30.h),

                CustomPBButton(
                  text: 'next',
                  onPressed: () {
                    if (selectedOption.value == 0) {
                      Get.snackbar(
                        'Selection Required',
                        'Please select an option to continue',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red.withAlpha(28),
                        colorText: Colors.red,
                      );
                    } else if (selectedOption.value == 1) {
                      Get.to(() => const JoinAccountView());
                    } else {
                      Get.to(() => const BasicInformationView());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
