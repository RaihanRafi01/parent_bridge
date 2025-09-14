import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_bridge/common/appColors.dart';

import '../../../../../common/customFont.dart';
import 'custom_document_dialog.dart';

class DocumentCard extends StatelessWidget {
  const DocumentCard({
    super.key,
    required this.title,
    required this.label,
    required this.date,
    required this.type,

    required this.person,

    required this.labelcontainer,
    required this.bgcolor,
    required this.sidebar,
    this.exp_date,
    required this.onTap,
  });

  final String title;
  final String label;
  final String date;
  final String type;
  final String? exp_date;
  final Color labelcontainer;
  final Color bgcolor;
  final Color sidebar;
  final VoidCallback onTap;
  final String person;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 399.w,
      height: 176.h, //change
      decoration: BoxDecoration(
        color: bgcolor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.customGrey.withOpacity(0.1),
            spreadRadius: 2.r,
            blurRadius: 5.r,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left red bar
          Container(
            width: 8.w,
            height: 166.h,
            decoration: BoxDecoration(
              color: sidebar,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                bottomLeft: Radius.circular(16.r),
              ),
            ),
          ),
          SizedBox(width: 12.w, height: 166.h),
          // Right content
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title + Download button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: h2.copyWith(
                            fontSize: 18.sp,

                            color: AppColors.darkSlateBlue,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      InkWell(
                        onTap: onTap,
                        child: Container(
                          width: 41.w,
                          height: 33.h,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(5.r),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.customGrey.withOpacity(0.1.sp),
                                spreadRadius: 2.r,
                                blurRadius: 5.r,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(5.0.r),
                            child: SvgPicture.asset(
                              'assets/images/document_svg/download.svg',
                              height: 2.h,
                              width: 2.w,
                              colorFilter: ColorFilter.mode(
                                AppColors.category,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),

                  // Legal tag
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.r,
                      vertical: 4.r,
                    ),
                    decoration: BoxDecoration(
                      color: labelcontainer,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      label,
                      style: h3.copyWith(
                        fontSize: 12.sp,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),

                  // People
                  Row(
                    children: [
                      SizedBox(
                        width: 12.w,
                        height: 12.h,
                        child: SvgPicture.asset(
                          'assets/images/document_svg/people.svg',

                          colorFilter: ColorFilter.mode(
                            AppColors.svgColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        person,
                        style: GoogleFonts.lato(color: AppColors.svgColor),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),

                  // Upload date + file type
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Uploaded • ',

                            style: h2.copyWith(
                              fontSize: 12.sp, // responsive font size

                              color: AppColors.darkSlateBlue,
                            ),
                          ),
                          Text(
                            date,

                            style: h4.copyWith(
                              fontSize: 12.52.sp,
                              color: AppColors.darkSlateBlue,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: .6.h),
                      Row(
                        children: [
                          Text(
                            'File Type • ',

                            style: h4.copyWith(
                              fontSize: 12.52.sp, // responsive font size

                              color: AppColors.darkSlateBlue,
                            ),
                          ),
                          Text(
                            type,

                            style: h4.copyWith(
                              fontSize: 12.52.sp, // responsive font size

                              color: AppColors.darkSlateBlue,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: .6.h),
                      Text(
                        exp_date!,

                        style: h4.copyWith(
                          fontSize: 12.52.sp, // responsive font size

                          color: AppColors.expDate,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
