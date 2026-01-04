import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:parent_bridge/common/app_colors.dart';

import '../../../../../common/custom_font.dart';

class CustomLegalDialog extends StatelessWidget {
  const CustomLegalDialog({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
      child: Container(
        width: 393.w,
        height: 504.h,
        // padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  title,
                  style: h1.copyWith(fontSize: 22),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  subtitle,
                  style: h4.copyWith(color: AppColors.clrBlk, fontSize: 14.sp),
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Select Date Range',
                  style: h1.copyWith(
                    color: AppColors.clrBlack,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text('Start Date', style: h4.copyWith(fontSize: 18)),
              ),
              SizedBox(height: 10.h),
              Container(
                height: 56.h,
                width: 357.w,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(100.r),

                  border: Border.all(
                    width: .7.w,
                    color: AppColors.appColor2.withAlpha(77),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.appColor2.withAlpha(28),
                      spreadRadius: 2.r,
                      blurRadius: 5.r,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(4.0.r),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(11.0.r),
                        child: SvgPicture.asset(
                          "assets/images/document_svg/date.svg",
                          colorFilter: ColorFilter.mode(
                            AppColors.clrBlk,
                            BlendMode.srcIn,
                          ),
                          height: 2.h,
                          width: 2.w,
                        ),
                      ),
                      hintText: "dd/mm/yyyy",
                      hintStyle: h4.copyWith(
                        color: AppColors.clrBlk,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text('End date', style: h4.copyWith(fontSize: 18)),
              ),
              SizedBox(height: 10.h),
              Container(
                height: 56.h,
                width: 357.w,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(100.r),

                  border: Border.all(
                    width: .7.w,
                    color: AppColors.appColor2.withAlpha(77),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.appColor2.withAlpha(28),
                      spreadRadius: 2.r,
                      blurRadius: 5.r,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(4.0.r),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(11.0.r),
                        child: SvgPicture.asset(
                          "assets/images/document_svg/date.svg",
                          colorFilter: ColorFilter.mode(
                              AppColors.clrBlk,BlendMode.srcIn),
                          height: 2.h,
                          width: 2.w,
                        ),
                      ),
                      hintText: "dd/mm/yyyy",
                      hintStyle: h4.copyWith(
                        color: AppColors.clrBlk,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              Container(
                height: 56.h,
                width: 357.w,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.appColor2, AppColors.appColor],
                    begin: Alignment.bottomRight,
                    end: Alignment.bottomLeft,
                  ),
                  borderRadius: BorderRadius.circular(100.r),

                  boxShadow: [
                    BoxShadow(
                      color: AppColors.customGrey.withAlpha(28),
                      spreadRadius: 2.r,
                      blurRadius: 5.r,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Download Pdf',
                    style: h1.copyWith(color: AppColors.white, fontSize: 18.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
