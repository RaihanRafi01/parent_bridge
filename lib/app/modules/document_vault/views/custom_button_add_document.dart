import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parent_bridge/common/app_colors.dart';

import '../../../../common/custom_font.dart';

class CustomButtonAddDocument extends StatelessWidget {
  const CustomButtonAddDocument({
    super.key,
    required this.height,
    required this.width,
    required this.text,
    this.icon,
    required this.padding,
    required this.padding2,
    required this.padding3,
    required this.padding4,
  });

  final double height;
  final double width;
  final double padding;
  final double padding2;
  final double padding3;
  final double padding4;
  final String text;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height,
        width: width,

        // add some padding
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.btnBorder, // border color
            width: 1.0.w, // border width
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.btnBorder.withAlpha(255),
              spreadRadius: 1.r,
              blurRadius: 6.r,
              offset: const Offset(0, 3),
            ),
          ],
          color: AppColors.textInputFillColor,
          borderRadius: BorderRadius.circular(100.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // spread text & icon
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom: padding,
                top: padding2,
                right: padding3,
                left: padding4,
              ),
              child: Text(
                text,
                style: h4.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF747688),
                ),
              ),
            ),
            if (icon != null)
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: icon!,
              ), // only show if icon
            // is passed
          ],
        ),
      ),
    );
  }
}
