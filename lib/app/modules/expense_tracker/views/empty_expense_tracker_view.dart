import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../../common/appColors.dart';
import '../../../../common/customFont.dart';
import '../../../../common/widgets/customButton.dart';
import 'add_expense_view.dart';

class EmptyExpenseTrackerView extends GetView {
  final RxBool isExpenseEmpty;

  const EmptyExpenseTrackerView({
    required this.isExpenseEmpty,
    super.key
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 66.w, vertical: 32.h),
      decoration: BoxDecoration(
        color: AppColors.containerColor52,
        borderRadius: BorderRadius.circular(10),
      ),

      child: Column(
        children: [
          SvgPicture.asset(
              'assets/images/expense_tracker/dollar.svg'
          ),

          SizedBox(height: 21.5.h,),

          Text(
            'No Expenses Found',
            style: h2.copyWith(
              color: AppColors.darkSlateBlue,
              fontSize: 20.sp,
            ),
          ),

          SizedBox(height: 21.5.h,),

          Text(
            'Start By Adding Your First Shared Expense',
            style: h2.copyWith(
              color: AppColors.textColor60,
              fontSize: 14.sp,
            ),
          ),

          SizedBox(height: 24.h,),

          CustomPBButton(
            text: 'Add first expense',
            horizontalPadding: 24,
            onPressed: () => Get.to(AddExpenseView(isExpenseEmpty: isExpenseEmpty,)),
          ),
        ],
      ),
    );
  }
}
