import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_bridge/common/appColors.dart';
import 'package:parent_bridge/common/customFont.dart';

class Document_dialog2_preview extends StatelessWidget {
  const Document_dialog2_preview({super.key});

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
                color: AppColors.category3,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Emma Medical Insurance Card",
                    style: h2.copyWith(
                      color: AppColors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CircleAvatar(
                    maxRadius: 20.r,
                    backgroundColor: AppColors.white,
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.close,
                        color: AppColors.customGrey,
                      ),
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
                  color: AppColors.category3.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(9.73.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.white.withOpacity(0.1.sp),
                      spreadRadius: 2.r,
                      blurRadius: 5.r,
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
                            color: AppColors.category3,
                            borderRadius: BorderRadius.circular(9.73.r),
                            border: Border.all(
                              width: 1.w,
                              color: AppColors.category3,
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
                                color: AppColors.category3,
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
                                    AppColors.category3,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                  'Details',
                                  style: h3.copyWith(
                                    fontSize: 14.49,

                                    color: AppColors.category3,
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
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: 355.w,
                height: 288.h,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    width: 1.w,
                    color: AppColors.customGrey.withOpacity(0.15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.customGrey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 1,
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
                        color: AppColors.category3.withOpacity(0.15),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.r),
                          topRight: Radius.circular(16.r),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Image Document",
                            style: h3.copyWith(
                              color: AppColors.darkSlateBlue,
                              fontSize: 14.9.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "4 Page",
                            style: h3.copyWith(
                              color: AppColors.darkSlateBlue,
                              fontSize: 14.9.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(18.0.r),
                      child: Image.asset(
                        'assets/images/document_svg/ielts.png',
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
              padding: EdgeInsets.only(left: 18.0, right: 18.0, top: 10),
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
                            height: .6,
                            color: AppColors.clrBlack,
                            fontSize: 12,
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
                      border: Border.all(color: Colors.black),
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
                            height: .6,
                            color: AppColors.clrBlack,
                            fontSize: 12,
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
                            height: .6,
                            color: AppColors.category3,
                            fontSize: 12,
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
