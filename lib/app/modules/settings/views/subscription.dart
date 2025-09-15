import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_bridge/common/appColors.dart';

class Subscription extends StatelessWidget {
  const Subscription({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w), // responsive padding
          child: Column(
            children: [
              SizedBox(height: 20.h), // top spacing

              // ---------- Header Row ----------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(
                      Icons.arrow_back_outlined,
                      color: AppColors.clrBlack,
                      size: 28.sp, // responsive size
                    ),
                  ),
                  Text(
                    'Subscription',
                    style: GoogleFonts.lato(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.txtclr4,
                    ),
                  ),
                  SizedBox(width: 28.w), // right side spacing
                ],
              ),

              SizedBox(height: 28.h),

              // ---------- Subscription Info Box ----------
              Container(
                padding: EdgeInsets.all(16.w),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFDFF5FF),
                  borderRadius: BorderRadius.circular(22.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow('Bill No', '133**455935'),
                    SizedBox(height: 20.h),
                    _buildInfoRow('User Name', 'Michael Smith'),
                    SizedBox(height: 20.h),
                    _buildInfoRow('Purchase Date', '19 FEB, 2025'),
                    SizedBox(height: 20.h),
                    _buildInfoRow('Subscription Type', 'ParentBridge Pro(+)'),
                    SizedBox(height: 20.h),
                    _buildInfoRow('Subscription Amount', '\$9.99'),
                    SizedBox(height: 20.h),
                    _buildInfoRow('Expire Date', '2.10.2025'),
                  ],
                ),
              ),

              const Spacer(),

              // ---------- Update Button ----------
              Container(
                height: 45.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFBD9DED), Color(0xFF90CAE2)],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  ),
                  borderRadius: BorderRadius.circular(22.r),
                ),
                child: Center(
                  child: Text(
                    "Update",
                    style: GoogleFonts.lato(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.clrWhite,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- Reusable Info Row ----------
  Widget _buildInfoRow(String label, String value) {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.lato(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.txtclr3,
        ),
        children: [
          TextSpan(
            text: '$label : ',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: AppColors.textColor7,
              fontSize: 18.sp,
            ),
          ),
          TextSpan(
            text: value,
          ),
        ],
      ),
    );
  }
}
