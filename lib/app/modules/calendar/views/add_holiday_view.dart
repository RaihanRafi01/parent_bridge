import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:parent_bridge/common/widgets/custom_button.dart';
import 'package:parent_bridge/common/widgets/custom_dropdown.dart';
import 'package:parent_bridge/common/widgets/custom_text_field.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/custom_font.dart';
import '../controllers/calendar_controller.dart';

class AddHolidayView extends GetView<CalendarController> {
  const AddHolidayView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.bridgeInfo();
    return Scaffold(
      body: Column(
        children: [
          // Fixed Header
          Container(
            padding: EdgeInsets.only(bottom: 30, top: 60).r,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.lightPurplePink2, AppColors.customSkyBlue3],
              ),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(40.r),
              ),
            ),
            child: _buildHeader(),
          ),
          // Scrollable Body Content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24).r,
                child: Column(
                  children: [
                    CustomDropdown(
                      labelText: 'Select child\'s',
                      items: controller.childNames,
                      value: controller.selectedChildName,
                      onChanged: (value) {
                        debugPrint('Selected: $value');
                      },
                      fillColor: AppColors.textInputFillColor,
                    ),
                    CustomDropdown(
                      labelText: 'Select or type holiday name',
                      items: controller.holidayItems,
                      value: controller.holidayValue,
                      onChanged: (value) {
                        debugPrint('Selected: $value');
                      },
                      fillColor: AppColors.textInputFillColor,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            hintText: 'Start Date',
                            controller: controller.eventDate,
                            fillColor: AppColors.textInputFillColor,
                            suffixIcon:
                                'assets/images/calendar/calender_icon.svg',
                            isDatePicker: true,
                          ),
                        ),
                        Expanded(
                          child: CustomTextField(
                            hintText: 'End date',
                            controller: controller.eventEDate,
                            fillColor: AppColors.textInputFillColor,
                            suffixIcon:
                                'assets/images/calendar/calender_icon.svg',
                            isDatePicker: true,
                          ),
                        ),
                      ],
                    ),
                    CustomDropdown(
                      labelText: 'Assigned to',
                      items: controller.assignItems,
                      value: controller.assignValue,
                      onChanged: (value) {
                        debugPrint('Selected: $value');
                      },
                      fillColor: AppColors.textInputFillColor,
                    ),
                    CustomTextField(
                      hintText: 'Enter location',
                      controller: controller.eventLocation,
                      fillColor: AppColors.textInputFillColor,
                      suffixIcon: 'assets/images/calendar/location_icon.svg',
                    ),
                    CustomTextField(
                      hintText: 'Add event description...',
                      controller: controller.eventDescription,
                      fillColor: AppColors.textInputFillColor,
                      maxLines: 4,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 26).r,
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomPBButton(
                              text: 'Cancel',
                              color1: AppColors.clrTransparent,
                              color2: AppColors.clrTransparent,
                              txtClr: AppColors.lightPurplePink2,
                              borderColor: AppColors.btnBorder,
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(width: 26.w),
                          Expanded(
                            child: Obx(
                              () => CustomPBButton(
                                text: controller.updateCheck.value
                                    ? controller.isLoading.value
                                          ? 'Updating ho...'
                                          : 'Update Holid..'
                                    : controller.isLoading.value
                                    ? 'Adding Ho...'
                                    : 'Add Holiday',
                                onPressed: controller.updateCheck.value
                                    ? controller.isLoading.value
                                          ? () {}
                                          : () => controller.updateHoliday(
                                              controller.updateId.value,
                                            )
                                    : controller.isLoading.value
                                    ? () {}
                                    : () => controller.createHoliday(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              controller.childNames.clear();
              controller.clearFormData();
              // controller.eventItems.clear();
              // controller.repeatItems.clear();
              Get.back();
            },
            child: SvgPicture.asset('assets/images/common/back_icon.svg'),
          ),
          SizedBox(width: 15.w),
          Text(
            controller.updateCheck.value ? 'Update Holiday' : 'Add Holiday',
            style: h2.copyWith(
              fontSize: 24.74.sp,
              color: AppColors.darkSlateBlue,
            ),
          ),
        ],
      ),
    );
  }
}
