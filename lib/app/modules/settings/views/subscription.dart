import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parent_bridge/app/modules/subscription/views/wallet_view.dart';

import '../../../../common/custom_font.dart';

import 'package:get/get.dart';
import 'package:parent_bridge/common/app_colors.dart';


class Subscription extends StatelessWidget {
  const Subscription({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(
                      Icons.arrow_back_outlined,
                      color: AppColors.clrBlack,
                      size: 28.sp,
                    ),
                  ),
                  Text(
                    'Subscription',
                    style: h2.copyWith(
                      fontSize: 24.sp,
                      color: AppColors.txtclr4,
                    ),
                  ),
                  SizedBox(width: 28.w),
                ],
              ),
              SizedBox(height: 28.h),
              Container(
                padding: EdgeInsets.all(16.w),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.customblueclr2,
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
              InkWell(
                onTap: ()=>Get.to(WalletView()),
                child: Container(
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
                      "Update",
                      style: h2.copyWith(
                        fontSize: 18.sp,
                        color: AppColors.clrWhite,
                      ),
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

  Widget _buildInfoRow(String label, String value) {
    return RichText(
      text: TextSpan(
        style: h2.copyWith(
          fontSize: 18.sp,
          color: AppColors.txtclr3,
        ),
        children: [
          TextSpan(
            text: '$label : ',
            style: h4.copyWith(
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