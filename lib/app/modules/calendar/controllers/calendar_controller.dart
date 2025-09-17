import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CalendarController extends GetxController {
  final eventName = TextEditingController();
  final eventType = TextEditingController();
  final eventDate = TextEditingController();
  final eventSTime = TextEditingController();
  final eventETime = TextEditingController();
  final eventLocation = TextEditingController();
  final eventDescription = TextEditingController();
  final eventReminderTime = TextEditingController();

  final allDayEvent = false.obs;
  final selectedEventType = Rx<String?>(null);
  final selectedRepeatType = Rx<String?>(null);
  final currentDate = DateTime.now().obs;
  final selectedDate = Rx<DateTime?>(null);
  final selectedView = 'Month'.obs;
  final events = <String, List<Map<String, dynamic>>>{}.obs;
  void toggleAllDayEvent() => allDayEvent.value = !allDayEvent.value;

  final eventItems = ['Activity', 'School', 'Custody', 'Medical'];
  final repeatItems = ['Does not repeat', 'Daily', 'Weekly', 'Every 2 weeks', 'Monthly'];

  @override
  void onInit() {
    super.onInit();
    selectedDate.value = DateTime.now();
    _initializeSampleEvents();
  }

  void _initializeSampleEvents() {
    final today = DateTime.now();
    events['${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}'] = [
      {'id': '1', 'title': 'Team Meeting', 'description': 'Weekly team sync', 'type': 'work', 'time': '10:00 AM', 'frequency': 'Weekly', 'location': 'Conference Room A', 'organizer': 'John Doe', 'date': today, 'createdAt': DateTime.now()},
    ];
    final tomorrow = today.add(Duration(days: 1));
    events['${tomorrow.year}-${tomorrow.month.toString().padLeft(2, '0')}-${tomorrow.day.toString().padLeft(2, '0')}'] = [
      {'id': '2', 'title': "Emma's Soccer Practice", 'description': 'Weekly training', 'type': 'school', 'time': '4:00 PM', 'frequency': 'Weekly', 'location': 'Community Sports Center', 'organizer': 'Emma Wilson', 'date': tomorrow, 'createdAt': DateTime.now()},
    ];
    final dayAfter = today.add(Duration(days: 2));
    events['${dayAfter.year}-${dayAfter.month.toString().padLeft(2, '0')}-${dayAfter.day.toString().padLeft(2, '0')}'] = [
      {'id': '3', 'title': 'Parent-Teacher Conference', 'description': 'Meet with Ms. Johnson', 'type': 'school', 'time': '6:30 PM', 'frequency': 'Once', 'location': 'Elementary School', 'organizer': 'Ms. Johnson', 'date': dayAfter, 'createdAt': DateTime.now()},
      {'id': '4', 'title': "Mom's Work Meeting", 'description': 'Project discussion', 'type': 'work', 'time': '2:00 PM', 'frequency': 'Once', 'location': 'Downtown Office', 'organizer': 'Sarah Smith', 'date': dayAfter, 'createdAt': DateTime.now()},
    ];
    final laterDate = today.add(Duration(days: 5));
    events['${laterDate.year}-${laterDate.month.toString().padLeft(2, '0')}-${laterDate.day.toString().padLeft(2, '0')}'] = [
      {'id': '5', 'title': 'Family Dinner', 'description': 'Birthday celebration', 'type': 'family', 'time': '7:00 PM', 'frequency': 'Once', 'location': 'The Italian Place', 'organizer': 'Family', 'date': laterDate, 'createdAt': DateTime.now()},
    ];
  }

  String getMonthYearString() {
    const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    return '${months[currentDate.value.month - 1]} ${currentDate.value.year}';
  }

  String getWeekRangeString() {
    final startOfWeek = currentDate.value.subtract(Duration(days: currentDate.value.weekday % 7));
    final endOfWeek = startOfWeek.add(Duration(days: 6));
    final startFormat = DateFormat('MMM d');
    final endFormat = DateFormat('MMM d, yyyy');
    return startOfWeek.month == endOfWeek.month
        ? '${startFormat.format(startOfWeek)} - ${endOfWeek.day}, ${endOfWeek.year}'
        : '${startFormat.format(startOfWeek)} - ${endFormat.format(endOfWeek)}';
  }

  String getFormattedDate(DateTime date) {
    return DateFormat('EEEE, MMMM d').format(date);
  }

  String getViewHeaderString() {
    switch (selectedView.value) {
      case 'Week':
        return getWeekRangeString();
      case 'Day':
        return selectedDate.value != null ? getFormattedDate(selectedDate.value!) : getMonthYearString();
      default:
        return getMonthYearString();
    }
  }

  void previousMonth() => currentDate.value = DateTime(currentDate.value.year, currentDate.value.month - 1);
  void nextMonth() => currentDate.value = DateTime(currentDate.value.year, currentDate.value.month + 1);
  void previousWeek() => currentDate.value = currentDate.value.subtract(Duration(days: 7));
  void nextWeek() => currentDate.value = currentDate.value.add(Duration(days: 7));

  void changeView(String view) {
    selectedView.value = view;
    if (view == 'Week' && selectedDate.value != null) {
      currentDate.value = selectedDate.value!.subtract(Duration(days: selectedDate.value!.weekday % 7));
    }
    if (view == 'Day' && selectedDate.value != null) {
      currentDate.value = selectedDate.value!;
    }
  }

  void selectDate(DateTime date) {
    selectedDate.value = date;
    if (selectedView.value == 'Week') {
      currentDate.value = date.subtract(Duration(days: date.weekday % 7));
    }
    if (selectedView.value == 'Day') {
      currentDate.value = date;
    }
  }

  void deleteEvent(String eventTitle, {DateTime? eventDate}) {
    final date = eventDate ?? selectedDate.value;
    if (date != null) {
      final dateKey = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      events[dateKey]?.removeWhere((event) => event['title'] == eventTitle);
      if (events[dateKey]?.isEmpty ?? false) events.remove(dateKey);
      events.refresh();
    }
  }

  void updateEvent(String originalTitle, Map<String, dynamic> updatedEvent, {DateTime? eventDate}) {
    final date = eventDate ?? selectedDate.value;
    if (date != null) {
      final dateKey = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      final eventIndex = events[dateKey]?.indexWhere((event) => event['title'] == originalTitle) ?? -1;
      if (eventIndex != -1) {
        events[dateKey]![eventIndex] = {...events[dateKey]![eventIndex], ...updatedEvent};
        events.refresh();
      }
    }
  }

  void addEvent({
    required String title,
    String description = '',
    String type = 'personal',
    String time = '9:00 AM',
    String frequency = 'Once',
    String location = '',
    String organizer = '',
    DateTime? eventDate,
  }) {
    final date = eventDate ?? selectedDate.value;
    if (date != null) {
      final dateKey = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      events[dateKey] ??= [];
      events[dateKey]!.add({
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'title': title,
        'description': description,
        'type': type,
        'time': time,
        'frequency': frequency,
        'location': location,
        'organizer': organizer,
        'date': date,
        'createdAt': DateTime.now(),
      });
      events.refresh();
    }
  }

  List<Map<String, dynamic>> getWeeklyEvents() {
    final startOfWeek = currentDate.value.subtract(Duration(days: currentDate.value.weekday % 7));
    final endOfWeek = startOfWeek.add(Duration(days: 6));
    List<Map<String, dynamic>> weeklyEvents = [];
    for (var date = startOfWeek; date.isBefore(endOfWeek.add(Duration(days: 1))); date = date.add(Duration(days: 1))) {
      final events = _getEventsForDate(date);
      if (events.isNotEmpty) weeklyEvents.add({'date': date, 'events': events});
    }
    return weeklyEvents;
  }

  List<Map<String, dynamic>> getMonthEvents() {
    final firstDay = DateTime(currentDate.value.year, currentDate.value.month, 1);
    final lastDay = DateTime(currentDate.value.year, currentDate.value.month + 1, 0);
    List<Map<String, dynamic>> monthEvents = [];
    for (var date = firstDay; date.isBefore(lastDay.add(Duration(days: 1))); date = date.add(Duration(days: 1))) {
      final events = _getEventsForDate(date);
      if (events.isNotEmpty) monthEvents.add({'date': date, 'events': events});
    }
    return monthEvents;
  }

  List<Map<String, dynamic>> getDayEvents() {
    if (selectedDate.value == null) return [];
    final events = _getEventsForDate(selectedDate.value!);
    if (events.isEmpty) return [];
    return [{'date': selectedDate.value, 'events': events}];
  }

  List<Map<String, dynamic>> getDaysInMonth() {
    final year = currentDate.value.year;
    final month = currentDate.value.month;
    final firstDay = DateTime(year, month, 1);
    final lastDay = DateTime(year, month + 1, 0);
    final firstDayOfWeek = firstDay.weekday % 7;
    List<Map<String, dynamic>> days = [];

    for (int i = 0; i < firstDayOfWeek; i++) {
      final date = firstDay.subtract(Duration(days: firstDayOfWeek - i));
      days.add({'day': date.day, 'date': date, 'isCurrentMonth': false, 'isToday': _isToday(date), 'isSelected': _isSelected(date), 'events': _getEventsForDate(date)});
    }

    for (int day = 1; day <= lastDay.day; day++) {
      final date = DateTime(year, month, day);
      days.add({'day': day, 'date': date, 'isCurrentMonth': true, 'isToday': _isToday(date), 'isSelected': _isSelected(date), 'events': _getEventsForDate(date)});
    }

    final remainingCells = 42 - days.length;
    for (int i = 1; i <= remainingCells; i++) {
      final date = lastDay.add(Duration(days: i));
      days.add({'day': date.day, 'date': date, 'isCurrentMonth': false, 'isToday': _isToday(date), 'isSelected': _isSelected(date), 'events': _getEventsForDate(date)});
    }
    return days;
  }

  List<Map<String, dynamic>> getDaysInWeek() {
    final startOfWeek = currentDate.value.subtract(Duration(days: currentDate.value.weekday % 7));
    List<Map<String, dynamic>> days = [];
    for (int i = 0; i < 7; i++) {
      final date = startOfWeek.add(Duration(days: i));
      days.add({'day': date.day, 'date': date, 'isCurrentMonth': true, 'isToday': _isToday(date), 'isSelected': _isSelected(date), 'events': _getEventsForDate(date)});
    }
    return days;
  }

  bool _isToday(DateTime date) {
    final today = DateTime.now();
    return date.year == today.year && date.month == today.month && date.day == today.day;
  }

  bool _isSelected(DateTime date) => selectedDate.value != null && date.year == selectedDate.value!.year && date.month == selectedDate.value!.month && date.day == selectedDate.value!.day;

  List<Map<String, dynamic>> _getEventsForDate(DateTime date) {
    return events['${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}'] ?? [];
  }

  @override
  void onClose() {
    eventName.dispose();
    eventType.dispose();
    eventDate.dispose();
    eventSTime.dispose();
    eventLocation.dispose();
    eventDescription.dispose();
    super.onClose();
  }
}