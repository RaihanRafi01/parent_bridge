import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_document_dialog_preview.dart';

class Document_dialog extends StatelessWidget {
  const Document_dialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
      child: Container(
        width: 390.w,
        height: 531.h,
        // padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(30.r),
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
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CircleAvatar(
                    maxRadius: 20.r,
                    backgroundColor: Color(0xFFFFFFFF),
                    child: InkWell(
                      onTap: () => Get.back(),
                      child: const Icon(Icons.close, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 2.h),

            /// 🔹 Buttons Row (Preview, Details)
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                height: 65.16.h,
                width: 355.w,
                decoration: BoxDecoration(
                  color: Color(0xFF68B961).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(9.73.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.1),
                      spreadRadius: 2.r,
                      blurRadius: 5.r,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Get.dialog(
                              Document_dialog_preview(),
                              barrierColor: Color(0xFFBD9DED).withOpacity(0.10),
                            );
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
                                  'assets/images/document_svg/eye.svg',
                                  height: 12,
                                  width: 12,
                                  colorFilter: ColorFilter.mode(
                                    Color(0xFF68B961),
                                    BlendMode.srcIn,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                  'Preview',
                                  style: GoogleFonts.lato(
                                    fontSize: 14.49,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF68B961),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
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
                                'assets/images/document_svg/file.svg',
                                height: 22,
                                width: 22,
                                colorFilter: ColorFilter.mode(
                                  Color(0xFFFFFFFF),
                                  BlendMode.srcIn,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                'Details',
                                style: GoogleFonts.lato(
                                  fontSize: 14.49,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 0.h),

            /// 🔹 User Info + Tag
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 10),
              child: Row(
                children: [
                  const Icon(Icons.person_outline, color: Colors.black54),
                  SizedBox(width: 8.w),
                  const Text(
                    "Michael",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF68B961),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: const Text(
                      "School",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 2.h),

            /// 🔹 File Info
            Padding(
              padding: EdgeInsets.all(18.0.r),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Uploaded • 2024-12-10"),
                    Text(
                      "Expires • 2024-12-10",
                      style: TextStyle(color: Colors.red),
                    ),
                    Text("File Type • Image"),
                    Text("File Size • 856 KB"),
                  ],
                ),
              ),
            ),

            SizedBox(height: 2.h),

            /// 🔹 Description Box
            Padding(
              padding: EdgeInsets.only(left: 18.0.r, right: 18.0.r, top: 10.r),
              child: Container(
                height: 88.h,
                width: 347.w,
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: Color(0xFFDEFDDB),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: Text(
                    "Emergency Contact Information Form For Emma's School Including Medical Conditions And Authorized",
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
              ),
            ),

            SizedBox(height: 2.h),

            /// 🔹 Footer buttons
            Padding(
              padding: EdgeInsets.only(left: 18.r, right: 18.0.r, top: 30.r),
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
                          style: TextStyle(
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
                          style: TextStyle(
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
