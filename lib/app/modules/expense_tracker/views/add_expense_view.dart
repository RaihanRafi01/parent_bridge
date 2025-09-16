import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:parent_bridge/app/modules/expense_tracker/controllers/add_expense_controller.dart';
import 'package:parent_bridge/app/modules/expense_tracker/views/expense_tracker_view.dart';
import 'package:parent_bridge/common/customFont.dart';
import 'package:parent_bridge/common/widgets/customButton.dart';
import 'package:parent_bridge/common/widgets/customTextField.dart';

import '../../../../common/appColors.dart';
import '../../../../common/widgets/customDropdown.dart';
import '../../../../common/widgets/home/circularfabmenu.dart';

class AddExpenseView extends GetView<AddExpenseController> {
  final RxBool isExpenseEmpty;

  const AddExpenseView({
    required this.isExpenseEmpty,
    super.key
  });
  @override
  Widget build(BuildContext context) {
    Get.put(AddExpenseController());

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20.w, top: 65.h, bottom: 43.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.r),
                    bottomRight: Radius.circular(40.r),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.lightPurplePink2,
                      AppColors.customSkyBlue3,
                    ],
                  )
                ),
          
                child: Row(
                  spacing: 21.5.w,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(
                        Icons.arrow_back_outlined,
                        color: AppColors.clrBlack,
                        size: 37.r,
                      ),
                    ),
          
                    Text(
                      'Add New Expense',
                      style: h2.copyWith(
                        color: AppColors.textColor7,
                        fontSize: 24.47.sp,
                      ),
                    )
                  ],
                ),
              ),
          
              SizedBox(height: 57.h,),

              CustomDropdown(
                labelText: 'Select Child\'s',
                items: controller.childItems,
                value: controller.selectedChild,
                onChanged: (value) {
                  print('Selected: $value');
                },
                fillColor: AppColors.textInputFillColor,
              ),

              SizedBox(height: 18.h,),
          
              CustomTextField(
                hintText: 'Enter Expense Title',
                fillColor: AppColors.textInputFillColor,
                controller: controller.expenseTitleController,
              ),

              SizedBox(height: 18.h,),

              CustomDropdown(
                labelText: 'Payment Method',
                items: controller.paymentMethodItems,
                value: controller.selectedPaymentMethod,
                onChanged: (value) {
                  print('Selected: $value');
                },
                fillColor: AppColors.textInputFillColor,
              ),

              SizedBox(height: 18.h,),
          
              CustomTextField(
                hintText: 'Paid Date',
                suffixIcon: 'assets/images/expense_tracker/calender.svg',
                onSuffixTap: () {  },
                fillColor: AppColors.textInputFillColor,
                controller: controller.expenseTitleController,
              ),

              SizedBox(height: 18.h,),
          
              CustomTextField(
                hintText: 'Due Date',
                suffixIcon: 'assets/images/expense_tracker/calender.svg',
                onSuffixTap: () {  },
                fillColor: AppColors.textInputFillColor,
                controller: controller.expenseTitleController,
              ),

              SizedBox(height: 18.h,),
          
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
          
              SizedBox(height: 18.h,),
          
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
                      )
                    ]
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
                              controller.percent.value!=100 ? '${controller.percent.value.toStringAsFixed(2)}%' : '100%',
                              style: h1.copyWith(
                                color: AppColors.textColor61,
                                fontSize: 25.5.sp,
                              ),
                            );
                          }),
                        ],
                      ),
          
                      SizedBox(height: 12.h,),
          
                      Text(
                        'Your Share:',
                        style: h3.copyWith(
                          color: AppColors.textColorHint,
                          fontSize: 12.sp,
                        ),
                      ),
          
                      SizedBox(height: 15.h,),
          
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => controller.minus(),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 9.r, vertical: 15.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3.r),
                                color: AppColors.textColor61,
                              ),
                              child: SvgPicture.asset(
                                'assets/images/expense_tracker/minus.svg',
                              ),
                            ),
                          ),
          
                          Obx(() => SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              trackHeight: 6,
                              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
                              overlayShape: SliderComponentShape.noOverlay,
                              activeTrackColor: AppColors.textColor61,
                              inactiveTrackColor: AppColors.clrWhite,
                              thumbColor: AppColors.textColor61,
                            ),
                            child: Slider(
                              value: controller.percent.value,
                              min: 0,
                              max: 100,
                              onChanged: (v) => controller.percent.value = v,
                            ),
                          )),
          
                          GestureDetector(
                            onTap: () => controller.plus(),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 9.r, vertical: 10.h),
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

                      SizedBox(height: 25.h,),

                      Divider(color: AppColors.textColor61,),

                      SizedBox(height: 25.h,),

                      Obx(() {
                        double amount = controller.amountController.text != '' ? double.parse(controller.amountController.text) : 85.98;
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
                                  '\$${(amount-((amount * controller.percent.value) / 100)).toStringAsFixed(2)}',
                                  style: h1.copyWith(
                                    color: AppColors.textColor61,
                                    fontSize: 19.2.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      })
                    ],
                  ),
                ),
              ),

              SizedBox(height: 18.h,),

              CustomTextField(
                hintText: 'Add expense description...',
                fillColor: AppColors.textInputFillColor,
                maxLines: 3,
                controller: controller.expenseTitleController,
              ),

              SizedBox(height: 46.h,),
              
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 36.0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomPBButton(
                      text: 'Cancel',
                      color1: AppColors.clrTransparent,
                      color2: AppColors.clrTransparent,
                      txtClr: AppColors.lightPurplePink2,
                      borderColor: AppColors.btnBorder,
                      onPressed: () {  },
                    ),

                    CustomPBButton(
                      text: 'Add Expense',
                      onPressed: () {
                        isExpenseEmpty.value = !isExpenseEmpty.value;
                        Get.to(ExpenseTrackerView());
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 180.h,),
            ],
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(top: 20.0.h, bottom: 20.h),
        child: CircularMenu(
          fabMargin: EdgeInsets.only(top: 1.h),
          ringGradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.customSkyBlue,
              Color(0xFF9AA0FF),
              AppColors.customDeepPurple,
            ],
            stops: [0.0, 0.3, 1.0],
          ),
          alignment: Alignment.bottomCenter,
          ringDiameter: 285.r,
          ringWidth: 90.w,
          fabSize: 70.w,
          fabOpenIcon: Icon(Icons.add, color: AppColors.white, size: 40.sp),
          fabCloseIcon: Icon(Icons.close, color: AppColors.white, size: 35.sp),
          fabOpenGradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.customSkyBlue2,
              Color(0xFF9AA0FF),
              AppColors.customDeepPurple,
            ],
            stops: [0.0, 0.3, 1.0],
          ),
          fabGradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.customSkyBlue2,
              Color(0xFF9AA0FF),
              AppColors.customDeepPurple,
            ],
            stops: [0.0, 0.3, 1.0],
          ),
          fabCloseGradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.customSkyBlue2,
              Color(0xFF9AA0FF),
              AppColors.customDeepPurple,
            ],
            stops: [0.0, 0.3, 1.0],
          ),
          children: <Widget>[
            _buildMenuIcon(
              svg: 'assets/images/home/home.svg',
              onPressed: () {},
              ishome: true,
            ),
            _buildMenuIcon(svg: 'assets/images/home/chaticon.svg', onPressed: () {}),
            _buildMenuIcon(svg: 'assets/images/home/schedule.svg', onPressed: () {}),
            _buildMenuIcon(svg: 'assets/images/home/form.svg', onPressed: () {}),
            _buildMenuIcon(svg: 'assets/images/home/settings.svg', onPressed: () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuIcon({
    bool ishome = false,
    required String svg,
    required VoidCallback onPressed,
  }) {
    return RawMaterialButton(
      onPressed: onPressed,
      shape: const CircleBorder(),
      fillColor: Colors.transparent,
      elevation: 4,
      constraints: BoxConstraints.tightFor(width: 70.w, height: 60.h),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 2.w,
            color: ishome ? AppColors.white : Colors.transparent,
          ),
          gradient: ishome
              ? const LinearGradient(
            colors: [
              Color(0xFFA14CDD),
              Color(0xFF52B6E4),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
              : LinearGradient(
            colors: [
              AppColors.white,
              AppColors.white,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SvgPicture.asset(svg, height: 25.h, width: 25.w),
        ),
      ),
    );
  }
}
