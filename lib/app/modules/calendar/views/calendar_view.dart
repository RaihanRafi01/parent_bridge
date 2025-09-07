import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parent_bridge/common/widgets/customButton.dart';
import '../../../../common/appColors.dart';
import '../../../../common/customFont.dart';
import '../controllers/calendar_controller.dart';

class CalendarView extends GetView<CalendarController> {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E4F3),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 30,top: 60).r,
            decoration: BoxDecoration(
              color: AppColors.white, // Fallback color (optional, as gradient overrides it)
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.lightPurplePink2, // Light blue
                  AppColors.customSkyBlue3, // Darker blue
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.r),
                bottomRight: Radius.circular(40.r),
              ),
            ),
            child: Column(
              children: [
                _buildHeader(),
                _buildTabBar(),
              ],
            ),
          ),
          Expanded(
            child: _buildCalendarContent(),
          ),
         //  _buildAddEventButton(),
          CustomPBButton(text: 'Add Event'),
          SizedBox(height: 40.h)
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: SvgPicture.asset('assets/images/common/back_icon.svg'),
          ),
          SizedBox(width: 15.w),
          Text(
            'Shared Calendar',
            style: h2.copyWith(
              fontSize: 24.74.sp,
              color: AppColors.darkSlateBlue,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => _showAddEventDialog(),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColors.lightPurplePink2,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x40000000), // Black with 25% opacity
                    offset: Offset(0, 4), // x: 0, y: 4
                    blurRadius: 4.0, // Blur radius
                    spreadRadius: 0.0, // Spread radius
                  ),
                ],
              ),
              child: Text(
                'Add Event',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        color: AppColors.white, // Fallback color (optional, as gradient overrides it)
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.calenderG1, // Light blue
            AppColors.calenderG2, // Darker blue
          ],
        ),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Obx(() => Row(
        children: [
          _buildTabItem('Month', controller.selectedView.value == 'Month'),
          _buildTabItem('Week', controller.selectedView.value == 'Week'),
          _buildTabItem('Day', controller.selectedView.value == 'Day'),
          // remove that Custody
          _buildTabItem('Custody', controller.selectedView.value == 'Custody'),
          _buildTabItem('Holidays', controller.selectedView.value == 'Holidays'),
        ],
      )),
    );
  }

  Widget _buildTabItem(String text, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeView(text),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Center(
            child: Text(
              text,
              style: h3.copyWith(
                fontSize: 14.sp,
                color: AppColors.textColor7,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarContent() {
    return Container(
      margin: EdgeInsets.all(20.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFFD4E8F0),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Color(0x40B7B1B1), // Grayish color with 25% opacity
            offset: Offset(0, 4), // x: 0, y: 4
            blurRadius: 4.0, // Blur radius
            spreadRadius: 0.0, // Spread radius
          ),
        ],
      ),
      child: Column(
        children: [
          _buildCalendarHeader(),
          SizedBox(height: 20.h),
          _buildWeekDays(),
          SizedBox(height: 10.h),
          Expanded(child: _buildCalendarGrid()),
        ],
      ),
    );
  }

  Widget _buildCalendarHeader() {
    return Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => controller.previousMonth(),
          child: Icon(
            Icons.chevron_left,
            size: 24.sp,
            color: AppColors.darkSlateBlue,
          ),
        ),
        Column(
          children: [
            Text(
              controller.getMonthYearString(),
              style: h4.copyWith(
                fontSize: 22.sp,
                color: AppColors.darkSlateBlue,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              '${controller.selectedView.value} View',
              style: h4.copyWith(
                fontSize: 11.sp,
                color: AppColors.textColor21,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () => controller.nextMonth(),
          child: Icon(
            Icons.chevron_right,
            size: 24.sp,
            color: AppColors.darkSlateBlue,
          ),
        ),
      ],
    ));
  }

  Widget _buildWeekDays() {
    const weekDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return Row(
      children: weekDays.map((day) {
        return Expanded(
          child: Center(
            child: Text(
              day,
              style: h2.copyWith(
                fontSize: 13.71.sp,
                color: AppColors.darkSlateBlue
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCalendarGrid() {
    return Obx(() {
      final days = controller.getDaysInMonth();
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          childAspectRatio: 0.5, // Adjusted to make cells taller
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        itemCount: days.length,
        itemBuilder: (context, index) {
          final day = days[index];
          return _buildDayCell(day);
        },
      );
    });
  }

  Widget _buildDayCell(Map<String, dynamic> dayData) {
    final day = dayData['day'] as int?;
    final isCurrentMonth = dayData['isCurrentMonth'] as bool;
    final isToday = dayData['isToday'] as bool;
    final isSelected = dayData['isSelected'] as bool;
    final events = dayData['events'] as List<Map<String, dynamic>>;

    if (day == null || !isCurrentMonth) {
      return Container(); // Skip rendering for non-current month days
    }

    return GestureDetector(
      onTap: () => controller.selectDate(dayData['date']),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4,vertical: 12).r,
        //padding: EdgeInsets.only(top: 5.h, bottom: 6.h, left: 6.w, right: 6.w),
        decoration: BoxDecoration(
          color: _getCellColor(isCurrentMonth, isToday, isSelected),
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: Color(0x40000000), // Black with 25% opacity
              offset: Offset(0, 4), // x: 0, y: 4
              blurRadius: 4.0, // Blur radius
              spreadRadius: 0.0, // Spread radius
            ),
          ],
        ),
        clipBehavior: Clip.none,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    day.toString(),
                    textAlign: TextAlign.center,
                    style: h4.copyWith(
                      fontSize: 18.29.sp,
                      color: AppColors.darkSlateBlue,
                    ),
                  ),
                  if (events.isNotEmpty) ...[
                    SizedBox(height: 4.h),
                    Container(
                      padding: EdgeInsets.all(3).r,
                      decoration: BoxDecoration(
                        color: AppColors.clrSky6,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                      child: Text(
                        '${events.length}\n${events.length == 1 ? 'event' : 'events'}',
                        textAlign: TextAlign.center,
                        style: h4.copyWith(
                          fontSize: 8.sp,
                          color: AppColors.darkSlateBlue,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (events.isNotEmpty)
              Positioned(
                top: -5.h,
                right: -5.w,
                child: SvgPicture.asset(
                  'assets/images/calendar/pin_icon.svg',
                  fit: BoxFit.contain,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _getCellColor(bool isCurrentMonth, bool isToday, bool isSelected) {
    if (isSelected) return const Color(0xFF7B68EE).withOpacity(0.4);
    if (isToday) return const Color(0xFF7B68EE).withOpacity(0.2);
    return Colors.white;
  }



  Widget _buildAddEventButton() {
    return Container(
      margin: EdgeInsets.all(20.w),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _showAddEventDialog(),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF9B7EDE),
          padding: EdgeInsets.symmetric(vertical: 15.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.r),
          ),
          elevation: 0,
        ),
        child: Text(
          'Add Event',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _showAddEventDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    String selectedEventType = 'personal';

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        child: Container(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add New Event',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.h),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Event Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15.h),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              SizedBox(height: 15.h),
              StatefulBuilder(
                builder: (context, setState) => DropdownButtonFormField<String>(
                  value: selectedEventType,
                  decoration: const InputDecoration(
                    labelText: 'Event Type',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'personal', child: Text('Personal')),
                    DropdownMenuItem(value: 'work', child: Text('Work')),
                    DropdownMenuItem(value: 'family', child: Text('Family')),
                    DropdownMenuItem(value: 'holiday', child: Text('Holiday')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedEventType = value!;
                    });
                  },
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (titleController.text.isNotEmpty) {
                        controller.addEvent(
                          title: titleController.text,
                          description: descriptionController.text,
                          type: selectedEventType,
                        );
                        Get.back();
                        Get.snackbar(
                          'Success',
                          'Event added successfully!',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7B68EE),
                    ),
                    child: const Text('Add Event', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}