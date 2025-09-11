import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_bridge/app/modules/document_vault/views/document_add.dart';

import '../controllers/document_vault_controller.dart';
import 'Document_Widget/document_card.dart';

class DocumentVaultView extends GetView<DocumentVaultController> {
  const DocumentVaultView({super.key});

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
                  const Icon(Icons.arrow_back),
                  SizedBox(width: 12.w), // responsive width
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Document Vault",
                          style: GoogleFonts.lato(
                            fontSize: 24.47.sp, // responsive font size
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1D3856),
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
                        color: const Color(0xFFBD9DED),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Center(
                        child: Text(
                          'Add document',
                          style: TextStyle(
                            fontSize: 18.16.sp, // responsive font size
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1D3856),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ), //
            SizedBox(height: 15.h), // Search BOx
            Center(
              child: Container(
                width: 394.w, // corrected width
                height: 46.h, // corrected height
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: const Color(0xFFEBEBEB), // set your border color
                    width: 1.5.w, // border width
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search Documents",
                      hintStyle: TextStyle(
                        color: const Color(0xFFBEB4B4),
                        fontSize: 14.sp,
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color(0xFFBEB4B4),
                        size: 30,
                      ),
                      border: InputBorder.none,
                      // removes default TextField border
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10.h,
                        horizontal: 10.w,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //All & Select Category
            Padding(
              padding: EdgeInsets.all(16.w), // responsive padding
              child: Row(
                children: [
                  SizedBox(
                    height: 28.h,
                    width: 63.w,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF93C7E3),
                        // button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            10.r,
                          ), // rounded corners
                        ),
                        padding: EdgeInsets
                            .zero, // remove default padding to match container
                      ),
                      child: Text(
                        "All (10)",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xFF1D3856),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),

                  // ❌ Removed invalid SizedBox(height: 10.h,) inside Row
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: PopupMenuButton<String>(
                      onSelected: (value) {},
                      offset: Offset(0, 40.h),
                      // 👈 push popup 30.h below the button
                      constraints: BoxConstraints(
                        minWidth: 135.w, // 👈 set min width of the popup
                        maxWidth: 140.w, // 👈 optional max width
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          height: 30.h,
                          value: "Legal",
                          child: Container(
                            width: 46.59.w,
                            height: 21.38.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFEDCA),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Center(
                              child: Text(
                                "Legal",
                                style: TextStyle(
                                  color: const Color(0xFFFFAD13),
                                  fontSize: 12.09.sp,
                                ),
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
                              color: const Color(0xFFE4E9F4),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Center(
                              child: Text(
                                "Activities",
                                style: TextStyle(
                                  color: const Color(0xFF1E40AF),
                                  fontSize: 12.09.sp,
                                ),
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
                              color: const Color(0xFFFFE5E5),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Center(
                              child: Text(
                                "Medical Records",
                                style: TextStyle(
                                  color: const Color(0xFFEF4444),
                                  fontSize: 12.09.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          height: 30.h,
                          value: "School Documents",
                          child: Container(
                            width: 119.w,
                            height: 21.38.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFFDEFDDB),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Center(
                              child: Text(
                                "School Documents",
                                style: TextStyle(
                                  color: const Color(0xFF68B961),
                                  fontSize: 12.09.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],

                      // 👇 custom button design
                      child: Container(
                        height: 28.h,
                        width: 135.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: const Color(0xFF93C7E3),
                            width: 0.7.w,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Select category",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: const Color(0xFF93C7E3),
                              ),
                            ),
                            const Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: Color(0xFF93C7E3),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10.h), // responsive height

            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: document_card(),
                ),
              ],
            ),

            SizedBox(height: 40.h), // responsive height
          ],
        ),
      ),
    );
  }
}
