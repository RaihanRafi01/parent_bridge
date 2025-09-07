import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../appColors.dart';
import '../customFont.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isWhite;
  final Color bgClr; // Changed to single Color
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

  const CustomButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.leading,
    this.isWhite = false,
    this.bgClr = AppColors.appColor, // Default to single color
    this.txtClr = Colors.white,
    this.svgPath,
    this.svgPath2,
    this.borderColor,
    this.width ,
    this.height,
    this.radius = 13,
    this.fontSize = 16,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: width!.w,
        height: height!.h,
        decoration: BoxDecoration(
          color: isWhite ? Colors.white : bgClr, // Use single color
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
            if (leading != null) ...[
              leading!,
              SizedBox(width: 8.w),
            ],

            if (svgPath != null) ...[
              SvgPicture.asset(
                svgPath!,
              ),
              SizedBox(width: 8.w),
            ],
            Text(
              label.toUpperCase(), // Apply uppercase as per previous request
              style: h2.copyWith(fontSize: fontSize.sp, color: txtClr),
            ),
            if (svgPath2 != null) ...[
              SizedBox(width: 8.w),
              SvgPicture.asset(
                svgPath2!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}