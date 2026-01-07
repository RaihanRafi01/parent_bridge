import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:parent_bridge/app/modules/expense_tracker/controllers/add_expense_controller.dart';
import 'package:parent_bridge/common/customFont.dart';
import 'package:parent_bridge/common/widgets/customButton.dart';
import 'package:parent_bridge/common/widgets/customTextField.dart';

import '../../../../common/appColors.dart';
import '../../../../common/widgets/customDropdown.dart';
import '../../../../common/widgets/nav/circularMenuWidget.dart';

class AddExpenseView extends GetView<AddExpenseController> {
  final RxBool isExpenseEmpty;

  const AddExpenseView({required this.isExpenseEmpty, super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(AddExpenseController());

    return Scaffold(
      body: Column(
        children: [
          // Fixed header (doesn't scroll)
          Container(
            padding: EdgeInsets.only(left: 20.w, top: 65.h, bottom: 43.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.r),
                bottomRight: Radius.circular(40.r),
              ),
              gradient: LinearGradient(
                colors: [AppColors.lightPurplePink2, AppColors.customSkyBlue3],
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: Get.back,
                  child: SvgPicture.asset('assets/images/common/back_icon.svg'),
                ),
                SizedBox(width: 21.5.w), // Fixed spacing
                Text(
                  'Add New Expense',
                  style: h2.copyWith(
                    color: AppColors.textColor7,
                    fontSize: 24.47.sp,
                  ),
                ),
              ],
            ),
          ),
          // Scrollable content below header
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 57.h),

                  Obx(() {
                    return CustomDropdown(
                      labelText: 'Select Child\'s',
                      items: controller.childItems.toList(),
                      value: controller.selectedChild,
                      onChanged: (value) {
                        print('Selected: $value');
                      },
                      fillColor: AppColors.textInputFillColor,
                    );
                  }),

                  SizedBox(height: 18.h),

                  CustomTextField(
                    hintText: 'Enter Expense Title',
                    fillColor: AppColors.textInputFillColor,
                    controller: controller.expenseTitleController,
                  ),

                  SizedBox(height: 18.h),

                  CustomDropdown(
                    labelText: 'Payment Method',
                    items: controller.paymentMethodItems,
                    value: controller.selectedPaymentMethod,
                    onChanged: (value) {
                      print('Selected: $value');
                    },
                    fillColor: AppColors.textInputFillColor,
                  ),

                  SizedBox(height: 18.h),

                  CustomTextField(
                    hintText: 'Paid Date',
                    suffixIcon: 'assets/images/expense_tracker/calender.svg',
                    onSuffixTap: () => controller.selectDate(context, true),
                    fillColor: AppColors.textInputFillColor,
                    controller: controller.paidDateController,
                    isDatePicker: true,
                  ),

                  SizedBox(height: 18.h),

                  CustomTextField(
                    hintText: 'Due Date',
                    suffixIcon: 'assets/images/expense_tracker/calender.svg',
                    onSuffixTap: () => controller.selectDate(context, false),
                    fillColor: AppColors.textInputFillColor,
                    controller: controller.dueDateController,
                    isDatePicker: true,
                  ),

                  SizedBox(height: 18.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 36.0.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextField(
                          hintText: '\$ Amount',
                          width: 190.w,
                          fillColor: AppColors.textInputFillColor,
                          controller: controller.amountController,
                        ),

                        CustomDropdown(
                          labelText: 'Select Category',
                          width: 190.w,
                          items: controller.categoryItems,
                          value: controller.selectedCategory,
                          onChanged: (value) {
                            print('Selected: $value');
                          },
                          fillColor: AppColors.textInputFillColor,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 18.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 36.0.w),
                    child: Container(
                      padding: EdgeInsets.all(27.r),
                      decoration: BoxDecoration(
                        color: AppColors.textInputFillColor,
                        borderRadius: BorderRadius.circular(50.r),
                        border: Border.all(color: AppColors.borderColor),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.boxShadowColor52.withAlpha(36),
                            blurRadius: 12.6.r,
                            offset: Offset(0.w, 8.h),
                          ),
                        ],
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Split Percentage Share (%)',
                                style: h2.copyWith(
                                  color: AppColors.textColorHint,
                                  fontSize: 18.sp,
                                ),
                              ),

                              Obx(() {
                                return Text(
                                  controller.percent.value != 100
                                      ? '${controller.percent.value.toStringAsFixed(2)}%'
                                      : '100%',
                                  style: h1.copyWith(
                                    color: AppColors.textColor61,
                                    fontSize: 25.5.sp,
                                  ),
                                );
                              }),
                            ],
                          ),

                          SizedBox(height: 12.h),

                          Text(
                            'Your Share:',
                            style: h3.copyWith(
                              color: AppColors.textColorHint,
                              fontSize: 12.sp,
                            ),
                          ),

                          SizedBox(height: 15.h),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () => controller.minus(),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 9.r,
                                    vertical: 15.h,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3.r),
                                    color: AppColors.textColor61,
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/images/expense_tracker/minus.svg',
                                  ),
                                ),
                              ),

                              Obx(
                                () => SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    trackHeight: 6,
                                    thumbShape: const RoundSliderThumbShape(
                                      enabledThumbRadius: 10,
                                    ),
                                    overlayShape:
                                        SliderComponentShape.noOverlay,
                                    activeTrackColor: AppColors.textColor61,
                                    inactiveTrackColor: AppColors.clrWhite,
                                    thumbColor: AppColors.textColor61,
                                  ),
                                  child: Slider(
                                    value: controller.percent.value,
                                    min: 0,
                                    max: 100,
                                    onChanged: (v) =>
                                        controller.percent.value = v,
                                  ),
                                ),
                              ),

                              GestureDetector(
                                onTap: () => controller.plus(),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 9.r,
                                    vertical: 10.h,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3.r),
                                    color: AppColors.textColor61,
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/images/expense_tracker/plus.svg',
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 25.h),

                          Divider(color: AppColors.textColor61),

                          SizedBox(height: 25.h),

                          Obx(() {
                            double amount =
                                double.tryParse(controller.amountText.value) ??
                                0.0;
                            if (amount == 0.0)
                              amount = 85.98; // Default value if empty
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'You Pay',
                                      style: h2.copyWith(
                                        color: AppColors.textColorHint,
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                    Text(
                                      '\$${((amount * controller.percent.value) / 100).toStringAsFixed(2)}',
                                      style: h1.copyWith(
                                        color: AppColors.textColor61,
                                        fontSize: 19.2.sp,
                                      ),
                                    ),
                                  ],
                                ),

                                Column(
                                  children: [
                                    Text(
                                      'Michael',
                                      style: h2.copyWith(
                                        color: AppColors.textColorHint,
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                    Text(
                                      '\$${(amount - ((amount * controller.percent.value) / 100)).toStringAsFixed(2)}',
                                      style: h1.copyWith(
                                        color: AppColors.textColor61,
                                        fontSize: 19.2.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 18.h),

                  CustomTextField(
                    hintText: 'Add expense description...',
                    fillColor: AppColors.textInputFillColor,
                    maxLines: 3,
                    controller: controller.descriptionController,
                  ),

                  SizedBox(height: 46.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 36.0.w),
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomPBButton(
                            text: 'Cancel',
                            color1: AppColors.clrTransparent,
                            color2: AppColors.clrTransparent,
                            txtClr: AppColors.lightPurplePink2,
                            borderColor: AppColors.btnBorder,
                            onPressed: () => Get.back(),
                          ),

                          CustomPBButton(
                            text: controller.isLoading.value
                                ? 'Adding...'
                                : 'Add Expense',
                            onPressed: controller.isLoading.value
                                ? () {}
                                : () => controller.createExpense(),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 180.h),
                ],
              ),
            ),
          ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CircularMenuWidget(homeScreenIndex: 9),
    );
  }
}
