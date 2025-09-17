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

  void toggleAllDayEvent() => allDayEvent.value = !allDayEvent.value;

  final Rx<String?> selectedEventType = Rx<String?>(null);
  final List<String> eventItems = ['Activity', 'School', 'Custody', 'Medical'];

  final Rx<String?> selectedRepeatType = Rx<String?>(null);
  final List<String> repeatItems = [
    'Does not repeat',
    'Daily',
    'Weekly',
    'Every 2 weeks',
    'Monthly',
  ];

  final Rx<DateTime> currentDate = DateTime.now().obs;
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final RxString selectedView = 'Month'.obs;
  final RxMap<String, List<Map<String, dynamic>>> events = <String, List<Map<String, dynamic>>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    selectedDate.value = DateTime.now();
    _initializeSampleEvents();
  }

  void _initializeSampleEvents() {
    // Unchanged
    final today = DateTime.now();

    final todayKey = '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';
    events[todayKey] = [
      {
        'id': '1',
        'title': 'Team Meeting',
        'description': 'Weekly team sync meeting',
        'type': 'work',
        'time': '10:00 AM',
        'frequency': 'Weekly',
        'date': today,
        'createdAt': DateTime.now(),
      },
    ];

    final date12 = DateTime(today.year, today.month, 12);
    final dateKey2 = '${today.year}-${today.month.toString().padLeft(2, '0')}-12';
    events[dateKey2] = [
      {
        'id': '2',
        'title': 'Doctor Appointment',
        'description': 'Annual checkup with Dr. Smith',
        'type': 'personal',
        'time': '2:30 PM',
        'frequency': 'Yearly',
        'date': date12,
        'createdAt': DateTime.now(),
      },
    ];

    final date16 = DateTime(today.year, today.month, 16);
    final dateKey3 = '${today.year}-${today.month.toString().padLeft(2, '0')}-16';
    events[dateKey3] = [
      {
        'id': '3',
        'title': "Emma's Soccer Practice",
        'description': 'Community Sports Center',
        'type': 'school',
        'time': '4:00 PM',
        'frequency': 'Weekly',
        'date': date16,
        'createdAt': DateTime.now(),
      },
      {
        'id': '4',
        'title': 'Parent-Teacher Conference',
        'description': 'Meet with Ms. Johnson',
        'type': 'school',
        'time': '6:30 PM',
        'frequency': 'Once',
        'date': date16,
        'createdAt': DateTime.now(),
      },
    ];

    final date20 = DateTime(today.year, today.month, 20);
    final dateKey4 = '${today.year}-${today.month.toString().padLeft(2, '0')}-20';
    events[dateKey4] = [
      {
        'id': '5',
        'title': 'Family Dinner',
        'description': 'Birthday celebration for Mom',
        'type': 'family',
        'time': '7:00 PM',
        'frequency': 'Once',
        'date': date20,
        'createdAt': DateTime.now(),
      },
    ];
  }

  String getMonthYearString() {
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
    return '${months[currentDate.value.month - 1]} ${currentDate.value.year}';
  }

  String getWeekRangeString() {
    // Calculate the start and end of the week (Sunday to Saturday)
    final startOfWeek = currentDate.value.subtract(Duration(days: currentDate.value.weekday % 7));
    final endOfWeek = startOfWeek.add(Duration(days: 6));
    final startFormat = DateFormat('MMM d');
    final endFormat = DateFormat('MMM d, yyyy');
    if (startOfWeek.month == endOfWeek.month) {
      return '${startFormat.format(startOfWeek)} - ${endOfWeek.day}, ${endOfWeek.year}';
    } else {
      return '${startFormat.format(startOfWeek)} - ${endFormat.format(endOfWeek)}';
    }
  }

  void previousMonth() {
    currentDate.value = DateTime(currentDate.value.year, currentDate.value.month - 1);
  }

  void nextMonth() {
    currentDate.value = DateTime(currentDate.value.year, currentDate.value.month + 1);
  }

  void previousWeek() {
    currentDate.value = currentDate.value.subtract(Duration(days: 7));
  }

  void nextWeek() {
    currentDate.value = currentDate.value.add(Duration(days: 7));
  }

  void changeView(String view) {
    selectedView.value = view;
    if (view == 'Week' && selectedDate.value != null) {
      // Adjust currentDate to the start of the week containing selectedDate
      currentDate.value = selectedDate.value!.subtract(Duration(days: selectedDate.value!.weekday % 7));
    }
  }

  void selectDate(DateTime date) {
    selectedDate.value = date;
    if (selectedView.value == 'Week') {
      // Adjust currentDate to the start of the week containing the selected date
      currentDate.value = date.subtract(Duration(days: date.weekday % 7));
    }
  }

  void deleteEvent(String eventTitle, {DateTime? eventDate}) {
    // Unchanged
    final date = eventDate ?? selectedDate.value;
    if (date != null) {
      final dateKey = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      if (events[dateKey] != null) {
        events[dateKey]!.removeWhere((event) => event['title'] == eventTitle);
        if (events[dateKey]!.isEmpty) {
          events.remove(dateKey);
        }
        events.refresh();
      }
    }
  }

  void updateEvent(String originalTitle, Map<String, dynamic> updatedEvent, {DateTime? eventDate}) {
    // Unchanged
    final date = eventDate ?? selectedDate.value;
    if (date != null) {
      final dateKey = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      if (events[dateKey] != null) {
        final eventIndex = events[dateKey]!.indexWhere((event) => event['title'] == originalTitle);
        if (eventIndex != -1) {
          events[dateKey]![eventIndex] = {...events[dateKey]![eventIndex], ...updatedEvent};
          events.refresh();
        }
      }
    }
  }

  void addEvent({
    required String title,
    String description = '',
    String type = 'personal',
    String time = '9:00 AM',
    String frequency = 'Once',
    DateTime? eventDate,
  }) {
    // Unchanged
    final date = eventDate ?? selectedDate.value;
    if (date != null) {
      final dateKey = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      if (events[dateKey] == null) {
        events[dateKey] = [];
      }
      final newEvent = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'title': title,
        'description': description,
        'type': type,
        'time': time,
        'frequency': frequency,
        'date': date,
        'createdAt': DateTime.now(),
      };
      events[dateKey]!.add(newEvent);
      events.refresh();
    }
  }

  List<Map<String, dynamic>> getEventsForDate(DateTime date) {
    // Unchanged
    return _getEventsForDate(date);
  }

  List<Map<String, dynamic>> getDaysInMonth() {
    // Unchanged
    final year = currentDate.value.year;
    final month = currentDate.value.month;
    final firstDayOfMonth = DateTime(year, month, 1);
    final lastDayOfMonth = DateTime(year, month + 1, 0);
    final firstDayOfWeek = firstDayOfMonth.weekday % 7;

    List<Map<String, dynamic>> days = [];

    for (int i = 0; i < firstDayOfWeek; i++) {
      final date = firstDayOfMonth.subtract(Duration(days: firstDayOfWeek - i));
      days.add({
        'day': date.day,
        'date': date,
        'isCurrentMonth': false,
        'isToday': _isToday(date),
        'isSelected': _isSelected(date),
        'events': _getEventsForDate(date),
      });
    }

    for (int day = 1; day <= lastDayOfMonth.day; day++) {
      final date = DateTime(year, month, day);
      days.add({
        'day': day,
        'date': date,
        'isCurrentMonth': true,
        'isToday': _isToday(date),
        'isSelected': _isSelected(date),
        'events': _getEventsForDate(date),
      });
    }

    final remainingCells = 42 - days.length;
    for (int i = 1; i <= remainingCells; i++) {
      final date = lastDayOfMonth.add(Duration(days: i));
      days.add({
        'day': date.day,
        'date': date,
        'isCurrentMonth': false,
        'isToday': _isToday(date),
        'isSelected': _isSelected(date),
        'events': _getEventsForDate(date),
      });
    }

    return days;
  }

  List<Map<String, dynamic>> getDaysInWeek() {
    // New method to get days for the selected week
    final startOfWeek = currentDate.value.subtract(Duration(days: currentDate.value.weekday % 7));
    List<Map<String, dynamic>> days = [];

    for (int i = 0; i < 7; i++) {
      final date = startOfWeek.add(Duration(days: i));
      days.add({
        'day': date.day,
        'date': date,
        'isCurrentMonth': true, // Treat all week days as "current" for display
        'isToday': _isToday(date),
        'isSelected': _isSelected(date),
        'events': _getEventsForDate(date),
      });
    }

    return days;
  }

  bool _isToday(DateTime date) {
    // Unchanged
    final today = DateTime.now();
    return date.year == today.year && date.month == today.month && date.day == today.day;
  }

  bool _isSelected(DateTime date) {
    // Unchanged
    if (selectedDate.value == null) return false;
    final selected = selectedDate.value!;
    return date.year == selected.year && date.month == selected.month && date.day == selected.day;
  }

  List<Map<String, dynamic>> _getEventsForDate(DateTime date) {
    // Unchanged
    final dateKey = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    return events[dateKey] ?? [];
  }

  List<Map<String, dynamic>> getEventsForSelectedDate() {
    // Unchanged
    if (selectedDate.value == null) return [];
    return _getEventsForDate(selectedDate.value!);
  }
}