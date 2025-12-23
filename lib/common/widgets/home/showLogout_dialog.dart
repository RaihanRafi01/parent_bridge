import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_bridge/app/core/services/base_client.dart';
import 'package:parent_bridge/app/modules/authentication/views/sign_in_view.dart';

/// Log Out Dialog Widget
Widget showLogoutDialog() {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.r)),
    backgroundColor: Colors.white,
    child: Container(
      padding: EdgeInsets.all(24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Close Icon
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  color: Colors.grey.shade600,
                  size: 18.sp,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),

          // Title
          Text(
            'Log Out',
            style: GoogleFonts.lato(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1D3856),
            ),
          ),
          SizedBox(height: 16.h),

          // Subtitle
          Text(
            'Are you sure you want to Log out?',
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              fontSize: 16.sp,
              color: const Color(0xFF747688),
            ),
          ),
          SizedBox(height: 24.h),

          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Log Out Button
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    debugPrint('Logging out...');
                    // Clear tokens from secure storage
                    await BaseClient.clearTokens();
                    // Close dialog and navigate to sign in
                    Get.back();
                    Get.offAll(() => const SignInView());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD22853),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                  ),
                  child: Text(
                    'Log Out',
                    style: GoogleFonts.lato(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),

              // Cancel Button
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF0F0F0),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 13.h),
                  ),
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.lato(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF474747),
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
