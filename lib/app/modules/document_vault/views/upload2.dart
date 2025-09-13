import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/document_vault_controller.dart';
import 'Custom_button_add_document.dart';

class UploadDocument2 extends GetView<DocumentVaultController> {
  const UploadDocument2({super.key});

  // ✅ helper function for category chips
  Widget _buildCategoryChip(
    String label,
    Color bgColor,
    Color textColor,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? textColor : bgColor, // active vs inactive
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : textColor, // text toggle
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Top Gradient Header
            Container(
              height: 147.h,
              padding: EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFCB93F2), Color(0xFF89C5E1)],
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
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      "Add Document",
                      style: GoogleFonts.lato(
                        fontSize: 24.47.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1D3856),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40.h),

            // 🔹 Document Image Placeholder
            Center(
              child: Container(
                height: 109.h,
                width: 112.52.w,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1), // shadow color
                      spreadRadius: 1.r, // how much it spreads
                      blurRadius: 6.r, // softness
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

            // 🔹 Select Child's
            CustomButtonAddDocument(
              padding3: 10.r,
              padding2: 10.r,
              padding4: 20.r,
              padding: 10.r,
              height: 56.h,
              width: 382.73.w,
              text: "Select child's",
              icon: const Icon(
                Icons.keyboard_arrow_down_outlined,
                color: Color(0xFF747688),
              ),
            ),

            SizedBox(height: 20.h),

            // 🔹 Enter Document Name
            Center(
              child: Container(
                height: 56.h,
                width: 382.73.w,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFFEBEBEB),
                    width: 1.0.w,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFEDEDED).withValues(alpha: 1.0),
                      spreadRadius: 1.r,
                      blurRadius: 6.r,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  color: const Color(0xFFEAF8FF),
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: TextField(
                    style: TextStyle(
                      color: const Color(0xFF747688),
                      fontSize: 14.sp,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter Document Name',
                      hintStyle: TextStyle(
                        color: const Color(0xFF747688),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
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

            // 🔹 Select Category Title
            CustomButtonAddDocument(
              padding3: 10.r,
              padding2: 10.r,
              padding4: 20.r,
              padding: 10.r,
              height: 56.h,
              width: 382.73.w,
              text: "Select Category",
              icon: const Icon(
                Icons.keyboard_arrow_down_outlined,
                color: Color(0xFF747688),
              ),
            ),

            SizedBox(height: 20.h),

            // 🔹 Category Chips
            Center(
              child: StatefulBuilder(
                builder: (context, setState) {
                  String? selectedCategory;

                  return Container(
                    width: 382.w,
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFF93C7E3),
                        width: 0.7.w,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFEDEDED).withValues(alpha: 0.5),
                          spreadRadius: 1.r,
                          blurRadius: 6.r,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    child: Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: [
                        SizedBox(width: 25.w),
                        _buildCategoryChip(
                          "Legal",
                          Color(0xFFFFEDCA),
                          Color(0xFFFFAD13),
                          selectedCategory == "Legal",
                          () => setState(() => selectedCategory = "Legal"),
                        ),
                        _buildCategoryChip(
                          "Activities",
                          Color(0xFFE4E9F4),
                          Color(0xFF1E40AF),
                          selectedCategory == "Activities",
                          () => setState(() => selectedCategory = "Activities"),
                        ),
                        _buildCategoryChip(
                          "Medical Records",
                          Color(0xFFFFE5E5),
                          Color(0xFFEF4444),
                          selectedCategory == "Medical Records",
                          () => setState(
                            () => selectedCategory = "Medical Records",
                          ),
                        ),
                        SizedBox(width: 25.w),
                        _buildCategoryChip(
                          "School Documents",
                          Color(0xFFDEFDDB),
                          Color(0xFF68B961),
                          selectedCategory == "School Documents",
                          () => setState(
                            () => selectedCategory = "School Documents",
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 20.h),

            // 🔹 Description
            Center(
              child: Container(
                height: 94.h,
                width: 383.w,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFFEBEBEB),
                    width: 1.0.w,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFEDEDED).withValues(alpha: 1.0),
                      spreadRadius: 1.r,
                      blurRadius: 6.r,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  color: const Color(0xFFEAF8FF),
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.w,
                    vertical: 15.h,
                  ),
                  child: TextField(
                    style: TextStyle(
                      color: const Color(0xFF747688),
                      fontSize: 14.sp,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Add a Description',
                      hintStyle: TextStyle(
                        color: const Color(0xFF747688),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
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

            // 🔹 Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 52.h,
                  width: 181.w,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFEBEBEB),
                      width: 1.0.w,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  child: Center(
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: const Color(0xFFBD9DED),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20.w),
                Container(
                  height: 52.h,
                  width: 181.w,
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
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
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
