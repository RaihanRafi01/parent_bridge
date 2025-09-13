import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_bridge/app/modules/document_vault/views/upload2.dart';

import '../controllers/document_vault_controller.dart';
import 'Custom_button_add_document.dart';

class UploadDocument extends GetView<DocumentVaultController> {
  const UploadDocument({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 147.h,
              // responsive height
              padding: EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
              // responsive padding
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFCB93F2), Color(0xFF89C5E1)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.r), // responsive radius
                  bottomRight: Radius.circular(40.r), // responsive radius
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  SizedBox(width: 12.w), // responsive width
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Add Document",
                          style: GoogleFonts.lato(
                            fontSize: 24.47.sp, // responsive font size
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1D3856),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.h),
            Center(
              child: Container(
                height: 109.h,
                width: 112.52.w,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1), // shadow color
                      spreadRadius: 1, // how much it spreads
                      blurRadius: 6, // softness
                      offset: const Offset(1, 3), // shadow position (x, y)
                    ),
                  ],
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(3.0),
                          child: SvgPicture.asset(
                            'assets/images/document_svg/loading.svg',
                            width: 13.w, // smaller so it fits well
                            height: 13.h,
                            colorFilter: ColorFilter.mode(
                              Color(0xFF000000),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 55.31.h,
                      width: 43.w,
                      child: Image.asset('assets/images/document_svg/jpg.png'),
                    ),
                    Text(
                      'JPG',
                      style: GoogleFonts.lato(
                        fontSize: 14.14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF747688),
                      ),
                    ),
                    Text(
                      '2.6MB',
                      style: GoogleFonts.lato(
                        fontSize: 6.29.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF747688),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            CustomButtonAddDocument(
              padding3: 10.r,
              padding2: 10.r,
              padding4: 20.r,
              padding: 10.r,

              height: 56.h,
              width: 382.73.sp,
              text: "Select child's",
              icon: Icon(
                Icons.keyboard_arrow_down_outlined,
                color: Color(0xFF747688),
              ),
            ),
            SizedBox(height: 20.h),

            Center(
              child: Container(
                height: 56.h,
                width: 382.73.w, // 👈 should use .w instead of .sp for width
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFFEBEBEB),
                    width: 1.0.w,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFEDEDED).withOpacity(1),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  color: const Color(0xFFEAF8FF),
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: 20.sp,
                    top: 15.sp,
                    right: 20.sp,
                    left: 20.sp,
                  ),
                  child: TextField(
                    style: TextStyle(color: Color(0xFF747688), fontSize: 14.sp),
                    decoration: InputDecoration(
                      hintText: 'Enter Document Name',
                      // ✅ correct way
                      hintStyle: TextStyle(
                        color: Color(0xFF747688),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      border: InputBorder.none,
                      // ✅ removes default underline
                      isDense: true,
                      // ✅ keeps it compact
                      contentPadding: EdgeInsets.zero, // ✅ aligns nicely
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.h),
            InkWell(
              onTap: () {
                Get.to(UploadDocument2());
              },
              child: CustomButtonAddDocument(
                padding3: 10.r,
                padding2: 10.r,
                padding4: 20.r,
                padding: 10.r,

                height: 56.h,
                width: 382.73.sp,
                text: "Select Category",
                icon: Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: Color(0xFF747688),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            CustomButtonAddDocument(
              padding3: 10.r,
              padding2: 10.r,
              padding4: 20.r,
              padding: 10.r,

              height: 56.h,
              width: 382.73.sp,
              text: "EXPIRY DATE",
              icon: Icon(
                Icons.calendar_today_outlined,
                size: 20.sp,
                color: Color(0xFF747688),
              ),
            ),
            SizedBox(height: 20.h),

            Center(
              child: Container(
                height: 94.h,
                width: 383.w, // 👈 should use .w instead of .sp for width
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFFEBEBEB),
                    width: 1.0.w,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFEDEDED).withOpacity(1.0),
                      spreadRadius: 1.r,
                      blurRadius: 6.r,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  color: const Color(0xFFEAF8FF),
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: 20.sp,
                    top: 15.sp,
                    right: 20.sp,
                    left: 30.sp,
                  ),
                  child: TextField(
                    style: TextStyle(color: Color(0xFF747688), fontSize: 14.sp),
                    decoration: InputDecoration(
                      hintText: 'Add a Description',
                      // ✅ correct way
                      hintStyle: TextStyle(
                        color: Color(0xFF747688),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      border: InputBorder.none,
                      // ✅ removes default underline
                      isDense: true,
                      // ✅ keeps it compact
                      contentPadding: EdgeInsets.zero, // ✅ aligns nicely
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 70.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 52.h,
                  width: 181.w, // 👈 should use .w instead of .sp for width
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFEBEBEB),
                      width: 1.0.w,
                    ),

                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  child: Center(
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Color(0xFFBD9DED),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20.w),
                InkWell(
                  onTap: () {
                    Get.to(UploadDocument2());
                  },
                  child: Container(
                    height: 52.h,
                    width: 181.w, // 👈 should use .w instead of .sp for width
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFEBEBEB),
                        width: 1.0.w,
                      ),

                      gradient: const LinearGradient(
                        colors: [Color(0xFFCB93F2), Color(0xFF89C5E1)],
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                      ),
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    child: Center(
                      child: Text(
                        'Add Document',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
