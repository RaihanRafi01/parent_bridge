import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/customFont.dart';

import 'package:get/get.dart';

import '../../../../common/appColors.dart';
import '../../../../common/widgets/home/custom_listTile.dart';

class CoParentinformation extends StatelessWidget {
  const CoParentinformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.clrWhite,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 70.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back_outlined,
                      color: AppColors.blackactive,
                      size: 28.sp,
                    ),
                  ),
                  Text(
                    'Co-parent Information',
                    style: h2.copyWith( // FontWeight.w600
                      fontSize: 28.sp,
                      color: AppColors.txtclr5,
                    ),
                  ),
                  SizedBox(width: 28.w),
                ],
              ),
              SizedBox(height: 24.h),
              Text(
                'Full name',
                style: h2.copyWith( // FontWeight.w600
                  fontSize: 18.sp,
                  color: AppColors.txtclr4,
                ),
              ),
              CustomListTile(
                leadingSvgAsset: 'assets/images/settings/profile.svg',
                title: 'Michael Smith',
              ),
              SizedBox(height: 16.h),
              Text(
                'Email',
                style: h2.copyWith( // FontWeight.w600
                  fontSize: 18.sp,
                  color: AppColors.txtclr4,
                ),
              ),
              CustomListTile(
                leadingSvgAsset: 'assets/images/profile/mail.svg',
                title: 'michaelsmith@gmail.com',
              ),
              SizedBox(height: 16.h),
              Text(
                'Contact number',
                style: h2.copyWith( // FontWeight.w600
                  fontSize: 18.sp,
                  color: AppColors.txtclr4,
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
                    colors: [
                      AppColors.lightPurplePink2,
                      AppColors.customSkyBlue3,
                    ],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  ),
                  borderRadius: BorderRadius.circular(22.r),
                ),
                child: Center(
                  child: Text(
                    "Save",
                    style: h2.copyWith( // FontWeight.w600
                      fontSize: 18.sp,
                      color: AppColors.clrWhite,
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