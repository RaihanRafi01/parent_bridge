import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:parent_bridge/app/modules/calendar/views/add_event_view.dart';
import 'package:parent_bridge/common/widgets/customButton.dart';
import '../../../../common/appColors.dart';
import '../../../../common/customFont.dart';
import '../controllers/calendar_controller.dart';

class CalendarView extends GetView<CalendarController> {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        // Make the whole screen scrollable
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with gradient
            Container(
              padding: EdgeInsets.only(bottom: 30, top: 60).r,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.lightPurplePink2,
                    AppColors.customSkyBlue3,
                  ],
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(40.r),
                ),
              ),
              child: Column(
                children: [
                  _buildHeader(),
                  SizedBox(height: 20.h),
                  _buildTabBar(),
                ],
              ),
            ),
            // Calendar content
            _buildCalendarContent(),
            // Dynamic events section
            _buildEventsSection(),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: Get.back,
            child: SvgPicture.asset(
              'assets/images/common/back_icon.svg',
              width: 24.w,
              height: 24.h,
            ),
          ),
          SizedBox(width: 15.w),
          Text(
            'Shared Calendar',
            style: h2.copyWith(
              fontSize: 24.74.sp,
              color: AppColors.darkSlateBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () => Get.to(() => AddEventView()),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColors.lightPurplePink2,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x40000000),
                    offset: Offset(0, 4),
                    blurRadius: 4,
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
        gradient: LinearGradient(
          colors: [AppColors.calenderG1, AppColors.calenderG2],
        ),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Obx(
            () => Row(
          children: ['Month', 'Week', 'Day', 'Holidays']
              .map(
                (text) =>
                _buildTabItem(text, controller.selectedView.value == text),
          )
              .toList(),
        ),
      ),
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
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
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
        color: Color(0xFFD4E8F0),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Color(0x40B7B1B1),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Obx(() {
        if (controller.selectedView.value == 'Day') {
          // Day view: Show only the header and rely on _buildEventsSection for events
          return Column(
            children: [
              _buildCalendarHeader(),
            ],
          );
        } else {
          // Month or Week view: Show header, weekdays, and grid
          return Column(
            children: [
              _buildCalendarHeader(),
              SizedBox(height: 20.h),
              if (controller.selectedView.value != 'Holidays') ...[
                _buildWeekDays(),
                _buildCalendarGrid(),
              ],
            ],
          );
        }
      }),
    );
  }

  Widget _buildCalendarHeader() {
    return Obx(
          () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              if (controller.selectedView.value == 'Week') {
                controller.previousWeek();
              } else if (controller.selectedView.value == 'Day') {
                controller.previousDay();
              } else {
                controller.previousMonth();
              }
            },
            child: Icon(
              Icons.chevron_left,
              size: 24.sp,
              color: AppColors.darkSlateBlue,
            ),
          ),
          Column(
            children: [
              Text(
                controller.getViewHeaderString(),
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
            onTap: () {
              if (controller.selectedView.value == 'Week') {
                controller.nextWeek();
              } else if (controller.selectedView.value == 'Day') {
                controller.nextDay();
              } else {
                controller.nextMonth();
              }
            },
            child: Icon(
              Icons.chevron_right,
              size: 24.sp,
              color: AppColors.darkSlateBlue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekDays() {
    const weekDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return Row(
      children: weekDays
          .map(
            (day) => Expanded(
          child: Center(
            child: Text(
              day,
              style: h2.copyWith(
                fontSize: 13.71.sp,
                color: AppColors.darkSlateBlue,
              ),
            ),
          ),
        ),
      )
          .toList(),
    );
  }

  Widget _buildCalendarGrid() {
    return Obx(() {
      final days = controller.selectedView.value == 'Week'
          ? controller.getDaysInWeek()
          : controller.getDaysInMonth();
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          childAspectRatio: 0.5,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        itemCount: days.length,
        itemBuilder: (context, index) => _buildDayCell(days[index]),
        shrinkWrap: true,
        // Ensures the grid is properly sized
        physics:
        NeverScrollableScrollPhysics(), // Disable scrolling of the grid
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

    if (day == null ||
        (!isCurrentMonth && controller.selectedView.value != 'Week'))
      return Container();

    return GestureDetector(
      onTap: () {
        controller.selectDate(date);
        if (events.isNotEmpty) _showEventDialog(date, events);
      },
      child: Container(
        margin: EdgeInsets.all(2.r),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.calenderSelect.withOpacity(0.4)
              : isToday
              ? AppColors.calenderSelect.withOpacity(0.2)
              : Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: Color(0x40000000),
              offset: Offset(0, 2),
              blurRadius: 2,
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    day.toString(),
                    style: h4.copyWith(
                      fontSize: 18.29.sp,
                      color: AppColors.darkSlateBlue,
                    ),
                  ),
                  if (events.isNotEmpty) ...[
                    SizedBox(height: 4.h),
                    Container(
                      padding: EdgeInsets.all(3.r),
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

  Widget _buildEventsSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            String title;
            String viewName;
            List<Map<String, dynamic>> eventsList = [];
            switch (controller.selectedView.value) {
              case 'Month':
                title = 'This Month\'s Events';
                viewName = 'month';
                eventsList = controller.getMonthEvents();
                break;
              case 'Week':
                title = 'This Week\'s Events';
                viewName = 'week';
                eventsList = controller.getWeeklyEvents();
                break;
              case 'Day':
                title = controller.selectedDate.value != null
                    ? 'Events for ${controller.getFormattedDate(controller.selectedDate.value!)} '
                    : 'Select a Day';
                viewName = 'day';
                eventsList = controller.getDayEvents();
                break;
              case 'Holidays':
                title = 'Holidays';
                viewName = 'period';
                eventsList = []; // TODO: Implement holidays
                break;
              default:
                return SizedBox();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: h2.copyWith(
                    color: AppColors.darkSlateBlue,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (eventsList.isEmpty)
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.event_note,
                            size: 48.sp,
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'No events this ${viewName == "period" ? "period" : viewName}',
                            style: h3.copyWith(
                              color: Colors.grey[600],
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Tap "Add Event" to create your first event',
                            style: h4.copyWith(
                              color: Colors.grey[500],
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  _buildEventsList(eventsList),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: CustomPBButton(
                    text: 'Add Event',
                    onPressed: () => Get.to(() => AddEventView()),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildEventsList(List<Map<String, dynamic>> dayEvents) {
    return ListView.builder(
      shrinkWrap: true,
      // Ensures ListView takes only the space it needs
      physics: const NeverScrollableScrollPhysics(),
      // Disables ListView's own scrolling
      itemCount: dayEvents.length,
      itemBuilder: (context, index) {
        final dayEventsData = dayEvents[index];
        final date = dayEventsData['date'] as DateTime;
        final events = dayEventsData['events'] as List<Map<String, dynamic>>;
        return Padding(
          padding: const EdgeInsets.only(bottom: 30).r,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(9.31.r),
              boxShadow: [
                BoxShadow(
                  color: Color(0x40DFD4D4),
                  offset: Offset(1, 1),
                  blurRadius: 4,
                  spreadRadius: 0,
                ),
              ],
              border: Border.all(color: Color(0xFFF2F2F2), width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16).r,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.customblueclr2,
                        borderRadius: BorderRadius.circular(9.31.r),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x40B7B1B1),
                            // #B7B1B1 with 40% opacity
                            offset: Offset(0, 3.72),
                            // x: 0px, y: 3.72px
                            blurRadius: 3.72,
                            // blur: 3.72px
                            spreadRadius: 0, // spread: 0px
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 60.w,
                            height: 60.h,
                            decoration: BoxDecoration(
                              color: AppColors.lightPurplePink2,
                              borderRadius: BorderRadius.circular(9.31.r),
                            ),
                            child: Center(
                              child: Text(
                                date.day.toString(),
                                style: h3.copyWith(
                                  color: _isToday(date)
                                      ? Colors.white
                                      : AppColors.darkSlateBlue,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat('EEEE').format(date),
                                style: h2.copyWith(
                                  color: AppColors.darkSlateBlue,
                                  fontSize: 18.62.sp,
                                ),
                              ),
                              Text(
                                DateFormat('MMMM').format(date),
                                style: h4.copyWith(
                                  color: AppColors.darkSlateBlue,
                                  fontSize: 11.17.sp,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ).r,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.customSkyBlue3,
                                borderRadius: BorderRadius.circular(50.r),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '${events.length} ${events.length == 1 ? 'event' : 'events'}',
                                    style: h3.copyWith(
                                      fontSize: 14.59.sp,
                                      color: AppColors.darkSlateBlue,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ...events
                      .asMap()
                      .entries
                      .map(
                        (entry) => _buildEventItem(
                      entry.value,
                      entry.key == events.length - 1,
                    ),
                  )
                      .toList(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showEventDialog(
      DateTime selectedDate,
      List<Map<String, dynamic>> events,
      ) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
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
              Container(
                decoration: BoxDecoration(
                  color: AppColors.lightPurplePink2,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(29.r),
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
                      onTap: Get.back,
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
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: events.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Get.back();
                      _showEventDetailsDialog(events[index]);
                    },
                    child: _buildEventItem(
                      events[index],
                      index == events.length - 1,
                    ),
                  ),
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

  void _showEventDetailsDialog(Map<String, dynamic> event) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
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
              Container(
                decoration: BoxDecoration(
                  color: AppColors.lightPurplePink2,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(29.r),
                  ),
                ),
                padding: EdgeInsets.all(16.w),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        event['title'],
                        style: h2.copyWith(
                          fontSize: 18.43.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: Get.back,
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
              Container(
                margin: EdgeInsets.all(16.r),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/calendar/calender_icon.svg',
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          DateFormat('yyyy-MM-dd').format(event['date']),
                          style: h4.copyWith(
                            fontSize: 16.62.sp,
                            color: AppColors.darkSlateBlue,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: _getEventTypeColor(
                              event['type'] ?? 'personal',
                            ),
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
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.r),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/calendar/time_icon.svg',
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            event['time'],
                            style: h4.copyWith(
                              fontSize: 16.62.sp,
                              color: AppColors.darkSlateBlue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.r),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/calendar/location_icon.svg',
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            event['location'] ?? 'Not specified',
                            style: h4.copyWith(
                              fontSize: 16.62.sp,
                              color: AppColors.darkSlateBlue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.r),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/calendar/person_icon.svg',
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'You',
                            style: h4.copyWith(
                              fontSize: 16.62.sp,
                              color: AppColors.darkSlateBlue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.r),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/calendar/child_icon.svg',
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            event['organizer'] ?? 'Not specified',
                            style: h4.copyWith(
                              fontSize: 16.62.sp,
                              color: AppColors.clrGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.clrGreen2,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      padding: EdgeInsets.all(16.r),
                      child: Text(
                        event['description'] ?? 'No description provided',
                        style: h4.copyWith(
                          fontSize: 14.sp,
                          color: AppColors.darkSlateBlue,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.r),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              controller.eventName.text = event['title'];
                              controller.eventType.text = event['type'];
                              controller.eventDate.text = DateFormat(
                                'yyyy-MM-dd',
                              ).format(event['date']);
                              controller.eventSTime.text = event['time'];
                              controller.eventDescription.text =
                                  event['description'] ?? '';
                              controller.eventLocation.text =
                                  event['location'] ?? '';
                              controller.selectedRepeatType.value =
                              event['frequency'];
                              Get.to(() => AddEventView())?.then((_) {
                                controller.updateEvent(event['title'], {
                                  'title': controller.eventName.text,
                                  'type': controller.eventType.text,
                                  'date': DateTime.parse(
                                    controller.eventDate.text,
                                  ),
                                  'time': controller.eventSTime.text,
                                  'description':
                                  controller.eventDescription.text,
                                  'location': controller.eventLocation.text,
                                  'frequency':
                                  controller.selectedRepeatType.value ??
                                      'Once',
                                });
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: AppColors.darkSlateBlue),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(21.r),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/calendar/edit_icon.svg',
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  'Edit',
                                  style: h4.copyWith(
                                    fontSize: 18.43.sp,
                                    color: AppColors.darkSlateBlue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              controller.deleteEvent(
                                event['title'],
                                eventDate: event['date'],
                              );
                              Get.back();
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: AppColors.clrRed),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(21.r),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/calendar/delete_icon.svg',
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  'Delete',
                                  style: h4.copyWith(
                                    fontSize: 18.43.sp,
                                    color: AppColors.clrRed,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  Widget _buildEventItem(Map<String, dynamic> event, bool isLast) {
    // Updated to use dynamic event data
    Color eventColor = _getEventTypeColor(event['type'] ?? 'personal');
    return Container(
      margin: EdgeInsets.only(top: 12.h),
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
              decoration: BoxDecoration(
                color: eventColor,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(10.r),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30).r,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x40B1B1B1),
                      offset: Offset(0, 3.88),
                      blurRadius: 3.88,
                    ),
                  ],
                ),
                //width: 53.65.w,
                padding: EdgeInsets.all(5).r,
                child: Padding(
                  padding: const EdgeInsets.all(4).r,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        event['time'],
                        style: h0.copyWith(fontSize: 8.sp, color: eventColor),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'To',
                        style: h0.copyWith(fontSize: 8.sp, color: eventColor),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        event['time'],
                        style: h0.copyWith(fontSize: 8.sp, color: eventColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            event['title'],
                            style: h2.copyWith(
                              fontSize: 16.62.sp,
                              color: AppColors.darkSlateBlue,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
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
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/calendar/location_icon.svg',
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          event['location'] ?? 'Not specified',
                          style: h4.copyWith(
                            fontSize: 11.08.sp,
                            color: AppColors.darkSlateBlue,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/calendar/child_icon.svg',
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          event['organizer'] ?? 'Not specified',
                          style: h4.copyWith(
                            fontSize: 11.08.sp,
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/calendar/person_icon.svg',
                        ),
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
                    Text(
                      event['frequency'] ?? 'Once',
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

  String _getFormattedDate(DateTime date) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    const weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return '${weekdays[date.weekday - 1]}, ${months[date.month - 1]} ${date.day}';
  }

  Color _getEventTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'work':
      case 'school':
        return Color(0xFF4CAF50);
      case 'personal':
      case 'activity':
        return Color(0xFF2196F3);
      case 'family':
        return Color(0xFFFF9800);
      case 'holiday':
        return Color(0xFFE91E63);
      case 'custody':
      case 'medical':
        return Color(0xFFF44336);
      default:
        return Color(0xFF9C27B0);
    }
  }

  String _getEventTypeLabel(String type) {
    switch (type.toLowerCase()) {
      case 'work':
        return 'Work';
      case 'personal':
      case 'activity':
        return 'Activity';
      case 'family':
        return 'Family';
      case 'holiday':
        return 'Holiday';
      case 'school':
        return 'School';
      case 'custody':
        return 'Custody';
      case 'medical':
        return 'Medical';
      default:
        return 'Event';
    }
  }

  bool _isToday(DateTime date) {
    final today = DateTime.now();
    return date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;
  }
}