import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Document_dialog_preview extends StatelessWidget {
  Document_dialog_preview({super.key});

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
          color: Color(0xFFFFFFFF),
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
                color: const Color(0xFF68B961),
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
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CircleAvatar(
                    maxRadius: 20.r,
                    backgroundColor: Color(0xFFFFFFFF),
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
                  color: Color(0xFF68B961).withOpacity(0.15.sp),
                  borderRadius: BorderRadius.circular(9.73.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.1),
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
                            color: Color(0xFF68B961),
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
                                  Color(0xFFFFFFFF),
                                  BlendMode.srcIn,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                'Preview',
                                style: GoogleFonts.lato(
                                  fontSize: 14.49.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFFFFFFF),
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
                                color: Color(0xFF68B961),
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
                                    Color(0xFF68B961),
                                    BlendMode.srcIn,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                  'Details',
                                  style: GoogleFonts.lato(
                                    fontSize: 14.49.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF68B961),
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
                    color: Colors.grey.withOpacity(0.15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
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
                        color: Color(0xFFE7FAE5),
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
                            style: TextStyle(
                              color: Color(0xFF1D3856),
                              fontSize: 14.9.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "4 Page",
                            style: TextStyle(
                              color: Color(0xFF1D3856),
                              fontSize: 14.9.sp,
                              fontWeight: FontWeight.w600,
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
                          color: Color(0xFF68B961),
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
                            color: Color(0xFFFFFFFF),
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
                                style: GoogleFonts.lato(
                                  height: .6.h,
                                  color: Colors.black,
                                  fontSize: 15.86.sp,
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Container(
                                width: 142.w,
                                height: 37.64.h,
                                decoration: BoxDecoration(
                                  color: Color(0xFF68B961),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Center(
                                  child: Text(
                                    'Open Pdf',
                                    style: GoogleFonts.lato(
                                      fontSize: 15.4.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFFFFFFF),
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
                      border: Border.all(color: Colors.black),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/document_svg/edit.svg',
                          width: 18.w, // smaller so it fits well
                          height: 18.h,
                          colorFilter: ColorFilter.mode(
                            Color(0xFF000000),
                            BlendMode.srcIn,
                          ),
                        ),
                        Text(
                          "Edit",
                          style: GoogleFonts.lato(
                            height: .6.h,
                            color: Colors.black,
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
                            Color(0xFF000000),
                            BlendMode.srcIn,
                          ),
                        ),
                        Text(
                          "Download",
                          style: GoogleFonts.lato(
                            height: .6.h,
                            color: Colors.black,
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
                      border: Border.all(color: Colors.red),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/document_svg/delete.svg',
                          width: 18.w, // smaller so it fits well
                          height: 18.h,
                          colorFilter: ColorFilter.mode(
                            Colors.red,
                            BlendMode.srcIn,
                          ),
                        ),
                        Text(
                          "Delete",
                          style: TextStyle(
                            height: .6.h,
                            color: Colors.red,
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
