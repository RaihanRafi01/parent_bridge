import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:parent_bridge/app/modules/expense_tracker/views/payment_view.dart';

import '../../../../common/appColors.dart';
import '../../../../common/customFont.dart';
import '../../../../common/widgets/customButton.dart';

class ApprovedExpenseView extends GetView {
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

  const ApprovedExpenseView({
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
    super.key,
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
              padding: EdgeInsets.symmetric(
                horizontal: 21.34.w,
                vertical: 24.h,
              ),
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
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(29.1.r),
                  topRight: Radius.circular(29.1.r),
                ),
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
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        color: AppColors.gray,
                        size: 19.4.r,
                      ),
                    ),
                  ),
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 32.w,
                        vertical: 18.h,
                      ),
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
                            AppColors.gradientColor53,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
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

                          SizedBox(height: 16.h),

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
                                width:
                                    (((yourShare + othersShare) / amount) * 346)
                                        .w,
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
                                left:
                                    ((((yourShare + othersShare) / amount) *
                                                346) -
                                            12)
                                        .w,
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
                                    '${(((yourShare + othersShare) / amount) * 100).toStringAsFixed(0)}%',
                                    style: h0.copyWith(
                                      color: AppColors.clrWhite,
                                      fontSize: 6.72.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 3.h),

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
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.83.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 9.79.h,
                          children: [
                            Row(
                              spacing: 5.w,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/expense_tracker/parent.svg',
                                ),

                                Text(
                                  other,
                                  style: h4.copyWith(
                                    color: AppColors.textColor7,
                                    fontSize: 11.08.sp,
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              spacing: 5.w,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/expense_tracker/children.svg',
                                ),

                                Text(
                                  child,
                                  style: h4.copyWith(
                                    color: AppColors.textColor62,
                                    fontSize: 11.08.sp,
                                  ),
                                ),
                              ],
                            ),

                            Text(
                              'Paid Date • $paidDate',
                              style: h4.copyWith(
                                color: AppColors.textColor7,
                                fontSize: 12.52.sp,
                              ),
                            ),

                            Text(
                              'Due Date • $dueDate',
                              style: h4.copyWith(
                                color: AppColors.textColor63,
                                fontSize: 12.52.sp,
                              ),
                            ),

                            Text(
                              'Payment Method • $paymentMethod',
                              style: h4.copyWith(
                                color: AppColors.textColor7,
                                fontSize: 12.52.sp,
                              ),
                            ),

                            Text(
                              'Created • $createdDate',
                              style: h4.copyWith(
                                color: AppColors.textColor7,
                                fontSize: 12.52.sp,
                              ),
                            ),

                            Text(
                              'Approved • $approvedDate',
                              style: h4.copyWith(
                                color: AppColors.textColor7,
                                fontSize: 12.52.sp,
                              ),
                            ),
                          ],
                        ),

                        Row(
                          spacing: 11.03.w,
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.51.r),
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
                                borderRadius: BorderRadius.circular(850.75.r),
                              ),
                              child: Text(
                                category,
                                style: h3.copyWith(
                                  color: AppColors.clrWhite,
                                  fontSize: 11.91.sp,
                                ),
                              ),
                            ),

                            Container(
                              padding: EdgeInsets.all(8.51.r),
                              decoration: BoxDecoration(
                                color: status == 'Pending'
                                    ? AppColors.expenseCardStatusColor
                                    : status == 'Approved'
                                    ? AppColors.expenseCardStatusColor2
                                    : status == 'Paid'
                                    ? AppColors.expenseCardStatusColor3
                                    : AppColors.expenseCardStatusColor4,
                                borderRadius: BorderRadius.circular(850.75.r),
                              ),
                              child: Text(
                                status,
                                style: h3.copyWith(
                                  color: AppColors.clrWhite,
                                  fontSize: 11.91.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 21.h),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 25.h,
                      ),
                      decoration: BoxDecoration(
                        color: category == 'Activity'
                            ? AppColors.expenseCardColor.withAlpha(75)
                            : category == 'School'
                            ? AppColors.expenseCardColor2.withAlpha(75)
                            : category == 'Medical'
                            ? AppColors.expenseCardColor3.withAlpha(75)
                            : category == 'Food'
                            ? AppColors.expenseCardColor4.withAlpha(75)
                            : category == 'Clothing'
                            ? AppColors.expenseCardColor6.withAlpha(75)
                            : AppColors.expenseCardColor5.withAlpha(75),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        'New Cleats For Soccer Season - Nike Brand, Size 4 Youth',
                        style: h4.copyWith(
                          color: AppColors.textColor7,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),

                    SizedBox(height: 37.h),

                    CustomPBButton(
                      text: 'Mark As Paid',
                      color1: AppColors.buttonColor54,
                      color2: AppColors.buttonColor54,
                      borderColor: AppColors.buttonColor54,
                      horizontalPadding: 10.w,
                      verticalPadding: 10.h,
                      onPressed: () {
                        Get.back();

                        Get.dialog(
                          PaymentView(
                            title: title,
                            category: category,
                            status: status,
                            other: other,
                            child: child,
                            paidDate: paidDate,
                            dueDate: dueDate,
                            paymentMethod: paymentMethod,
                            createdDate: createdDate,
                            approvedDate: approvedDate,
                            amount: amount,
                            yourShare: 0,
                            othersShare: 0,
                            amountController: amountController,
                            paymentMethodController: paymentMethodController,
                            selectedPaymentMethod: selectedPaymentMethod,
                            paymentMethodItems: paymentMethodItems,
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 44.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomPBButton(
                          text: 'Edit',
                          icon: 'assets/images/expense_tracker/edit.svg',
                          horizontalPadding: 6.87,
                          verticalPadding: 6.87,
                          color1: AppColors.clrTransparent,
                          color2: AppColors.clrTransparent,
                          borderColor: AppColors.textColor7,
                          txtClr: AppColors.textColor7,
                          onPressed: () {},
                        ),

                        CustomPBButton(
                          text: 'Download',
                          icon: 'assets/images/expense_tracker/download.svg',
                          horizontalPadding: 6.87,
                          verticalPadding: 6.87,
                          color1: AppColors.clrTransparent,
                          color2: AppColors.clrTransparent,
                          borderColor: AppColors.textColor7,
                          txtClr: AppColors.textColor7,
                          onPressed: () {},
                        ),

                        CustomPBButton(
                          text: 'Delete',
                          icon: 'assets/images/expense_tracker/delete.svg',
                          horizontalPadding: 6.87,
                          verticalPadding: 6.87,
                          color1: AppColors.clrTransparent,
                          color2: AppColors.clrTransparent,
                          borderColor: AppColors.clrRed,
                          txtClr: AppColors.clrRed,
                          onPressed: () {},
                        ),
                      ],
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
