import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:parent_bridge/app/modules/expense_tracker/views/empty_expense_tracker_view.dart';
import 'package:parent_bridge/app/modules/expense_tracker/views/non_empty_expense_tracker_view.dart';
import 'package:parent_bridge/common/appColors.dart';
import 'package:parent_bridge/common/customFont.dart';
import 'package:parent_bridge/common/widgets/customButton.dart';
import 'package:parent_bridge/common/widgets/customTextField.dart';

import '../../../../common/widgets/home/circularfabmenu.dart';
import '../../../../common/widgets/nav/circularMenuWidget.dart';
import '../controllers/expense_tracker_controller.dart';
import 'add_expense_view.dart';

class ExpenseTrackerView extends GetView<ExpenseTrackerController> {
  const ExpenseTrackerView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(27.r),
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
                        GestureDetector(
                          onTap: Get.back,
                          child: SvgPicture.asset('assets/images/common/back_icon.svg'),
                        ),
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
                              ),
                            ],
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 25.w,
                        vertical: 26.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/expense_tracker/expanse_tracker_bg.png',
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
          
                      child: Column(
                        spacing: 16.h,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'July\n2025 Summary',
                                style: h1.copyWith(
                                  color: AppColors.textColor57,
                                  fontSize: 23.43.sp,
                                ),
                              ),
          
                              Container(
                                padding: EdgeInsets.all(8.r),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.containerColor51,
                                ),
          
                                child: SvgPicture.asset(
                                  'assets/images/expense_tracker/calender_icon.svg'
                                ),
                              )
                            ],
                          ),
          
                          MonthlySummaryContainer(
                            bgColors: [AppColors.dividerPurple, AppColors.dividerCyan],
                            info1: 0,
                            info2: 0,
                            infoTexts: ['Total Expenses', 'Pending '],
                            infoColors: [AppColors.textColor58, AppColors.textColor59],
                          ),
          
                          MonthlySummaryContainer(
                            bgColors: [AppColors.gradientColor51, AppColors.gradientColor52],
                            info1: 20.50,
                            info2: 45,
                            infoTexts: ['Your Share', 'Co-parent'],
                            infoColors: [AppColors.textColor58, AppColors.textColor58],
                          ),
                        ],
                      ),
                    ),
          
                    SizedBox(height: 17.h,),
                  ],
                ),
              ),
          
              SizedBox(height: 32.h,),
          
              CustomTextField(
                hintText: 'Search',
                prefixIcon: 'assets/images/expense_tracker/search.svg',
                width: 394,
                controller: controller.searchController,
              ),
          
              SizedBox(height: 20.h,),
          
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.25.w),
                child: Column(
                  spacing: 53.h,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StatusCategoryDropdown(
                          text: 'All Status',
                          selected: controller.selectedStatus,
                          items: controller.statusItems,
                          width: 186.w,
                        ),
                        StatusCategoryDropdown(
                          text: 'All categories',
                          selected: controller.selectedCategory,
                          items: controller.categoryItems,
                          width: 186.w,
                        ),
                      ],
                    ),
          
                    controller.isExpenseEmpty.value ?
                    EmptyExpenseTrackerView(
                      isExpenseEmpty: controller.isExpenseEmpty,
                    )
                        :
                    NonEmptyExpenseTrackerView(
                      amountController: controller.amountController,
                      paymentMethodController: controller.paymentMethodController,
                      selectedPaymentMethod: controller.selectedPaymentMethod2,
                      paymentMethodItems: controller.paymentMethodItems
                    ),
                  ],
                ),
              ),

              SizedBox(height: 179.h,),
            ],
          ),
        ),
      ),


      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CircularMenuWidget(),
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

class MonthlySummaryContainer extends StatelessWidget {
  final List<Color> bgColors;
  final double info1;
  final double info2;
  final List<String> infoTexts;
  final List<Color> infoColors;

  const MonthlySummaryContainer({
    required this.bgColors,
    required this.info1,
    required this.info2,
    required this.infoTexts,
    required this.infoColors,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 38.w, vertical: 8.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          gradient: LinearGradient(
            colors: [
              bgColors[0],
              bgColors[1],
            ],
          )
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            spacing: 0.79.h,
            children: [
              Text(
                '\$$info1',
                style: h2.copyWith(
                  color: infoColors[0],
                  fontSize: 27.06.sp,
                ),
              ),

              Text(
                infoTexts[0],
                style: h2.copyWith(
                  color: infoColors[0],
                  fontSize: 11.14.sp,
                ),
              ),
            ],
          ),

          Container(
            height: 70.h,
            decoration: BoxDecoration(
              color: AppColors.clrWhite,
              border: Border.all(color: AppColors.borderColor53,),
            ),
          ),

          Column(
            spacing: 0.79.h,
            children: [
              Text(
                '\$$info2',
                style: h2.copyWith(
                  color: infoColors[1],
                  fontSize: 27.06.sp,
                ),
              ),

              Text(
                infoTexts[1],
                style: h2.copyWith(
                  color: infoColors[1],
                  fontSize: 11.14.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StatusCategoryDropdown extends StatelessWidget {
  final String text;
  final Rx<String?> selected;
  final List<String> items;
  final double? width;

  const StatusCategoryDropdown({
    required this.text,
    required this.selected,
    required this.items,
    this.width,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final value = (items.contains(selected.value)) ? selected.value : null;

      return Container(
        width: width,
        padding: EdgeInsets.symmetric(horizontal: 8.51.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.96.r),
          color: AppColors.clrWhite,
          border: Border.all(
            color: AppColors.borderColor54,
            width: 0.7.r,
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            value: value,
            hint: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: h3.copyWith(
                    color: AppColors.borderColor54,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
            icon: Icon(
              Icons.keyboard_arrow_down_outlined,
              size: 24.r,
              color: AppColors.borderColor54,
            ),
            dropdownColor: AppColors.clrWhite,
            style: h3.copyWith(
              color: AppColors.borderColor54,
              fontSize: 14.sp,
            ),
            items: items
                .map((item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: h3.copyWith(
                  color: AppColors.borderColor54,
                  fontSize: 14.sp,
                ),
              ),
            ))
                .toList(),
            onChanged: (val) => selected.value = val,
          ),
        ),
      );
    });
  }
}
