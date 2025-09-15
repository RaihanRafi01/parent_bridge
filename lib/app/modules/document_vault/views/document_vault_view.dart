import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:parent_bridge/common/appColors.dart';
import '../../../../common/customFont.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_bridge/app/modules/document_vault/views/document_add.dart';
import '../controllers/document_vault_controller.dart' as dropdown_Controler;
import '../controllers/document_vault_controller.dart';
import 'Document_Widget/custom_document_dialog.dart';
import 'Document_Widget/custom_document_dialog2.dart';
import 'Document_Widget/custom_floating_button.dart';
import 'Document_Widget/custom_document_card.dart';

class DocumentVaultView extends GetView<DocumentVaultController> {
  const DocumentVaultView({super.key});

  @override
  Widget build(BuildContext context) {
    final docs = [
      {
        'dialog': const Document_dialog(),
        'exp_date': '',
        'title': 'Parenting Plan Agreement',
        'label': 'Legal',
        'type': 'PDF',
        'person': 'Michael',
        'date': '2024-12-10',
        'labelcontainer': AppColors.category1,
        'bgcolor': AppColors.category1BG,
        'sidebar': AppColors.category1,
      },
      {
        'dialog': Document_dialog2_preview(),
        'exp_date': '',
        'title': 'Emma Medical Insurance Card',
        'label': 'Medical Records',
        'type': 'Image',
        'person': 'You',
        'date': '2024-12-10',
        'labelcontainer': AppColors.category3,
        'bgcolor': AppColors.category3BG,
        'sidebar': AppColors.category3,
      },
      {
        'dialog': const Document_dialog(),
        'exp_date': 'Expires.2024-12-10',
        'title': 'School Emergency Contact Form',
        'label': 'School Documents',
        'type': 'Image',
        'person': 'Michael',
        'date': '2024-12-10',
        'labelcontainer': AppColors.category4,
        'bgcolor': AppColors.category4BG,
        'sidebar': AppColors.category4,
      },
      {
        'dialog': const Document_dialog(),
        'exp_date': '',
        'title': 'Soccer Team Schedule',
        'label': 'Activities',
        'type': 'DOC',
        'person': 'Michael',
        'date': '2024-12-10',
        'labelcontainer': AppColors.category2,
        'bgcolor': AppColors.category2BG,
        'sidebar': AppColors.category2,
      },
    ];

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
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
                GestureDetector(
                  onTap: Get.back,
                  child: SvgPicture.asset('assets/images/common/back_icon.svg'),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    "Document Vault",
                    style: h2.copyWith(
                      fontSize: 24.47.sp,
                      color: AppColors.textColor7,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(const DocumentAdd());
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

          // Search Bar
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
                  ),
                ),
              ),
            ),
          ),

          // Filter Buttons
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Row(
              children: [
                SizedBox(
                  height: 28.h,
                  width: 63.w,
                  child: ElevatedButton(
                    onPressed: () {
                      dropdown_Controler.selectedCategory.value = null;
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.category,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      "All (${docs.length})",
                      style: GoogleFonts.lato(
                        fontSize: 14.sp,
                        color: AppColors.darkSlateBlue,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),

                // Dropdown
                Obx(
                  () => PopupMenuButton<String>(
                    onSelected: (value) {
                      dropdown_Controler.selectedCategory.value = value;
                    },
                    offset: Offset(0, 40.h),
                    constraints: BoxConstraints(
                      minWidth: 135.w,
                      maxWidth: 140.w,
                    ),
                    itemBuilder: (context) => [
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
                                )
                              : Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 1.r,
                                    vertical: 2.r,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getCategoryColor(
                                      dropdown_Controler
                                          .selectedCategory
                                          .value!,
                                    ),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Text(
                                    dropdown_Controler.selectedCategory.value!,
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
              ],
            ),
          ),

          // Document list
          Expanded(
            child: Obx(() {
              final selected = dropdown_Controler.selectedCategory.value;
              final filteredDocs = selected == null
                  ? docs
                  : docs.where((d) => d['label'] == selected).toList();

              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 18.r, vertical: 10.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: filteredDocs.map((doc) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: DocumentCard(
                        onTap: () {
                          Get.dialog(
                            doc['dialog'] as Widget,
                            barrierColor: AppColors.lightPurplePink2
                                .withOpacity(0.80),
                          );
                        },
                        exp_date: doc['exp_date'] as String?,
                        title: doc['title'] as String,
                        label: doc['label'] as String,
                        type: doc['type'] as String,
                        person: doc['person'] as String,
                        date: doc['date'] as String,
                        labelcontainer: doc['labelcontainer'] as Color,
                        bgcolor: doc['bgcolor'] as Color,
                        sidebar: doc['sidebar'] as Color,
                      ),
                    );
                  }).toList(),
                ),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: const Custom_floating_button(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

// Helpers for menu
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
