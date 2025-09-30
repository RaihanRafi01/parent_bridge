import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:parent_bridge/common/widgets/customButton.dart';
import 'package:parent_bridge/common/widgets/customDropdown.dart';
import 'package:parent_bridge/common/widgets/customTextField.dart';
import '../../../../common/appColors.dart';
import '../../../../common/customFont.dart';
import '../controllers/calendar_controller.dart';

class AddEventView extends GetView<CalendarController> {
  const AddEventView({super.key});

  @override
  Widget build(BuildContext context) {
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
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(40.r)),
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
                    CustomTextField(
                      hintText: 'Enter event title',
                      controller: controller.eventName,
                      fillColor: AppColors.textInputFillColor,
                    ),
                    CustomDropdown(
                      labelText: 'Event Type',
                      items: controller.eventItems,
                      value: controller.selectedEventType,
                      onChanged: (value) {
                        print('Selected: $value');
                      },
                      fillColor: AppColors.textInputFillColor,
                    ),
                    CustomTextField(
                      hintText: 'mm/dd/yyyy',
                      controller: controller.eventDate,
                      fillColor: AppColors.textInputFillColor,
                      suffixIcon: 'assets/images/calendar/calender_icon.svg',
                      isDatePicker: true,
                    ),
                    Row(
                      children: [
                        Obx(() => Transform.scale(
                          scale: 0.7,
                          child: Switch(
                            value: controller.allDayEvent.value,
                            onChanged: (value) => controller.toggleAllDayEvent(),
                            activeColor: AppColors.clrWhite,
                            activeTrackColor: AppColors.appColor,
                            inactiveTrackColor: AppColors.appColor.withOpacity(.5),
                            inactiveThumbColor: AppColors.clrWhite,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        )),
                        Text(
                          'All day event',
                          style: h4.copyWith(
                            color: AppColors.clrPurple,
                            fontSize: 15.57.sp,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            hintText: 'Start time',
                            controller: controller.eventSTime,
                            fillColor: AppColors.textInputFillColor,
                            suffixIcon: 'assets/images/calendar/time_icon.svg',
                            isTimePicker: true,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: CustomTextField(
                            hintText: 'End time',
                            controller: controller.eventETime,
                            fillColor: AppColors.textInputFillColor,
                            suffixIcon: 'assets/images/calendar/time_icon.svg',
                            isTimePicker: true,
                          ),
                        ),
                      ],
                    ),
                    CustomTextField(
                      hintText: 'Enter location',
                      controller: controller.eventLocation,
                      fillColor: AppColors.textInputFillColor,
                      suffixIcon: 'assets/images/calendar/location_icon.svg',
                    ),
                    CustomDropdown(
                      labelText: 'Enter Repeat',
                      items: controller.repeatItems,
                      value: controller.selectedRepeatType,
                      onChanged: (value) {
                        print('Selected: $value');
                      },
                      fillColor: AppColors.textInputFillColor,
                    ),

                    CustomTextField(
                      hintText: 'Enter reminder time',
                      controller: controller.eventReminderTime,
                      fillColor: AppColors.textInputFillColor,
                      isNumberField: true,
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
                              onPressed: () {  },
                            ),
                          ),
                          SizedBox(width: 26.w),
                          Expanded(child: CustomPBButton(text: 'Add event', onPressed: (){}))
                        ],
                      ),
                    )
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
            onTap: Get.back,
            child: SvgPicture.asset('assets/images/common/back_icon.svg'),
          ),
          SizedBox(width: 15.w),
          Text(
            'Add New Event',
            style: h2.copyWith(fontSize: 24.74.sp, color: AppColors.darkSlateBlue),
          ),
        ],
      ),
    );
  }
}