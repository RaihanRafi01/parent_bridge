import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_bridge/app/modules/document_vault/views/upload_document.dart';
import 'package:parent_bridge/common/appColors.dart';

import '../../../../common/customFont.dart';
import '../bindings/document_vault_binding.dart';
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
                  colors: [AppColors.appColor2, AppColors.appColor],
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
                          style: h2.copyWith(
                            fontSize: 24.47.sp, // responsive font size

                            color: AppColors.darkSlateBlue,
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
                  color: AppColors.textInputFillColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Add New Document',
                      style: h1.copyWith(
                        fontSize: 20.sp,

                        color: AppColors.darkSlateBlue,
                      ),
                    ),
                    Text(
                      "Choose How You'd Like To Add Your Document",
                      style: h4.copyWith(
                        fontSize: 12.47.sp,

                        color: AppColors.textColorHint,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    //box container
                    InkWell(
                      onTap: () {
                        Get.lazyPut<DocumentVaultController>(
                          () => DocumentVaultController(),
                        );
                        Get.to(() => const UploadDocument());
                      },

                      child: Container(
                        height: 62.h,
                        width: 301.w,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.btnBorder,
                            // set your border color
                            width: 1.0.w, // border width
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.white.withOpacity(0.2),
                              // shadow color
                              spreadRadius: 1.r,
                              // how much it spreads
                              blurRadius: 6.r,
                              // softness
                              offset: const Offset(
                                0,
                                3,
                              ), // shadow position (x, y)
                            ),
                          ],
                          color: AppColors.white,
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
                                  color: AppColors.lightPurplePink2,
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
                                        AppColors.clrBlack,
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
                                  style: h2.copyWith(
                                    fontSize: 14.sp,

                                    color: AppColors.darkSlateBlue,
                                    letterSpacing: 0.2.sp,
                                  ),
                                ),
                                Text(
                                  "Select files from your device",
                                  style: h4.copyWith(
                                    fontSize: 12.sp,

                                    color: AppColors.textColorHint,
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
                          color: AppColors.btnBorder, // set your border color
                          width: 1.0.w, // border width
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.btnBorder.withOpacity(0.2),
                            // shadow color
                            spreadRadius: 1.r,
                            // how much it spreads
                            blurRadius: 6.r,
                            // softness
                            offset: const Offset(
                              0,
                              3,
                            ), // shadow position (x, y)
                          ),
                        ],
                        color: AppColors.white,
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
                                color: AppColors.appColor,
                                shape: BoxShape.circle, // 👈 makes it circular
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/images/document_svg/camera.svg',
                                  width: 24.w, // smaller so it fits well
                                  height: 24.h,
                                  colorFilter: ColorFilter.mode(
                                    AppColors.clrBlack,
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
                                style: h1.copyWith(
                                  fontSize: 14.sp,

                                  color: AppColors.darkSlateBlue,
                                  letterSpacing: 0.2.sp,
                                ),
                              ),
                              Text(
                                "Capture Document With Camera ",
                                style: h4.copyWith(
                                  fontSize: 12.sp,

                                  color: AppColors.textColorHint,
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
                  color: AppColors.liteGreenBg,
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
                          AppColors.clrBlack,
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
                          style: h2.copyWith(
                            fontSize: 15.29.sp,
                            color: AppColors.textColor7,
                          ),
                        ),
                        Text(
                          'PDF, DOC, DOCX, JPG, PNG files up to 10MB each',
                          style: h2.copyWith(
                            fontSize: 10.sp,

                            color: AppColors.greyClr,
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
