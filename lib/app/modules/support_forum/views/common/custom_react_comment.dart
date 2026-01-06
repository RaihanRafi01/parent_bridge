import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:parent_bridge/common/appColors.dart';

import '../../../../../common/customFont.dart';

class custom_react_comment extends StatelessWidget {
  const custom_react_comment({
    super.key,
    this.svg_image,
    this.count,
    this.comment_ontap,
    this.isReacted = false,
  });

  final String? svg_image;
  final String? count;
  final VoidCallback? comment_ontap;
  final bool isReacted;

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
                color: AppColors.clrBlack.withOpacity(0.5),
                blurRadius: 3.r,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: GestureDetector(
            onTap: comment_ontap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  '$svg_image',
                  colorFilter: isReacted
                      ? ColorFilter.mode(Colors.red, BlendMode.srcIn)
                      : null,
                ),
                SizedBox(width: 5.sp),
                Text(
                  '$count',
                  style: h4.copyWith(
                    fontSize: 16.11.sp,
                    color: AppColors.custom_anonymous_parent_03,
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
