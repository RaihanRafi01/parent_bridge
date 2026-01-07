import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:parent_bridge/common/app_colors.dart';

import '../../../../../common/custom_font.dart';

class CustomReactComment extends StatelessWidget {
  const CustomReactComment({
    super.key,
    this.svgImage,
    this.count,
    this.commentOnTap,
  });

  final String? svgImage;
  final String? count;
  final VoidCallback? commentOnTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // love react ..
        Container(
          height: 26.85.h,
          width: 74.29.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(875.r),
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.clrBlack.withAlpha(128),
                blurRadius: 3.r,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: GestureDetector(
            onTap: commentOnTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('$svgImage'),
                SizedBox(width: 5.sp),
                Text(
                  '$count',
                  style: h4.copyWith(
                    fontSize: 16.11.sp,
                    color: AppColors.customAnonymousParent_03,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
