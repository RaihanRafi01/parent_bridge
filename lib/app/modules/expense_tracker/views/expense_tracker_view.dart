import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:parent_bridge/common/appColors.dart';
import 'package:parent_bridge/common/customFont.dart';

import '../controllers/expense_tracker_controller.dart';

class ExpenseTrackerView extends GetView<ExpenseTrackerController> {
  const ExpenseTrackerView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(27.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40.r), bottomRight: Radius.circular(40.r),),
                gradient: LinearGradient(
                  colors: [AppColors.lightPurplePink2, AppColors.customSkyBlue3],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                spacing: 23.h,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Expense Tracker',
                        style: h2.copyWith(
                          color: AppColors.textColor51,
                          fontSize: 24.47.sp,
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.all(9.08.r),
                        decoration: BoxDecoration(
                            color: AppColors.card54,
                            borderRadius: BorderRadius.circular(10.r),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.clrBlack.withAlpha(64),
                                blurRadius: 4.r,
                                offset: Offset(0.w, 4.h),
                              )
                            ]
                        ),

                        child: Text(
                          'Add Expense',
                          style: h3.copyWith(
                            color: AppColors.textColor51,
                            fontSize: 18.16.sp,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 26.h,),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                        color: AppColors.card55.withAlpha(26),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 14.8.r,
                          ),
                          BoxShadow(
                            color: AppColors.violet,
                            blurRadius: 29.6.r,
                            blurStyle: BlurStyle.inner,
                            offset: Offset(0.w, 22.2.h),
                          ),
                          BoxShadow(
                            color: AppColors.violet2,
                            blurRadius: 11.1.r,
                            blurStyle: BlurStyle.inner,
                            offset: Offset(0.w, 7.4.h),
                          ),
                        ]
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
