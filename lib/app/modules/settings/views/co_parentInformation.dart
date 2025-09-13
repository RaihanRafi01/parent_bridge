import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common/widgets/home/custom_listTile.dart';

class CoParentinformation extends StatelessWidget {
  const CoParentinformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w), // used ScreenUtil for width
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 70.h), // responsive height
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back_outlined,
                      color: Colors.black,
                      size: 28.sp, // responsive icon size
                    ),
                  ),
                  Text(
                    'Co-parent Information',
                    style: GoogleFonts.lato(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1D3856),
                    ),
                  ),
                  SizedBox(width: 28.w), // keep space on the right side
                ],
              ),

              SizedBox(height: 24.h),
              Text(
                'Full name',
                style: GoogleFonts.lato(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF474747),
                ),
              ),
              CustomListTile(
                leadingSvgAsset: 'assets/images/settings/profile.svg',
                title: 'Michael Smith',
              ),

              SizedBox(height: 16.h),
              Text(
                'Email',
                style: GoogleFonts.lato(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF474747),
                ),
              ),
              CustomListTile(
                leadingSvgAsset: 'assets/images/profile/mail.svg',
                title: 'michaelsmith@gmail.com',
              ),

              SizedBox(height: 16.h),
              Text(
                'Contact number',
                style: GoogleFonts.lato(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF474747),
                ),
              ),
              CustomListTile(
                leadingSvgAsset: 'assets/images/profile/contact.svg',
                title: '+881 01405366393',
              ),

              SizedBox(height: 40.h),
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
                    "Save",
                    style: GoogleFonts.lato(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
