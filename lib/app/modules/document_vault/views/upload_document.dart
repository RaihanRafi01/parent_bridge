import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/document_vault_controller.dart';
import 'package:parent_bridge/common/appColors.dart';
import '../../../../common/customFont.dart';
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
            // Header
            Container(
              height: 147.h,
              padding: EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.appColor2, AppColors.appColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.r),
                  bottomRight: Radius.circular(40.r),
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
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Add Document",
                          style: h2.copyWith(
                            fontSize: 24.47.sp,
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

            // File preview box
            Center(
              child: Container(
                height: 109.h,
                width: 112.52.w,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.clrBlack.withOpacity(0.1),
                      spreadRadius: 1.r,
                      blurRadius: 6.r,
                      offset: const Offset(1, 3),
                    ),
                  ],
                  color: AppColors.white,
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
                            width: 13.w,
                            height: 13.h,
                            colorFilter: const ColorFilter.mode(
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
                      style: h4.copyWith(
                        fontSize: 14.14.sp,
                        color: AppColors.textColorHint,
                      ),
                    ),
                    Text(
                      '2.6MB',
                      style: h4.copyWith(
                        fontSize: 6.29.sp,
                        color: AppColors.textColorHint,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20.h),

            // Select child button
            CustomButtonAddDocument(
              padding3: 10.r,
              padding2: 10.r,
              padding4: 20.r,
              padding: 10.r,
              height: 56.h,
              width: 382.73.sp,
              text: "Select child's",
              icon: const Icon(
                Icons.keyboard_arrow_down_outlined,
                color: AppColors.textColorHint,
              ),
            ),

            SizedBox(height: 20.h),

            // Document name input
            Center(
              child: Container(
                height: 56.h,
                width: 382.73.w,
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
                      hintText: 'Enter Document Name',
                      hintStyle: h4.copyWith(
                        color: AppColors.textColorHint,
                        fontSize: 14.sp,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.h),

            // ✅ Select Category with same logic as first page
            Obx(
              () => InkWell(
                onTap: () {
                  showMenu<String>(
                    context: context,

                    position: RelativeRect.fromLTRB(50.w, 530.h, 50.w, 200.h),
                    items: [
                      _buildCategoryMenu(
                        "Legal",
                        AppColors.textCategory1,
                        AppColors.category1,
                      ),
                      _buildCategoryMenu(
                        "Activities",
                        AppColors.textCategory2,
                        AppColors.category2,
                      ),
                      _buildCategoryMenu(
                        "Medical Records",
                        AppColors.textCategory3,
                        AppColors.category3,
                      ),
                      _buildCategoryMenu(
                        "School Documents",
                        AppColors.textCategory4,
                        AppColors.category4,
                      ),
                    ],
                  ).then((value) {
                    if (value != null) {
                      controller.selectedCategory.value = value;
                    }
                  });
                },
                child: CustomButtonAddDocument(
                  padding3: 10.r,
                  padding2: 10.r,
                  padding4: 20.r,
                  padding: 10.r,
                  height: 56.h,
                  width: 382.73.sp,
                  text: controller.selectedCategory.value ?? "Select Category",
                  icon: const Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: AppColors.textColorHint,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.h),

            // Expiry date button
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
                color: AppColors.textColorHint,
              ),
            ),

            SizedBox(height: 20.h),

            // Description input
            Center(
              child: Container(
                height: 94.h,
                width: 383.w,
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
                      hintStyle: h4.copyWith(
                        color: AppColors.textColorHint,
                        fontSize: 14.sp,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 70.h),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 52.h,
                    width: 181.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.btnBorder,
                        width: 1.0.w,
                      ),
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: h1.copyWith(
                          color: AppColors.radioColor,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20.w),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 52.h,
                    width: 181.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.btnBorder,
                        width: 1.0.w,
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

// ✅ Reused from first page
PopupMenuItem<String> _buildCategoryMenu(
  String value,
  Color bgColor,
  Color textColor,
) {
  return PopupMenuItem(
    height: 30.h,
    value: value,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 3.r, vertical: 2.r),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Center(
        child: Text(
          value,
          style: h4.copyWith(color: textColor, fontSize: 12.09.sp),
          textAlign: TextAlign.left,
        ),
      ),
    ),
  );
}
