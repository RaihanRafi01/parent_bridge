import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../../common/appColors.dart';
import '../../../../common/customFont.dart';

class OnboardingPageView extends GetView {
  final String image;
  final String title;
  final String subtitle;
  final double spacing;

  const OnboardingPageView({
    required this.image,
    required this.title,
    required this.subtitle,
    this.spacing = 0,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 31.w, top: 184.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(image,height: 450.h,),
          SizedBox(height: spacing.h,),
          Text(
            title,
            style: h1.copyWith(
              color: AppColors.textColor7,
              fontSize: 30.sp,
            ),
          ),
          SizedBox(height: 20.h,),
          SizedBox(
            width: 307.w,
            child: Text(
              subtitle,
              style: h4.copyWith(
                color: AppColors.textColor17,
                fontSize: 18.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
