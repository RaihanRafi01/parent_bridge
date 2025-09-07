import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../appColors.dart';
import '../../customFont.dart';


class DashboardStats extends StatelessWidget {
  final String messagesToday;
  final String eventsThisWeek;
  final String pendingExpenses;

  const DashboardStats({
    super.key,
    required this.messagesToday,
    required this.eventsThisWeek,
    required this.pendingExpenses,
  });

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/home/img.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(10.w),
        child: Row(
          children: [
            // Left section - Messages Today
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    messagesToday,
                    style: h2Inter.copyWith(
                      fontSize: 27.sp,
                      color: AppColors.darkSlateBlue,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Messages Today',
                    style: h2Inter.copyWith(
                      fontSize: 11.sp,
                      color: AppColors.darkSlateBlue,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 4.h),
            // First divider
            Container(
              width: 1.w,
              height: 60.h,
              color: AppColors.dividerPurple.withOpacity(0.6),
            ),
            SizedBox(width: 4.h),
            // Middle section - Events This Week
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      eventsThisWeek,
                      style: h2Inter.copyWith(
                        fontSize: 27.sp,
                        color: AppColors.darkSlateBlue,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Events This Week',
                      style: h2Inter.copyWith(
                        fontSize: 11.sp,
                        color: AppColors.darkSlateBlue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 4.h),
            // Second divider
            Container(
              width: 1.w,
              height: 60.h,
              color: AppColors.dividerPurple.withOpacity(0.6),
            ),
            SizedBox(width: 4.h),
            // Right section - Pending Expenses
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      pendingExpenses,
                      style: h2Inter.copyWith(
                        fontSize: 27.sp,
                        color: AppColors.darkSlateBlue,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Pending Expenses',
                      style: h2Inter.copyWith(
                        fontSize: 11.sp,
                        color: AppColors.darkSlateBlue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}