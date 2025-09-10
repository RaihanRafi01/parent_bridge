// Controller code
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

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
  final List<String> repeatItems = ['Does not repeat', 'Daily', 'Weekly', 'Every 2 weeks', 'Monthly'];




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

  // Replace your _initializeSampleEvents method with this updated version:

  void _initializeSampleEvents() {
    final today = DateTime.now();

    // Today's events
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
      }
    ];

    // Sample event for the 12th
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
      }
    ];

    // Sample school event for the 16th
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
      }
    ];

    // Sample family event for the 20th
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
      }
    ];
  }

  String getMonthYearString() {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[currentDate.value.month - 1]} ${currentDate.value.year}';
  }

  void previousMonth() {
    currentDate.value = DateTime(currentDate.value.year, currentDate.value.month - 1);
  }

  void nextMonth() {
    currentDate.value = DateTime(currentDate.value.year, currentDate.value.month + 1);
  }

  void changeView(String view) {
    selectedView.value = view;
  }

  void selectDate(DateTime date) {
    selectedDate.value = date;
  }

  // Add these methods to your CalendarController class

// Method to delete an event by title (since your current structure uses title as identifier)
  void deleteEvent(String eventTitle, {DateTime? eventDate}) {
    final date = eventDate ?? selectedDate.value;
    if (date != null) {
      final dateKey = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

      if (events[dateKey] != null) {
        events[dateKey]!.removeWhere((event) => event['title'] == eventTitle);

        // Remove the date key if no events left
        if (events[dateKey]!.isEmpty) {
          events.remove(dateKey);
        }

        events.refresh(); // Trigger UI update
      }
    }
  }

// Method to update an event
  void updateEvent(String originalTitle, Map<String, dynamic> updatedEvent, {DateTime? eventDate}) {
    final date = eventDate ?? selectedDate.value;
    if (date != null) {
      final dateKey = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

      if (events[dateKey] != null) {
        final eventIndex = events[dateKey]!.indexWhere((event) => event['title'] == originalTitle);
        if (eventIndex != -1) {
          events[dateKey]![eventIndex] = {
            ...events[dateKey]![eventIndex],
            ...updatedEvent,
          };
          events.refresh(); // Trigger UI update
        }
      }
    }
  }

// Enhanced addEvent method with more properties (updated to work with your structure)
  void addEvent({
    required String title,
    String description = '',
    String type = 'personal',
    String time = '9:00 AM',
    String frequency = 'Once',
    DateTime? eventDate,
  }) {
    final date = eventDate ?? selectedDate.value;
    if (date != null) {
      final dateKey = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

      if (events[dateKey] == null) {
        events[dateKey] = [];
      }

      final newEvent = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(), // Add unique ID
        'title': title,
        'description': description,
        'type': type,
        'time': time,
        'frequency': frequency,
        'date': date,
        'createdAt': DateTime.now(),
      };

      events[dateKey]!.add(newEvent);
      events.refresh(); // Trigger UI update
    }
  }

// Method to get events for a specific date (public version of your private method)
  List<Map<String, dynamic>> getEventsForDate(DateTime date) {
    return _getEventsForDate(date);
  }


  List<Map<String, dynamic>> getDaysInMonth() {
    final year = currentDate.value.year;
    final month = currentDate.value.month;
    final firstDayOfMonth = DateTime(year, month, 1);
    final lastDayOfMonth = DateTime(year, month + 1, 0);
    final firstDayOfWeek = firstDayOfMonth.weekday % 7;

    List<Map<String, dynamic>> days = [];

    // Add empty cells for days before the first day of the month
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

    // Add days of the current month
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

    // Add empty cells for days after the last day of the month
    final remainingCells = 42 - days.length; // 6 rows * 7 days = 42 cells
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

  bool _isToday(DateTime date) {
    final today = DateTime.now();
    return date.year == today.year && date.month == today.month && date.day == today.day;
  }

  bool _isSelected(DateTime date) {
    if (selectedDate.value == null) return false;
    final selected = selectedDate.value!;
    return date.year == selected.year && date.month == selected.month && date.day == selected.day;
  }

  List<Map<String, dynamic>> _getEventsForDate(DateTime date) {
    final dateKey = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    return events[dateKey] ?? [];
  }

  List<Map<String, dynamic>> getEventsForSelectedDate() {
    if (selectedDate.value == null) return [];
    return _getEventsForDate(selectedDate.value!);
  }

}