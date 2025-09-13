import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parent_bridge/common/appColors.dart';
import '../../../../common/customFont.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_bridge/app/modules/document_vault/views/document_add.dart';
import '../controllers/document_vault_controller.dart' as dropdown_Controler;
import 'common/appColors.dart';
import '../controllers/document_vault_controller.dart';
import 'Document_Widget/custom_document_dialog.dart';
import 'Document_Widget/custom_document_dialog2.dart';
import 'Document_Widget/custom_floating_button.dart';
import 'Document_Widget/custom_document_card.dart';

class DocumentVaultView extends GetView<DocumentVaultController> {
  const DocumentVaultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Fixed Header Section
          Container(
            height: 147.h,
            padding: EdgeInsets.only(top: 20.r, left: 16.r, right: 16.r),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
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
                const Icon(Icons.arrow_back),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Document Vault",
                        style: h2.copyWith(
                          fontSize: 24.47.sp,
                          color: AppColors.textColor7,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(DocumentAdd());
                  },
                  child: Container(
                    height: 35.16.h,
                    width: 141.w,
                    decoration: BoxDecoration(
                      color: AppColors.lightPurplePink2,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(
                      child: Text(
                        'Add document',
                        style: GoogleFonts.lato(
                          fontSize: 18.16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textColor7,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.h),

          // 🔹 Search Bar
          Center(
            child: Container(
              width: 394.w,
              height: 46.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: AppColors.btnBorder, width: 1.5.w),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0.r),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search Documents",
                    hintStyle: GoogleFonts.lato(
                      color: AppColors.customGrey,
                      fontSize: 14.sp,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColors.customGrey,
                      size: 30,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10.h,
                      horizontal: 10.w,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 🔹 Filter Buttons
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Row(
              children: [
                SizedBox(
                  height: 28.h,
                  width: 63.w,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.category,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      "All (10)",
                      style: GoogleFonts.lato(
                        fontSize: 14.sp,
                        color: AppColors.darkSlateBlue,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),

                Obx(
                  () => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: PopupMenuButton<String>(
                      onSelected: (value) {
                        dropdown_Controler.selectedCategory.value = value;
                      },
                      offset: Offset(0, 40.h),
                      constraints: BoxConstraints(
                        minWidth: 135.w,
                        maxWidth: 140.w,
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          height: 30.h,
                          value: "Legal",
                          child: Container(
                            width: 46.59.w,
                            height: 21.38.h,
                            decoration: BoxDecoration(
                              color: AppColors.textCategory1,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Center(
                              child: Text(
                                "Legal",
                                style: h4.copyWith(
                                  color: AppColors.category1,
                                  fontSize: 12.09.sp,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          height: 30.h,
                          value: "Activities",
                          child: Container(
                            width: 71.59.w,
                            height: 21.38.h,
                            decoration: BoxDecoration(
                              color: AppColors.textCategory2,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Center(
                              child: Text(
                                "Activities",
                                style: h4.copyWith(
                                  color: AppColors.category2,
                                  fontSize: 12.09.sp,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          height: 30.h,
                          value: "Medical Records",
                          child: Container(
                            width: 106.59.w,
                            height: 21.38.h,
                            decoration: BoxDecoration(
                              color: AppColors.textCategory3,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Center(
                              child: Text(
                                "Medical Records",
                                style: h4.copyWith(
                                  color: AppColors.category3,
                                  fontSize: 12.09.sp,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          height: 20.h,
                          value: "School Documents",
                          child: Container(
                            width: 119.w,
                            height: 21.38.h,
                            decoration: BoxDecoration(
                              color: AppColors.textCategory4,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Center(
                              child: Text(
                                "School Documents",
                                style: h4.copyWith(
                                  color: AppColors.category4,
                                  fontSize: 12.09.sp,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                      child: Container(
                        height: 28.h,
                        width: 135.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: AppColors.category,
                            width: 0.7.w,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            dropdown_Controler.selectedCategory.value == null
                                ? Text(
                                    "Select category",
                                    style: h4.copyWith(
                                      fontSize: 12.sp,
                                      color: AppColors.category,
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                                : Container(
                                    padding: EdgeInsetsGeometry.all(2),
                                    decoration: BoxDecoration(
                                      color: _getCategoryColor(
                                        dropdown_Controler
                                            .selectedCategory
                                            .value!,
                                      ),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Text(
                                      dropdown_Controler
                                          .selectedCategory
                                          .value!,
                                      style: h4.copyWith(
                                        color: _getCategoryTextColor(
                                          dropdown_Controler
                                              .selectedCategory
                                              .value!,
                                        ),
                                        fontSize: 12.09.sp,
                                      ),
                                    ),
                                  ),
                            Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: AppColors.category,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 🔹 Scrollable Section
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 18.0.r,
                      top: 10.0.r,
                      right: 18.r,
                    ),
                    child: Column(
                      children: [
                        DocumentCard(
                          onTap: () {
                            Get.dialog(
                              Document_dialog(),
                              barrierColor: AppColors.lightPurplePink2
                                  .withOpacity(0.80.sp),
                            );
                          },
                          exp_date: '',
                          title: 'Parenting Plan Agreement',
                          label: 'Legal',
                          type: 'PDF',
                          person: 'Michael',
                          date: '2024-12-10',
                          labelcontainer: AppColors.category1,
                          bgcolor: AppColors.category1BG,
                          sidebar: AppColors.category1,
                        ),
                        SizedBox(height: 20.h),
                        DocumentCard(
                          onTap: () {
                            Get.dialog(
                              Document_dialog2_preview(),
                              barrierColor: AppColors.lightPurplePink2
                                  .withOpacity(0.80.sp),
                            );
                          },
                          exp_date: '',
                          title: 'Emma Medical Insurance Card',
                          label: 'Medical',
                          type: 'Image',
                          person: 'You',
                          date: '2024-12-10',
                          labelcontainer: AppColors.category3,
                          bgcolor: AppColors.category3BG,
                          sidebar: AppColors.category3,
                        ),
                        SizedBox(height: 20.h),
                        DocumentCard(
                          onTap: () {
                            Get.dialog(
                              Document_dialog(),
                              barrierColor: AppColors.lightPurplePink2
                                  .withOpacity(0.80.sp),
                            );
                          },
                          title: 'School Emergency Contact Form',
                          label: 'School',
                          type: 'Image',
                          exp_date: 'Expires.2024-12-10',
                          person: 'Michael',
                          date: '2024-12-10',
                          labelcontainer: AppColors.category4,
                          bgcolor: AppColors.category4BG,
                          sidebar: AppColors.category4,
                        ),
                        SizedBox(height: 20.h),
                        DocumentCard(
                          onTap: () {
                            Get.dialog(
                              Document_dialog(),
                              barrierColor: AppColors.lightPurplePink2
                                  .withOpacity(0.80),
                            );
                          },
                          title: 'Soccer Team Schedule',
                          label: 'Activities',
                          type: 'DOC',
                          exp_date: '',
                          person: 'Michael',
                          date: '2024-12-10',
                          labelcontainer: AppColors.category2,
                          bgcolor: AppColors.category2BG,
                          sidebar: AppColors.category2,
                        ),

                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Custom_floating_button(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

Color _getCategoryColor(String category) {
  switch (category) {
    case "Legal":
      return AppColors.textCategory1;
    case "Activities":
      return AppColors.textCategory2;
    case "Medical Records":
      return AppColors.textCategory3;
    case "School Documents":
      return AppColors.textCategory4;
    default:
      return AppColors.category;
  }
}

Color _getCategoryTextColor(String category) {
  switch (category) {
    case "Legal":
      return AppColors.category1;
    case "Activities":
      return AppColors.category2;
    case "Medical Records":
      return AppColors.category3;
    case "School Documents":
      return AppColors.category4;
    default:
      return AppColors.darkSlateBlue;
  }
}
