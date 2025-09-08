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
          CustomPBButton(text: 'Add Event',onPressed: (){},),
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
    final date = dayData['date'] as DateTime;

    if (day == null || !isCurrentMonth) {
      return Container(); // Skip rendering for non-current month days
    }

    return GestureDetector(
      onTap: () {
        controller.selectDate(date);
        // Show event details popup if there are events
        if (events.isNotEmpty) {
          _showEventDetailsDialog(date, events);
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 12).r,
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

  void _showEventDetailsDialog(DateTime selectedDate, List<Map<String, dynamic>> events) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        backgroundColor: Colors.transparent,
        child: Container(
          width: 387.w,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with date and close button
              Container(

                decoration: BoxDecoration(
                  color: AppColors.lightPurplePink2,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(29.r),
                    topRight: Radius.circular(29.r),
                  ),
                ),
                padding: EdgeInsets.all(16.w),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getFormattedDate(selectedDate),
                            style: h2.copyWith(
                              fontSize: 18.43.sp,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${events.length} Event${events.length != 1 ? 's' : ''} Scheduled',
                            style: h2.copyWith(
                              fontSize: 11.64.sp,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close,
                          color: AppColors.gray,
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Events list
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return _buildEventItem(event, index == events.length - 1);
                  },
                ),
              ),

              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  Widget _buildEventItem(Map<String, dynamic> event, bool isLast) {
    // Get event type color
    Color eventColor = _getEventTypeColor(event['type'] ?? 'personal');

    return Container(
      margin: EdgeInsets.only(
        top: 12.h,
        bottom: isLast ? 12.h : 0,
      ),
      decoration: BoxDecoration(
        color: eventColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 8.w,
              // Removed height: double.infinity, using stretch alignment instead
              decoration: BoxDecoration(
                color: eventColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  bottomLeft: Radius.circular(10.r),
                ),
              ),
            ),
            SizedBox(width: 10),
            // Time section on the left
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30).r,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x40B1B1B1), // #B1B1B1 with 25% opacity
                      offset: Offset(0, 3.88), // x: 0, y: 3.88
                      blurRadius: 3.88, // Blur radius
                      spreadRadius: 0, // No spread
                    ),
                  ],
                ),
                width: 43.65.w,
                height: 75.65.h,
                padding: EdgeInsets.all(5).r,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      event['startTime'] ?? '4:00 PM',
                      style: h0.copyWith(
                        fontSize: 8.sp,
                        color: eventColor,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'To',
                      style: h0.copyWith(
                        fontSize: 8.sp,
                        color: eventColor,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      event['endTime'] ?? '5:30 PM',
                      style: h0.copyWith(
                        fontSize: 8.sp,
                        color: eventColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(width: 16.w),

            // Event details section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and type badge row
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              event['title'] ?? 'Untitled Event',
                              style: h2.copyWith(
                                fontSize: 16.62.sp,
                                color: AppColors.darkSlateBlue,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                            decoration: BoxDecoration(
                              color: eventColor,
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Text(
                              _getEventTypeLabel(event['type'] ?? 'personal'),
                              style: h3.copyWith(
                                fontSize: 10.54.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 8.h),

                    // Location
                      Row(
                        children: [
                          SvgPicture.asset('assets/images/calendar/location_icon.svg'),
                          SizedBox(width: 6.w),
                          Text(
                            event['location'] ?? 'Community Park',
                            style: h4.copyWith(
                              fontSize: 11.08.sp,
                              color: AppColors.darkSlateBlue,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),


                    // Organizer/Person
                      Row(
                        children: [
                          SvgPicture.asset('assets/images/calendar/child_icon.svg'),
                          SizedBox(width: 6.w),
                          Text(
                            event['organizer'] ?? 'Max Smith',
                            style: h4.copyWith(
                              fontSize: 11.08.sp,
                              color: Colors.green,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),

                    // Attendee (You)
                    Row(
                      children: [
                        SvgPicture.asset('assets/images/calendar/person_icon.svg'),
                        SizedBox(width: 6.w),
                        Text(
                          'You',
                          style: h4.copyWith(
                            fontSize: 11.08.sp,
                            color: AppColors.darkSlateBlue,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 8.h),

                    // Frequency
                    Text(
                      event['frequency'] ?? 'Weekly',
                      style: h4.copyWith(
                        fontSize: 11.08.sp,
                        color: AppColors.darkSlateBlue,
                      ),
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

// Helper method to get formatted date string
  String _getFormattedDate(DateTime date) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    const weekdays = [
      'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
    ];

    return '${weekdays[date.weekday - 1]}, ${months[date.month - 1]} ${date.day}';
  }

// Helper method to get event type color
  Color _getEventTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'work':
        return const Color(0xFF4CAF50); // Green
      case 'personal':
        return const Color(0xFF2196F3); // Blue
      case 'family':
        return const Color(0xFFFF9800); // Orange
      case 'holiday':
        return const Color(0xFFE91E63); // Pink
      case 'school':
        return const Color(0xFF4CAF50); // Green
      default:
        return const Color(0xFF9C27B0); // Purple
    }
  }

// Helper method to get event type label
  String _getEventTypeLabel(String type) {
    switch (type.toLowerCase()) {
      case 'work':
        return 'Work';
      case 'personal':
        return 'Activity';
      case 'family':
        return 'Family';
      case 'holiday':
        return 'Holiday';
      case 'school':
        return 'School';
      default:
        return 'Event';
    }
  }

// Method to show event options (edit, delete, etc.)
  void _showEventOptions(Map<String, dynamic> event) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(top: 8.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),

            SizedBox(height: 20.h),

            ListTile(
              leading: Icon(Icons.edit, color: AppColors.darkSlateBlue),
              title: Text('Edit Event'),
              onTap: () {
                Get.back();
                _showEditEventDialog(event);
              },
            ),

            ListTile(
              leading: Icon(Icons.delete, color: Colors.red),
              title: Text('Delete Event'),
              onTap: () {
                Get.back();
                _showDeleteConfirmation(event);
              },
            ),

            ListTile(
              leading: Icon(Icons.share, color: AppColors.darkSlateBlue),
              title: Text('Share Event'),
              onTap: () {
                Get.back();
                // Implement share functionality
                Get.snackbar('Info', 'Share functionality coming soon!');
              },
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }

// Method to show edit event dialog
  void _showEditEventDialog(Map<String, dynamic> event) {
    // Implementation for editing events - similar to _showAddEventDialog
    // but pre-filled with existing event data
    Get.snackbar('Info', 'Edit event functionality - implement based on your needs');
  }

// Method to show delete confirmation
  void _showDeleteConfirmation(Map<String, dynamic> event) {
    Get.dialog(
      AlertDialog(
        title: Text('Delete Event'),
        content: Text('Are you sure you want to delete "${event['title']}"?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Delete event using title and date
              controller.deleteEvent(
                event['title'],
                eventDate: event['date'] as DateTime?,
              );
              Get.back(); // Close delete confirmation
              Get.back(); // Close event details dialog
              Get.snackbar('Success', 'Event deleted successfully');
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
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