import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:parent_bridge/app/modules/expense_tracker/views/paid_expense_view.dart';
import 'package:parent_bridge/app/modules/expense_tracker/views/pending_expense_view.dart';
import 'package:parent_bridge/common/appColors.dart';
import 'package:parent_bridge/common/customFont.dart';

import 'approved_expense_view.dart';

class NonEmptyExpenseTrackerView extends GetView {
  final List<dynamic> expenses;
  final TextEditingController amountController;
  final TextEditingController paymentMethodController;
  final Rx<String?> selectedPaymentMethod;
  final List<String> paymentMethodItems;

  const NonEmptyExpenseTrackerView({
    required this.expenses,
    required this.amountController,
    required this.paymentMethodController,
    required this.selectedPaymentMethod,
    required this.paymentMethodItems,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 32.h,
      children: expenses.map<Widget>((expense) {
        final statusMap = {
          'unpaid': 'Pending',
          'approved': 'Approved',
          'paid': 'Paid',
          'rejected': 'Rejected',
        };

        final share = expense['share'] ?? {};
        final yourShare = (share['your_share'] ?? 0).toDouble();
        final coParentShare = (share['co_parent_share'] ?? 0).toDouble();
        final amount =
            double.tryParse(expense['amount']?.toString() ?? '0') ?? 0.0;

        return ExpenseCard(
          title: expense['title'] ?? '',
          category: expense['category'] ?? 'Other',
          status: statusMap[expense['status']] ?? 'Pending',
          other: expense['co_parent']?['name'] ?? 'Co-parent',
          child: 'Child ${expense['child'] ?? ''}',
          paidDate: expense['paid_date'] ?? '',
          dueDate: expense['due_date'] ?? '',
          paymentMethod: expense['expense_payments']?.isNotEmpty == true
              ? expense['expense_payments'][0]['payment_method'] ?? 'Cash'
              : 'Cash',
          createdDate: expense['created_at']?.toString().split('T')[0] ?? '',
          approvedDate: '',
          completedDate: '',
          amount: amount,
          yourShare: yourShare,
          othersShare: coParentShare,
          amountController: amountController,
          paymentMethodController: paymentMethodController,
          selectedPaymentMethod: selectedPaymentMethod,
          paymentMethodItems: paymentMethodItems,
        );
      }).toList(),
    );
  }
}

class ExpenseCard extends StatelessWidget {
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
  final String completedDate;
  final double amount;
  final double yourShare;
  final double othersShare;
  final TextEditingController amountController;
  final TextEditingController paymentMethodController;
  final Rx<String?> selectedPaymentMethod;
  final List<String> paymentMethodItems;

  const ExpenseCard({
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
    required this.completedDate,
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
    return GestureDetector(
      onTap: () {
        if (status == 'Pending') {
          Get.dialog(
            PendingExpenseView(
              title: title,
              category: category,
              status: status,
              other: other,
              child: child,
              paidDate: paidDate,
              dueDate: dueDate,
              paymentMethod: paymentMethod,
              createdDate: createdDate,
              amount: amount,
              yourShare: 0,
              othersShare: 0,
            ),
          );
        }
        if (status == 'Approved') {
          Get.dialog(
            ApprovedExpenseView(
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
              yourShare: yourShare,
              othersShare: othersShare,
              amountController: amountController,
              paymentMethodController: paymentMethodController,
              selectedPaymentMethod: selectedPaymentMethod,
              paymentMethodItems: paymentMethodItems,
            ),
          );
        }
        if (status == 'Paid') {
          Get.dialog(
            PaidExpenseView(
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
              completedDate: completedDate,
              amount: amount,
              yourShare: yourShare,
              othersShare: othersShare,
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.96.r),
          color: category == 'Activity'
              ? AppColors.expenseCardLightColor
              : category == 'School'
              ? AppColors.expenseCardLightColor2
              : category == 'Medical'
              ? AppColors.expenseCardLightColor3
              : category == 'Food'
              ? AppColors.expenseCardLightColor4
              : category == 'Clothing'
              ? AppColors.expenseCardLightColor6
              : AppColors.expenseCardLightColor5,
          border: Border.all(
            color: AppColors.expenseCardBorderColor,
            width: 1.1.r,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.expenseCardBoxShadowColor.withAlpha(28),
              blurRadius: 4.38.r,
              offset: Offset(1.1.w, 1.1.h),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.96.r),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Container(
                  width: 8.w,
                  // height: 192.h,
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

                Padding(
                  padding: EdgeInsets.all(20.0.w),
                  child: SizedBox(
                    width: 346.w,
                    child: Column(
                      spacing: 20.h,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              spacing: 12.37.h,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: h2.copyWith(
                                    color: AppColors.textColor7,
                                    fontSize: 18.78.sp,
                                  ),
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
                                        borderRadius: BorderRadius.circular(
                                          850.75.r,
                                        ),
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
                                        borderRadius: BorderRadius.circular(
                                          850.75.r,
                                        ),
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

                                Row(
                                  children: [
                                    Text(
                                      'Your share • ',
                                      style: h4.copyWith(
                                        color: AppColors.textColor7,
                                        fontSize: 12.52.sp,
                                      ),
                                    ),

                                    Text(
                                      '\$$yourShare',
                                      style: h4.copyWith(
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
                                        fontSize: 13.52.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '\$$amount',
                                  style: h1.copyWith(
                                    color: AppColors.textColor7,
                                    fontSize: 26.03.sp,
                                  ),
                                ),

                                SizedBox(height: 7.54.h),

                                Text(
                                  '${((yourShare / (yourShare + othersShare)) * 100).toStringAsFixed(0)}/${((othersShare / (yourShare + othersShare)) * 100).toStringAsFixed(0)} %',
                                  style: h4.copyWith(
                                    color: AppColors.textColor7,
                                    fontSize: 16.81.sp,
                                  ),
                                ),

                                SizedBox(height: 52.29.h),

                                Row(
                                  children: [
                                    Text(
                                      'Michael • ',
                                      style: h4.copyWith(
                                        color: AppColors.textColor7,
                                        fontSize: 12.52.sp,
                                      ),
                                    ),

                                    Text(
                                      '\$$othersShare',
                                      style: h4.copyWith(
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
                                        fontSize: 13.52.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),

                        (status != 'Pending' && status != 'Rejected')
                            ? Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    width: 346.w,
                                    height: 12.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        100.r,
                                      ),
                                      color: AppColors.containerColor53,
                                    ),
                                  ),

                                  Container(
                                    width:
                                        (((yourShare + othersShare) / amount) *
                                                346)
                                            .w,
                                    height: 12.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        100.r,
                                      ),
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
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
