import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:parent_bridge/common/widgets/customDropdown.dart';
import 'package:parent_bridge/common/widgets/customTextField.dart';

import '../../../../common/appColors.dart';
import '../../../../common/customFont.dart';
import '../../../../common/widgets/customButton.dart';

class PaymentView extends GetView {
  final String title;
  final String category;
  final String status;
  final String other;
  final String child;
  final String paidDate;
  final String dueDate;
  final String paymentMethod;
  final String createdDate;
  final String approvedDate;
  final double amount;
  final double yourShare;
  final double othersShare;
  final TextEditingController amountController;
  final TextEditingController paymentMethodController;
  final Rx<String?> selectedPaymentMethod;
  final List<String> paymentMethodItems;

  const PaymentView({
    required this.title,
    required this.category,
    required this.status,
    required this.other,
    required this.child,
    required this.paidDate,
    required this.dueDate,
    required this.paymentMethod,
    required this.createdDate,
    required this.approvedDate,
    required this.amount,
    required this.yourShare,
    required this.othersShare,
    required this.amountController,
    required this.paymentMethodController,
    required this.selectedPaymentMethod,
    required this.paymentMethodItems,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.clrWhite,
          borderRadius: BorderRadius.circular(29.1.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.clrBlack.withAlpha(64),
              blurRadius: 3.88.r,
              offset: Offset(0.97.w, 0.97.h),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 21.34.w, vertical: 24.h),
              decoration: BoxDecoration(
                color: category == 'Activity'
                    ? AppColors.expenseCardColor
                    : category == 'School'
                    ? AppColors.expenseCardColor2
                    : category == 'Medical'
                    ? AppColors.expenseCardColor3
                    : category == 'Food'
                    ? AppColors.expenseCardColor4
                    : category == 'Clothing'
                    ? AppColors.expenseCardColor6
                    : AppColors.expenseCardColor5,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(29.1.r), topRight: Radius.circular(29.1.r),),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.clrBlack.withAlpha(64),
                    blurRadius: 3.88.r,
                    offset: Offset(0.97.w, 0.97.h),
                  ),
                ],
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: h2.copyWith(
                      color: AppColors.clrWhite,
                      fontSize: 20.sp,
                    ),
                  ),

                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: EdgeInsets.all(8.74.r),
                      decoration: BoxDecoration(
                          color: AppColors.clrWhite,
                          shape: BoxShape.circle
                      ),
                      child: Icon(
                        Icons.close,
                        color: AppColors.gray,
                        size: 19.4.r,
                      ),
                    ),
                  )
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                top: 23.h,
                left: 20.w,
                right: 20.w,
                bottom: 45.h,
              ),

              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 18.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          gradient: LinearGradient(
                            colors: [
                              category == 'Activity'
                                  ? AppColors.expenseCardColor
                                  : category == 'School'
                                  ? AppColors.expenseCardColor2
                                  : category == 'Medical'
                                  ? AppColors.expenseCardColor3
                                  : category == 'Food'
                                  ? AppColors.expenseCardColor4
                                  : category == 'Clothing'
                                  ? AppColors.expenseCardColor6
                                  : AppColors.expenseCardColor5,
                              AppColors.gradientColor53
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          )
                      ),

                      child: Column(
                        children: [
                          Text(
                            '\$$amount',
                            style: h1.copyWith(
                              color: AppColors.textColor7,
                              fontSize: 36.85.sp,
                            ),
                          ),

                          SizedBox(height: 16.h,),

                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: 346.w,
                                height: 12.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.r),
                                  color: AppColors.containerColor53,
                                ),
                              ),

                              Container(
                                width: (((yourShare+othersShare)/amount)*346).w,
                                height: 12.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.r),
                                  color: category == 'Activity'
                                      ? AppColors.expenseCardColor
                                      : category == 'School'
                                      ? AppColors.expenseCardColor2
                                      : category == 'Medical'
                                      ? AppColors.expenseCardColor3
                                      : category == 'Food'
                                      ? AppColors.expenseCardColor4
                                      : category == 'Clothing'
                                      ? AppColors.expenseCardColor6
                                      : AppColors.expenseCardColor5,
                                ),
                              ),

                              Positioned(
                                left: ((((yourShare+othersShare)/amount)*346)-12).w,
                                top: -3.h,
                                child: Container(
                                  padding: EdgeInsets.all(3.r),
                                  decoration: BoxDecoration(
                                    color: category == 'Activity'
                                        ? AppColors.expenseCardColor
                                        : category == 'School'
                                        ? AppColors.expenseCardColor2
                                        : category == 'Medical'
                                        ? AppColors.expenseCardColor3
                                        : category == 'Food'
                                        ? AppColors.expenseCardColor4
                                        : category == 'Clothing'
                                        ? AppColors.expenseCardColor6
                                        : AppColors.expenseCardColor5,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    '${(((yourShare+othersShare)/amount)*100).toStringAsFixed(0)}%',
                                    style: h0.copyWith(
                                      color: AppColors.clrWhite,
                                      fontSize: 6.72.sp,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),

                          SizedBox(height: 3.h,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'You Pay',
                                    style: h2.copyWith(
                                      color: AppColors.textColor7,
                                      fontSize: 11.67.sp,
                                    ),
                                  ),

                                  Text(
                                    '\$$yourShare',
                                    style: h1.copyWith(
                                      color: AppColors.textColor7,
                                      fontSize: 17.24.sp,
                                    ),
                                  ),
                                ],
                              ),

                              Column(
                                children: [
                                  Text(
                                    other,
                                    style: h2.copyWith(
                                      color: AppColors.textColor7,
                                      fontSize: 11.67.sp,
                                    ),
                                  ),

                                  Text(
                                    '\$$othersShare',
                                    style: h1.copyWith(
                                      color: AppColors.textColor7,
                                      fontSize: 17.24.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                    SizedBox(height: 25.h,),

                    CustomTextField(
                      hintText: '\$Amount',
                      fillColor: AppColors.textInputFillColor,
                      controller: amountController,
                    ),

                    SizedBox(height: 16.13.h,),

                    CustomDropdown(
                      labelText: 'Payment Method',
                      items: paymentMethodItems,
                      value: selectedPaymentMethod,
                      onChanged: (value) {
                        print('Selected: $value');
                      },
                      fillColor: AppColors.textInputFillColor,
                    ),

                    SizedBox(height: 36.74.h,),

                    CustomPBButton(
                      text: 'Paid',
                      color1: AppColors.buttonColor54,
                      color2: AppColors.buttonColor54,
                      borderColor: AppColors.buttonColor54,
                      horizontalPadding: 10.w,
                      verticalPadding: 10.h,
                      onPressed: () {  },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
