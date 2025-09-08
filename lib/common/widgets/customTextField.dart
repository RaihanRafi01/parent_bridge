import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../appColors.dart';
import '../customFont.dart';

// GetX Controller for managing password visibility
class CustomTextFieldController extends GetxController {
  final RxBool obscureText = true.obs;

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }
}

class CustomTextField extends StatelessWidget {
  final String prefixIcon;
  final String suffixIcon;
  final String hintText;
  final bool isPassword;
  final bool obscureText;
  final TextEditingController controller;
  final CustomTextFieldController? textFieldController;
  final VoidCallback? onSuffixTap;

  const CustomTextField({
    required this.hintText,
    required this.controller,
    this.prefixIcon = '',
    this.suffixIcon = '',
    this.isPassword = false,
    this.obscureText = false,
    this.textFieldController,
    this.onSuffixTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Use provided controller or create a new one
    final CustomTextFieldController ctrl = textFieldController ?? Get.put(CustomTextFieldController());

    // Initialize obscureText based on isPassword and obscureText parameter
    if (isPassword) {
      ctrl.obscureText.value = obscureText;
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 12).r,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(50.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.boxShadowColor.withAlpha(36),
            blurRadius: 12.6.r,
            offset: Offset(0.w, 8.h),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? ctrl.obscureText.value : false,
        decoration: InputDecoration(
          // Dynamically adjust contentPadding based on prefixIcon
          contentPadding: EdgeInsets.only(
            left:  16.18.w ,
            right: 16.18.w,
            top: 17.h,
            bottom: 17.h,
          ),
          filled: true,
          fillColor: AppColors.clrWhite,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.borderColor,
            ),
            borderRadius: BorderRadius.circular(50.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.borderColor,
            ),
            borderRadius: BorderRadius.circular(50.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.borderColor,
            ),
            borderRadius: BorderRadius.circular(50.r),
          ),
          prefixIcon: prefixIcon != ''
              ? Padding(
            padding: EdgeInsets.all(15.w),
            child: SvgPicture.asset(
              prefixIcon,
              fit: BoxFit.contain,
            ),
          )
              : null, // Use null instead of SizedBox.shrink() for better alignment
          suffixIcon: isPassword
              ? Padding(
            padding: EdgeInsets.all(15.w),
            child: GestureDetector(
              onTap: () {
                ctrl.toggleObscureText();
                onSuffixTap?.call();
              },
              child: SvgPicture.asset(
                ctrl.obscureText.value
                    ? suffixIcon
                    : 'assets/images/auth/eye_open_icon.svg',
                fit: BoxFit.contain,
              ),
            ),
          )
              : suffixIcon != ''
              ? Padding(
            padding: EdgeInsets.all(15.w),
            child: GestureDetector(
              onTap: onSuffixTap,
              child: SvgPicture.asset(
                suffixIcon,
                fit: BoxFit.contain,
              ),
            ),
          )
              : null, // Use null instead of SizedBox.shrink() for better alignment
          hintText: hintText,
          hintStyle: h4.copyWith(
            color: AppColors.textColorHint,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }
}