// Controller code
import 'package:get/get.dart';

class CalendarController extends GetxController {
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
    final today = DateTime.now();
    final dateKey = '${today.year}-${today.month.toString().padLeft(2, '0')}-01';
    events[dateKey] = [
      {'title': 'Meeting', 'description': 'Team meeting', 'type': 'work'}
    ];

    final dateKey2 = '${today.year}-${today.month.toString().padLeft(2, '0')}-12';
    events[dateKey2] = [
      {'title': 'Doctor Appointment', 'description': 'Annual checkup', 'type': 'personal'}
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

  void addEvent({required String title, required String description, required String type}) {
    if (selectedDate.value != null) {
      final date = selectedDate.value!;
      final dateKey = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

      if (events[dateKey] == null) {
        events[dateKey] = [];
      }

      events[dateKey]!.add({
        'title': title,
        'description': description,
        'type': type,
        'date': date,
      });

      events.refresh(); // Trigger UI update
    }
  }

  List<Map<String, dynamic>> getEventsForSelectedDate() {
    if (selectedDate.value == null) return [];
    return _getEventsForDate(selectedDate.value!);
  }
}