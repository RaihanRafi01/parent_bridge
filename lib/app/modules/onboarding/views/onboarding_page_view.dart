import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../common/appColors.dart';

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
          Image.asset(
            image,
            height: 450.h,
            scale: 4,
          ),

          SizedBox(height: spacing.h,),

          Text(
            title,
            style: TextStyle(
              color: AppColors.textColor7,
              fontFamily: 'lato',
              fontSize: 30.sp,
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(height: 20.h,),

          SizedBox(
            width: 307.w,
            child: Text(
              subtitle,
              style: TextStyle(
                color: AppColors.textColor17,
                fontFamily: 'lato',
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
