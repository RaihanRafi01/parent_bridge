import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../appColors.dart';

// Reusable Custom Popup Widget
class CustomPopup extends StatelessWidget {
  final List<Widget> children;
  final Color backgroundColor;
  final Color overlayColor;
  final double borderRadius;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double? width;
  final double? height;
  final bool hideDecorations; // New parameter to hide decorations

  const CustomPopup({
    Key? key,
    required this.children,
    this.backgroundColor = Colors.redAccent,
    this.overlayColor = Colors.redAccent, // Blue color from design
    this.borderRadius = 16.0,
    this.padding = const EdgeInsets.all(24.0),
    this.margin = const EdgeInsets.symmetric(horizontal: 20.0),
    this.width,
    this.height,
    this.hideDecorations = false, // Default value is false (decorations visible)
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.redAccent, // Changed to solid red accent color
      insetPadding: margin,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Color(0x40C9C9C9), // #C9C9C9 with 25% opacity
              offset: Offset(0, 4.54), // x: 0px, y: 4.54px
              blurRadius: 4.54, // blur: 4.54px
              spreadRadius: 0, // no spread specified in the CSS
            ),
          ],
        ),
        child: Stack(
          children: [
            // Conditionally display the top left decoration
            if (!hideDecorations)
              Positioned(
                top: 0,
                left: 0,
                child: SvgPicture.asset('assets/images/home/popup_up.svg'),
              ),
            // Conditionally display the red stripes decoration (bottom right)
            if (!hideDecorations)
              Positioned(
                bottom: 0,
                right: 0,
                child: SvgPicture.asset('assets/images/home/popup_down.svg'),
              ),
            // Main content
            Padding(
              padding: padding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),
                  // Dynamic content
                  ...children,
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to show the popup
  static Future<T?> show<T>({
    required BuildContext context,
    required List<Widget> children,
    Color backgroundColor = Colors.white,
    Color overlayColor = AppColors.textColor12,
    double borderRadius = 16.0,
    EdgeInsets padding = const EdgeInsets.all(24.0),
    EdgeInsets margin = const EdgeInsets.symmetric(horizontal: 20.0),
    double? width,
    double? height,
    bool barrierDismissible = true,
    bool hideDecorations = false, // New parameter
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: AppColors.textColor12.withOpacity(.91),
      builder: (context) => CustomPopup(
        children: children,
        backgroundColor: backgroundColor,
        overlayColor: overlayColor,
        borderRadius: borderRadius,
        padding: padding,
        margin: margin,
        width: width,
        height: height,
        hideDecorations: hideDecorations, // Pass the new parameter to the widget
      ),
    );
  }
}
