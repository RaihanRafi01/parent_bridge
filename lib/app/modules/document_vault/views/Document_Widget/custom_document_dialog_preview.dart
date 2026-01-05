import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:parent_bridge/common/appColors.dart';

import '../../../../../common/customFont.dart';

class Document_dialog_preview extends StatelessWidget {
  const Document_dialog_preview({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
      child: Container(
        width: 390.w,
        height: 561.h,
        // padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(1630.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// 🔹 Header
            Container(
              height: 67.89.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: AppColors.clrGreen,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "School Emergency Contact Form",
                    style: h2.copyWith(color: AppColors.white, fontSize: 18.sp),
                  ),
                  CircleAvatar(
                    maxRadius: 20.r,
                    backgroundColor: AppColors.white,
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(Icons.close, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 2.h),

            /// 🔹 Buttons Row (Preview, Details)
            Padding(
              padding: EdgeInsets.all(18.0.r),
              child: Container(
                height: 65.16.h,
                width: 355.w,
                decoration: BoxDecoration(
                  color: AppColors.clrGreen.withOpacity(0.15.sp),
                  borderRadius: BorderRadius.circular(9.73.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.white.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(12.0.r),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                          width: 162.42.w,
                          height: 42.79.h,
                          decoration: BoxDecoration(
                            color: AppColors.category4,
                            borderRadius: BorderRadius.circular(9.73.r),
                            border: Border.all(
                              width: 1.w,
                              color: Color(0xFF68B961),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/images/document_svg/eye.svg',
                                height: 12.h,
                                width: 12.w,
                                colorFilter: ColorFilter.mode(
                                  AppColors.white,
                                  BlendMode.srcIn,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                'Preview',
                                style: h3.copyWith(
                                  fontSize: 14.49.sp,

                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(width: 12.w),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            width: 162.42.w,
                            height: 42.79.h,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(9.73.r),
                              border: Border.all(
                                width: 1.w,
                                color: AppColors.category4,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/document_svg/file.svg',
                                  height: 22.h,
                                  width: 22.w,
                                  colorFilter: ColorFilter.mode(
                                    AppColors.category4,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                  'Details',
                                  style: h3.copyWith(
                                    fontSize: 14.49.sp,

                                    color: AppColors.category4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 0.h),
            Padding(
              padding: EdgeInsets.all(15.0.r),
              child: Container(
                width: 355.w,
                height: 288.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    width: 1.w,
                    color: AppColors.greyClr.withOpacity(0.15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.customGrey.withOpacity(0.1),
                      spreadRadius: 1.r,
                      blurRadius: 1.r,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: 355.w,
                      height: 44.h,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.clrGreen2,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.r),
                          topRight: Radius.circular(16.r),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "PDF Document",
                            style: h2.copyWith(
                              color: AppColors.darkSlateBlue,
                              fontSize: 14.9.sp,
                            ),
                          ),
                          Text(
                            "4 Page",
                            style: h2.copyWith(
                              color: AppColors.darkSlateBlue,
                              fontSize: 14.9.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.0.r),
                      child: DottedBorder(
                        options: RoundedRectDottedBorderOptions(
                          dashPattern: [8, 5],
                          radius: Radius.circular(10.r),
                          color: AppColors.clrGreen,
                          strokeWidth: 1,
                          padding: EdgeInsets.all(1.r),
                        ),
                        child: Container(
                          width: 324.w,
                          height: 205.h,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(7.5.r),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/document_svg/pdf.png'),
                              SizedBox(height: 20.h),
                              Text(
                                'PDF preview available ',
                                style: h2.copyWith(
                                  height: .6.h,
                                  color: AppColors.clrBlack,
                                  fontSize: 15.86.sp,
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Container(
                                width: 142.w,
                                height: 37.64.h,
                                decoration: BoxDecoration(
                                  color: AppColors.clrGreen,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Center(
                                  child: Text(
                                    'Open Pdf',
                                    style: h1.copyWith(
                                      fontSize: 15.4.sp,

                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// 🔹 User Info + Tag
            SizedBox(height: 1.h),

            /// 🔹 Footer buttons
            Padding(
              padding: EdgeInsets.only(left: 18.0.r, right: 18.0.r, top: 10.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 28.87.h,
                    width: 101.73.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      border: Border.all(color: AppColors.clrBlack),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/document_svg/edit.svg',
                          width: 18.w, // smaller so it fits well
                          height: 18.h,
                          colorFilter: ColorFilter.mode(
                            AppColors.clrBlack,
                            BlendMode.srcIn,
                          ),
                        ),
                        Text(
                          "Edit",
                          style: h3.copyWith(
                            height: .6.h,
                            color: AppColors.clrBlack,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 28.87.h,
                    width: 101.73.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      border: Border.all(color: AppColors.clrBlack),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/document_svg/download.svg',
                          width: 18.w, // smaller so it fits well
                          height: 18.h,
                          colorFilter: ColorFilter.mode(
                            AppColors.clrBlack,
                            BlendMode.srcIn,
                          ),
                        ),
                        Text(
                          "Download",
                          style: h3.copyWith(
                            height: .6.h,
                            color: AppColors.clrBlack,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 28.87.h,
                    width: 101.73.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      border: Border.all(color: AppColors.category3),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/document_svg/delete.svg',
                          width: 18.w, // smaller so it fits well
                          height: 18.h,
                          colorFilter: ColorFilter.mode(
                            AppColors.category3,
                            BlendMode.srcIn,
                          ),
                        ),
                        Text(
                          "Delete",
                          style: h3.copyWith(
                            height: .6.h,
                            color: AppColors.category3,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
