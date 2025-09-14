import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:parent_bridge/common/appColors.dart';
import 'package:parent_bridge/common/customFont.dart';


import '../../../document_vault/controllers/document_vault_controller.dart';
import 'custom_textfeild.dart';

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
                gradient: LinearGradient(
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
                          "New Post",
                          style: h2.copyWith(
                            fontSize: 24.47.sp, // responsive font size

                            color: AppColors.textColor7,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.h),


            SizedBox(height: 20.h),

            Center(
              child: Container(
                height: 56.h,
                width: 382.73.w, // 👈 should use .w instead of .sp for width
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.btnBorder, width: 1.0.w),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.btnBorder.withOpacity(1),
                      spreadRadius: 1.r,
                      blurRadius: 6.r,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  color: AppColors.textInputFillColor,
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
                    style: TextStyle(
                      color: AppColors.textColorHint,
                      fontSize: 14.sp,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter Title',
                      //  correct way
                      hintStyle: h4.copyWith(
                        color: AppColors.textColorHint,
                        fontSize: 14.sp,
                      ),
                      border: InputBorder.none,
                      //  removes default underline
                      isDense: true,
                      //  keeps it compact
                      contentPadding: EdgeInsets.zero, //  aligns nicely
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.h),
            InkWell(
              onTap: () {
                // Get.to(UploadDocument2());
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
                  color: AppColors.textColorHint,
                ),
              ),
            ),
            SizedBox(height: 20.h),


            Center(
              child: Container(
                height: 94.h,
                width: 383.w, // 👈 should use .w instead of .sp for width
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.btnBorder, width: 1.0.w),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.borderColor.withOpacity(1.0),
                      spreadRadius: 1.r,
                      blurRadius: 6.r,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  color: AppColors.textInputFillColor,
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
                    style: TextStyle(
                      color: AppColors.textColorHint,
                      fontSize: 14.sp,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Add a Description',
                      // ✅ correct way
                      hintStyle: h4.copyWith(
                        color: AppColors.textColorHint,
                        fontSize: 14.sp,
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

                InkWell(
                  onTap: () {
                    // Get.to(UploadDocument2());
                  },
                  child: Container(
                    height: 52.h,
                    width: double.infinity, // 👈 should use .w instead of .sp for width
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.btnBorder,

                      ),

                      gradient: LinearGradient(
                        colors: [AppColors.appColor2, AppColors.appColor],
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                      ),
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    child: Center(
                      child: Text(
                        'Add Document',
                        style: h1.copyWith(
                          color: AppColors.clrWhite,
                          fontSize: 18.sp,
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
