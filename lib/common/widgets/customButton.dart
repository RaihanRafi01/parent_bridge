import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../app/modules/home/views/home_view.dart';
import '../appColors.dart';
import '../customFont.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

// Assuming AppColors and h2 are defined elsewhere
import '../appColors.dart';
import '../customFont.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isWhite;
  final Color? bgClr;
  final Color txtClr;
  final String? svgPath;
  final String? svgPath2;
  final Color? borderColor;
  final double? width;
  final Widget? leading;
  final double? height;
  final double radius;
  final double fontSize;
  final bool isLoading;
  final Gradient? gradient;

  final Gradient? borderGradient;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.leading,
    this.isWhite = false,
    this.bgClr = AppColors.appColor,
    this.txtClr = Colors.white,
    this.svgPath,
    this.svgPath2,
    this.borderColor,
    this.width,
    this.height,
    this.radius = 13,
    this.fontSize = 16,
    this.isLoading = false,
    this.gradient,
    this.borderGradient,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: width?.w,
        height: height?.h,
        decoration: BoxDecoration(
          gradient: gradient,
          color: gradient == null ? (isWhite ? Colors.white : bgClr) : null,
          border: borderColor != null
              ? Border.all(color: borderColor!, width: 1.w)
              : isWhite
              ? Border.all(color: txtClr, width: 1.w)
              : null,
          borderRadius: BorderRadius.circular(radius),
        ),
        alignment: Alignment.center,
        child: isLoading
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(txtClr),
                strokeWidth: 2.w,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (leading != null) ...[leading!, SizedBox(width: 8.w)],
                  if (svgPath != null) ...[
                    SvgPicture.asset(svgPath!),
                    SizedBox(width: 8.w),
                  ],
                  Text(
                    label.toUpperCase(),
                    style: h2.copyWith(fontSize: fontSize.sp, color: txtClr),
                  ),
                  if (svgPath2 != null) ...[
                    SizedBox(width: 8.w),
                    SvgPicture.asset(svgPath2!),
                  ],
                ],
              ),
      ),
    );
  }
}

class CustomPBButton extends StatelessWidget {
  final String text;
  final String icon;
  final Color color1;
  final Color color2;
  final VoidCallback onPressed;
  final bool isWhite; // Added isWhite parameter
  final Color txtClr; // Added txtClr parameter for text color customization
  final double horizontalPadding;
  final double verticalPadding;
  final Color borderColor;

  const CustomPBButton({
    required this.text,
    this.icon = '',
    this.color1 = AppColors.buttonColor,
    this.color2 = AppColors.buttonColor2,
    required this.onPressed,
    this.isWhite = false, // Default to false
    this.txtClr = AppColors.clrWhite, // Default text color
    this.horizontalPadding = 30,
    this.verticalPadding = 15,
    this.borderColor = AppColors.clrTransparent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding.w,
          vertical: verticalPadding.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          gradient: LinearGradient(colors: [color1, color2]),
          border: Border.all(color: borderColor),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon.isNotEmpty) ...[
                SvgPicture.asset(
                  icon, // Use the provided icon path
                ),
                SizedBox(width: 10.w),
              ],
              Text(
                text,
                style: TextStyle(
                  color: txtClr, // Use customizable text color
                  fontFamily: 'lato',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomGoogleAppleButton extends StatelessWidget {
  final String text;
  final String icon;

  const CustomGoogleAppleButton({
    required this.text,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(HomeView()),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: AppColors.buttonColor3,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
            children: [
              SvgPicture.asset(icon),

              Text(
                text,
                style: h4.copyWith(
                  color: AppColors.textColor20,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
