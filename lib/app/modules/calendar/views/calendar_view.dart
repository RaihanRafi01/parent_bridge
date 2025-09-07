import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/appColors.dart';
import '../controllers/calendar_controller.dart';

class CalendarView extends GetView<CalendarController> {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E4F3),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildTabBar(),
            Expanded(
              child: _buildCalendarContent(),
            ),
            _buildAddEventButton(),
          ],
        ),
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
            child: Icon(
              Icons.arrow_back_ios,
              size: 20.sp,
              color: Colors.black54,
            ),
          ),
          SizedBox(width: 15.w),
          Text(
            'Shared Calendar',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => _showAddEventDialog(),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: const Color(0xFF7B68EE),
                borderRadius: BorderRadius.circular(15.r),
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
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: const Color(0xFFB8D4E3),
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Obx(() => Row(
        children: [
          _buildTabItem('Month', controller.selectedView.value == 'Month'),
          _buildTabItem('Week', controller.selectedView.value == 'Week'),
          _buildTabItem('Day', controller.selectedView.value == 'Day'),
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
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.black87 : Colors.black54,
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
            color: Colors.black54,
          ),
        ),
        Column(
          children: [
            Text(
              controller.getMonthYearString(),
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            Text(
              '${controller.selectedView.value} View',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.black54,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () => controller.nextMonth(),
          child: Icon(
            Icons.chevron_right,
            size: 24.sp,
            color: Colors.black54,
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
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
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
          childAspectRatio: 1.0,
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

    if (day == null) {
      return Container(); // Empty cell for padding
    }

    return GestureDetector(
      onTap: () => controller.selectDate(dayData['date']),
      child: Container(
        margin: EdgeInsets.all(4.w), // Margin for space between cells
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: _getCellBorder(events, isSelected),
        ),
        clipBehavior: Clip.none, // Prevent clipping of overflowed content
        child: Stack(
          clipBehavior: Clip.none, // Ensure Stack doesn't clip the pin
          children: [
            Center(
              child: Text(
                day.toString(),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: _getTextColor(isCurrentMonth, isToday, isSelected),
                ),
              ),
            ),
            if (events.isNotEmpty)
              Positioned(
                top: -10.h, // Positioned above the cell, slightly outside
                right: -5.w, // Centered horizontally for better visibility
                child: SvgPicture.asset(
                  'assets/images/calendar/pin_icon.svg',
                  fit: BoxFit.contain, // Ensure SVG scales properly
                ),
              ),
            if (events.length > 1)
              Positioned(
                bottom: 4.h,
                right: 4.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    '+${events.length - 1}',
                    style: TextStyle(
                      fontSize: 8.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _getCellColor(bool isCurrentMonth, bool isToday, bool isSelected) {
    if (isSelected) return const Color(0xFF7B68EE).withOpacity(0.3);
    if (isToday) return const Color(0xFF7B68EE).withOpacity(0.1);
    if (!isCurrentMonth) return Colors.grey.withOpacity(0.1);
    return Colors.white;
  }

  Border? _getCellBorder(List events, bool isSelected) {
    if (isSelected) return Border.all(color: const Color(0xFF7B68EE), width: 2);
    if (events.isNotEmpty) {
      return Border.all(color: _getEventColor(events.first['type']), width: 1);
    }
    return null;
  }

  Color _getTextColor(bool isCurrentMonth, bool isToday, bool isSelected) {
    if (isSelected || isToday) return const Color(0xFF7B68EE);
    if (!isCurrentMonth) return Colors.grey;
    return Colors.black87;
  }

  Color _getEventColor(String eventType) {
    switch (eventType) {
      case 'personal':
        return Colors.orange;
      case 'work':
        return Colors.red;
      case 'family':
        return Colors.blue;
      case 'holiday':
        return Colors.green;
      default:
        return Colors.grey;
    }
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

