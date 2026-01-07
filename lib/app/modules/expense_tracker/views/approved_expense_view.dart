import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:parent_bridge/app/modules/expense_tracker/views/payment_view.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/custom_font.dart';
import '../../../../common/widgets/custom_button.dart';

class ApprovedExpenseView extends StatelessWidget {
  final String title, category, status, other, child;
  final String paidDate, dueDate, paymentMethod, createdDate, approvedDate;
  final double amount, yourShare, othersShare;
  final TextEditingController amountController, paymentMethodController;
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

  Color get _catColor {
    switch (category) {
      case 'Activity': return AppColors.expenseCardColor;
      case 'School': return AppColors.expenseCardColor2;
      case 'Medical': return AppColors.expenseCardColor3;
      case 'Food': return AppColors.expenseCardColor4;
      case 'Clothing': return AppColors.expenseCardColor6;
      default: return AppColors.expenseCardColor5;
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = amount > 0 ? (yourShare + othersShare) / amount : 0.0;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.1.r)),
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
            // Fixed Header
            Container(
              padding: EdgeInsets.symmetric(horizontal: 21.34.w, vertical: 24.h),
              decoration: BoxDecoration(
                color: _catColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(29.1.r)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: h2.copyWith(color: AppColors.clrWhite, fontSize: 20.sp)),
                  GestureDetector(
                    onTap: Get.back,
                    child: Container(
                      padding: EdgeInsets.all(8.74.r),
                      decoration: const BoxDecoration(color: AppColors.clrWhite, shape: BoxShape.circle),
                      child: Icon(Icons.close, color: AppColors.gray, size: 19.4.r),
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable Body with safe max height
            Flexible(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 0.82.sh),
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(20.w, 23.h, 20.w, 30.h),
                  child: Column(
                    children: [
                      // Amount + Progress Card
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 18.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          gradient: LinearGradient(
                            colors: [_catColor, AppColors.gradientColor53],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text('\$$amount', style: h1.copyWith(color: AppColors.textColor7, fontSize: 36.85.sp)),
                            SizedBox(height: 16.h),
                            LayoutBuilder(
                              builder: (context, constraints) {
                                final barWidth = constraints.maxWidth;
                                final filled = (progress * barWidth).clamp(0.0, barWidth);
                                return Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      width: barWidth,
                                      height: 12.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100.r),
                                        color: AppColors.containerColor53,
                                      ),
                                    ),
                                    Container(
                                      width: filled,
                                      height: 12.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100.r),
                                        color: _catColor,
                                      ),
                                    ),
                                    if (progress > 0 && progress < 1)
                                      Positioned(
                                        left: filled - 12.w,
                                        top: -3.h,
                                        child: Container(
                                          padding: EdgeInsets.all(3.r),
                                          decoration: BoxDecoration(color: _catColor, shape: BoxShape.circle),
                                          child: Text(
                                            '${(progress * 100).toStringAsFixed(0)}%',
                                            style: h0.copyWith(color: AppColors.clrWhite, fontSize: 6.72.sp),
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(children: [
                                  Text('You Pay', style: h2.copyWith(color: AppColors.textColor7, fontSize: 11.67.sp)),
                                  Text('\$$yourShare', style: h1.copyWith(color: AppColors.textColor7, fontSize: 17.24.sp)),
                                ]),
                                Column(children: [
                                  Text(other, style: h2.copyWith(color: AppColors.textColor7, fontSize: 11.67.sp)),
                                  Text('\$$othersShare', style: h1.copyWith(color: AppColors.textColor7, fontSize: 17.24.sp)),
                                ]),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20.83.h),

                      // Info Section
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _infoRow('assets/images/expense_tracker/parent.svg', other),
                              _infoRow('assets/images/expense_tracker/children.svg', child, color: AppColors.textColor62),
                              _infoText('Paid Date • $paidDate'),
                              _infoText('Due Date • $dueDate', color: AppColors.textColor63),
                              _infoText('Payment Method • $paymentMethod'),
                              _infoText('Created • $createdDate'),
                              _infoText('Approved • $approvedDate'),
                            ].withSpaceBetween(height: 9.79.h),
                          ),
                          Row(children: [
                            _badge(category, _catColor),
                            SizedBox(width: 11.w),
                            _badge(status, _statusColor),
                          ]),
                        ],
                      ),

                      SizedBox(height: 21.h),

                      // Description
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 25.h),
                        decoration: BoxDecoration(color: _catColor.withAlpha(75), borderRadius: BorderRadius.circular(10.r)),
                        child: Text(
                          'New Cleats For Soccer Season - Nike Brand, Size 4 Youth',
                          style: h4.copyWith(color: AppColors.textColor7, fontSize: 14.sp),
                        ),
                      ),

                      SizedBox(height: 37.h),

                      // Mark as Paid
                      CustomPBButton(
                        text: 'Mark As Paid',
                        color1: AppColors.buttonColor54,
                        color2: AppColors.buttonColor54,
                        borderColor: AppColors.buttonColor54,
                        horizontalPadding: 10.w,
                        verticalPadding: 10.h,
                        onPressed: () {
                          Get.back();
                          Get.dialog(PaymentView(
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
                          ));
                        },
                      ),

                      SizedBox(height: 44.h),

                      // Action Buttons – Responsive & Correct Colors
                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        runSpacing: 12,
                        children: [
                          _actionButton('Edit', 'assets/images/expense_tracker/edit.svg', AppColors.textColor7),
                          _actionButton('Download', 'assets/images/expense_tracker/download.svg', AppColors.textColor7),
                          _actionButton('Delete', 'assets/images/expense_tracker/delete.svg', AppColors.clrRed),
                        ],
                      ),

                      SizedBox(height: 20.h), // safe bottom padding
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widgets
  Widget _infoRow(String icon, String text, {Color? color}) => Row(
    children: [
      SvgPicture.asset(icon),
      SizedBox(width: 5.w),
      Text(text, style: h4.copyWith(color: color ?? AppColors.textColor7, fontSize: 11.08.sp)),
    ],
  );

  Widget _infoText(String text, {Color? color}) => Text(
    text,
    style: h4.copyWith(color: color ?? AppColors.textColor7, fontSize: 12.52.sp),
  );

  Color get _statusColor {
    if (status == 'Pending') return AppColors.expenseCardStatusColor;
    if (status == 'Approved') return AppColors.expenseCardStatusColor2;
    if (status == 'Paid') return AppColors.expenseCardStatusColor3;
    return AppColors.expenseCardStatusColor4;
  }

  Widget _badge(String text, Color bg) => Container(
    padding: EdgeInsets.all(8.51.r),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(850.r)),
    child: Text(text, style: h3.copyWith(color: AppColors.clrWhite, fontSize: 11.91.sp)),
  );

  Widget _actionButton(String text, String icon, Color color) => CustomPBButton(
    text: text,
    icon: icon,
    horizontalPadding: 12,
    verticalPadding: 9,
    color1: AppColors.clrTransparent,
    color2: AppColors.clrTransparent,
    borderColor: color,
    txtClr: color,          // This was missing before → text was invisible!
    onPressed: () {},
  );
}

extension WidgetListSpacing on List<Widget> {
  List<Widget> withSpaceBetween({double? width, double? height}) {
    if (length <= 1) return this;
    return List.generate(length * 2 - 1, (i) => i.isEven ? this[i ~/ 2] : SizedBox(width: width, height: height));
  }
}