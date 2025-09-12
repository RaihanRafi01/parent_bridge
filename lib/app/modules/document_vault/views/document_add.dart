import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_bridge/app/modules/document_vault/views/upload_document.dart';

import '../controllers/document_vault_controller.dart';

class DocumentAdd extends GetView<DocumentVaultController> {
  const DocumentAdd({super.key});

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
            SizedBox(height: 100.h),
            Center(
              child: Container(
                height: 330.h,
                width: 389.w,
                decoration: BoxDecoration(
                  color: Color(0xFFEAF8FF),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Add New Document',
                      style: GoogleFonts.lato(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1D3856),
                      ),
                    ),
                    Text(
                      "Choose How You'd Like To Add Your Document",
                      style: GoogleFonts.lato(
                        fontSize: 12.47.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF747688),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    //box container
                    InkWell(
                      onTap: () {
                        Get.to(UploadDocument());
                      },
                      child: Container(
                        height: 62.h,
                        width: 301.w,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFFEBEBEB),
                            // set your border color
                            width: 1.0.w, // border width
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(
                                0xFFEBEBEB,
                              ).withOpacity(0.2), // shadow color
                              spreadRadius: 1.r, // how much it spreads
                              blurRadius: 6.r, // softness
                              offset: const Offset(
                                0,
                                3,
                              ), // shadow position (x, y)
                            ),
                          ],
                          color: Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0.r),
                              child: Container(
                                height: 46.h,
                                width: 46.w,
                                decoration: BoxDecoration(
                                  color: Color(0xFFBD9DED),
                                  shape:
                                      BoxShape.circle, // 👈 makes it circular
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(12.0.r),
                                    child: SvgPicture.asset(
                                      'assets/images/document_svg/upload.svg',
                                      width: 24.w, // smaller so it fits well
                                      height: 24.h,
                                      colorFilter: ColorFilter.mode(
                                        Color(0xFF000000),
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Upload From Device',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.lato(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF1D3856),
                                    letterSpacing: 0.2.sp,
                                  ),
                                ),
                                Text(
                                  "Select files from your device",
                                  style: GoogleFonts.lato(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF747688),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    //box container
                    Container(
                      height: 62.h,
                      width: 301.w,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFFEBEBEB), // set your border color
                          width: 1.0.w, // border width
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(
                              0xFFEBEBEB,
                            ).withOpacity(0.2), // shadow color
                            spreadRadius: 1.r, // how much it spreads
                            blurRadius: 6.r, // softness
                            offset: const Offset(
                              0,
                              3,
                            ), // shadow position (x, y)
                          ),
                        ],
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0.r),
                            child: Container(
                              height: 46.h,
                              width: 46.w,
                              decoration: BoxDecoration(
                                color: Color(0xFF89C5E1),
                                shape: BoxShape.circle, // 👈 makes it circular
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/images/document_svg/camera.svg',
                                  width: 24.w, // smaller so it fits well
                                  height: 24.h,
                                  colorFilter: ColorFilter.mode(
                                    Color(0xFF000000),
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Take Photo',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.lato(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF1D3856),
                                  letterSpacing: 0.2.sp,
                                ),
                              ),
                              Text(
                                "Capture Document With Camera ",
                                style: GoogleFonts.lato(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF747688),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //end box container
                  ],
                ),
              ),
            ),
            SizedBox(height: 50.h),
            Center(
              child: Container(
                height: 74.h,
                width: 389.h,
                decoration: BoxDecoration(
                  color: Color(0xFFEAFBD9),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0.r),
                      child: SvgPicture.asset(
                        'assets/images/document_svg/Supporticon.svg',
                        width: 24.w, // smaller so it fits well
                        height: 24.h,
                        colorFilter: ColorFilter.mode(
                          Color(0xFF000000),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Supported Formats',
                          style: GoogleFonts.lato(
                            fontSize: 15.29.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1D3856),
                          ),
                        ),
                        Text(
                          'PDF, DOC, DOCX, JPG, PNG files up to 10MB each',
                          style: GoogleFonts.lato(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF605959),
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
      ),
    );
  }
}
