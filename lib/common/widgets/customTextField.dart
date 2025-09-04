import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../appColors.dart';

class CustomTextField extends StatelessWidget {
  final String prefixIcon;
  final String suffixIcon;
  final String hintText;
  final bool obscureText;

  const CustomTextField({
    required this.hintText,
    this.prefixIcon = '',
    this.suffixIcon = '',
    this.obscureText = false,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.18.w, vertical: 17.h,),
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

          prefixIcon: prefixIcon != '' ? Image.asset(
            prefixIcon,
            scale: 4,
          ) : SizedBox.shrink(),

          suffixIcon: suffixIcon != '' ? Image.asset(
            suffixIcon,
            scale: 4,
          ) : SizedBox.shrink(),

          hintText: hintText,
          hintStyle: TextStyle(
            color: AppColors.textColorHint,
            fontFamily: 'lato',
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),

        obscureText: obscureText,
      ),
    );
  }
}
