import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:parent_bridge/app/modules/calendar/models/delete_holiday_request.dart';
import 'package:parent_bridge/app/modules/calendar/models/holiday_request_model.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/widgets/custom_snackbar.dart';
import '../../../core/constants/api.dart';
import '../../../core/services/base_client.dart';
import '../models/create_event_request_model.dart';
import '../models/create_event_response_model.dart';
import '../models/delete_event_request.dart';
import '../models/event_response_model.dart';
import '../models/holiday_response_model.dart';
import '../models/holiday_view_response_model.dart';
import '../models/parent_bridge_response_model.dart';

class CalendarController extends GetxController {
  final eventName = TextEditingController();
  final eventOwnerName = TextEditingController();
  final eventType = TextEditingController();
  final eventDate = TextEditingController();
  final eventEDate = TextEditingController();
  final eventSTime = TextEditingController();
  final eventETime = TextEditingController();
  final eventLocation = TextEditingController();
  final eventDescription = TextEditingController();
  final eventReminderTime = TextEditingController();

  final allDayEvent = false.obs;
  final currentDate = DateTime.now().obs;
  final selectedDate = Rx<DateTime?>(null);
  final selectedView = 'Month'.obs;
  final events = <String, List<Map<String, dynamic>>>{}.obs;
  final holidays = <String, List<Map<String, dynamic>>>{}.obs;
  void toggleAllDayEvent() => allDayEvent.value = !allDayEvent.value;

  //Loading status
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    selectedDate.value = DateTime.now();
    // _initializeSampleEvents();
    fetchEvents();
  }

  // void _initializeSampleEvents() {
  //   final today = DateTime.now();
  //   events['${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}'] =
  //       [
  //         {
  //           'id': '1',
  //           'title': 'Team Meeting',
  //           'description': 'Weekly team sync',
  //           'type': 'work',
  //           'time': '10:00 AM',
  //           'frequency': 'Weekly',
  //           'location': 'Conference Room A',
  //           'organizer': 'John Doe',
  //           'date': today,
  //           'createdAt': DateTime.now(),
  //         },
  //       ];
  //   final tomorrow = today.add(Duration(days: 1));
  //   events['${tomorrow.year}-${tomorrow.month.toString().padLeft(2, '0')}-${tomorrow.day.toString().padLeft(2, '0')}'] =
  //       [
  //         {
  //           'id': '2',
  //           'title': "Emma's Soccer Practice",
  //           'description': 'Weekly training',
  //           'type': 'school',
  //           'time': '4:00 PM',
  //           'frequency': 'Weekly',
  //           'location': 'Community Sports Center',
  //           'organizer': 'Emma Wilson',
  //           'date': tomorrow,
  //           'createdAt': DateTime.now(),
  //         },
  //       ];
  //   final dayAfter = today.add(Duration(days: 2));
  //   print('date $dayAfter');
  //   print('createdAt ${DateTime.now()}');
  //   events['${dayAfter.year}-${dayAfter.month.toString().padLeft(2, '0')}-${dayAfter.day.toString().padLeft(2, '0')}'] =
  //       [
  //         {
  //           'id': '3',
  //           'title': 'Parent-Teacher Conference',
  //           'description': 'Meet with Ms. Johnson',
  //           'type': 'school',
  //           'time': '6:30 PM',
  //           'frequency': 'Once',
  //           'location': 'Elementary School',
  //           'organizer': 'Ms. Johnson',
  //           'date': dayAfter,
  //           'createdAt': DateTime.now(),
  //         },
  //         {
  //           'id': '4',
  //           'title': "Mom's Work Meeting",
  //           'description': 'Project discussion',
  //           'type': 'work',
  //           'time': '2:00 PM',
  //           'frequency': 'Once',
  //           'location': 'Downtown Office',
  //           'organizer': 'Sarah Smith',
  //           'date': dayAfter,
  //           'createdAt': DateTime.now(),
  //         },
  //       ];
  //   final laterDate = today.add(Duration(days: 5));
  //   events['${laterDate.year}-${laterDate.month.toString().padLeft(2, '0')}-${laterDate.day.toString().padLeft(2, '0')}'] =
  //       [
  //         {
  //           'id': '5',
  //           'title': 'Family Dinner',
  //           'description': 'Birthday celebration',
  //           'type': 'family',
  //           'time': '7:00 PM',
  //           'frequency': 'Once',
  //           'location': 'The Italian Place',
  //           'organizer': 'Family',
  //           'date': laterDate,
  //           'createdAt': DateTime.now(),
  //         },
  //       ];
  // }

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
    final startOfWeek = currentDate.value.subtract(
      Duration(days: currentDate.value.weekday % 7),
    );
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
        return selectedDate.value != null
            ? getFormattedDate(selectedDate.value!)
            : getMonthYearString();
      default:
        return getMonthYearString();
    }
  }

  void previousMonth() => currentDate.value = DateTime(
    currentDate.value.year,
    currentDate.value.month - 1,
  );
  void nextMonth() => currentDate.value = DateTime(
    currentDate.value.year,
    currentDate.value.month + 1,
  );
  void previousWeek() =>
      currentDate.value = currentDate.value.subtract(Duration(days: 7));
  void nextWeek() =>
      currentDate.value = currentDate.value.add(Duration(days: 7));
  void previousDay() {
    if (selectedDate.value != null) {
      selectedDate.value = selectedDate.value!.subtract(Duration(days: 1));
      currentDate.value = selectedDate.value!;
    }
  }

  void nextDay() {
    if (selectedDate.value != null) {
      selectedDate.value = selectedDate.value!.add(Duration(days: 1));
      currentDate.value = selectedDate.value!;
    }
  }

  void changeView(String view) {
    selectedView.value = view;
    if (view == 'Week' && selectedDate.value != null) {
      currentDate.value = selectedDate.value!.subtract(
        Duration(days: selectedDate.value!.weekday % 7),
      );
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

  void deleteEventById(String eventId) {
    // Remove the event matching the eventId
    events.forEach((dataKey, eventList) {
      // Remove the event matching the eventId
      eventList.removeWhere((event) => event['id'] == eventId);
    });

    // Refresh the events list
    events.refresh();
  }

  void deleteHolidayById(String holidayId) {
    // Remove the event matching the eventId
    holidays.forEach((dataKey, holidayList) {
      // Remove the event matching the eventId
      holidayList.removeWhere((holiday) => holiday['id'] == holidayId);
    });

    // Refresh the events list
    holidays.refresh();
  }

  Future<void> deleteEvent(String eventId) async {
    try {
      isLoading.value = true;
      final deleteEventRequest = DeleteEventRequest(eventId: eventId);
      // Make API call to fetch event and holiday data
      final response = await BaseClient.deleteRequest(
        api: '${Api.events}$eventId/delete/',
        body: jsonEncode(deleteEventRequest.toJson()),
        headers: BaseClient.authHeaders(),
      );

      if (response.statusCode == 204) {
        deleteEventById(eventId);

        // Show success message
        kSnackBar(
          title: "Success",
          message: "Events successfully retrieved and event deleted",
          bgColor: AppColors.appColor,
        );

        debugPrint('Delete events: $events');
      } else {
        // Handle error response
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        String errorMessage = "Failed to delete events . Please try again.";

        if (errorData.containsKey('message')) {
          errorMessage = errorData['message'];
        }

        kSnackBar(
          title: "Event Delete Failed",
          message: errorMessage,
          bgColor: AppColors.snackBarWarning,
        );
      }
    } catch (e) {
      // Handle exceptions
      kSnackBar(
        title: "Error",
        message: "An error occurred while delete events . Please try again.",
        bgColor: AppColors.snackBarWarning,
      );
      debugPrint("Event delete error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteHoliday(String holidayId) async {
    try {
      isLoading.value = true;
      final deleteEventRequest = DeleteHolidayRequest(holidayId: holidayId);
      // Make API call to fetch event and holiday data
      final response = await BaseClient.deleteRequest(
        api: '${Api.holidays}$holidayId/delete/',
        body: jsonEncode(deleteEventRequest.toJson()),
        headers: BaseClient.authHeaders(),
      );

      if (response.statusCode == 204) {
        deleteHolidayById(holidayId);

        // Show success message
        kSnackBar(
          title: "Success",
          message:
              "Events and Holidays successfully retrieved and event deleted",
          bgColor: AppColors.appColor,
        );

        debugPrint('Fetched events: $events');
        debugPrint('Fetched holidays: $holidays');
      } else {
        // Handle error response
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        String errorMessage =
            "Failed to fetch events and holidays. Please try again.";

        if (errorData.containsKey('message')) {
          errorMessage = errorData['message'];
        }

        kSnackBar(
          title: "Event and Holiday Fetch Failed",
          message: errorMessage,
          bgColor: AppColors.snackBarWarning,
        );
      }
    } catch (e) {
      // Handle exceptions
      kSnackBar(
        title: "Error",
        message:
            "An error occurred while fetching events and holidays. Please try again.",
        bgColor: AppColors.snackBarWarning,
      );
      debugPrint("Holiday fetch error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // void updateEvent(
  //   String originalTitle,
  //   Map<String, dynamic> updatedEvent, {
  //   DateTime? eventDate,
  // }) {
  //   final date = eventDate ?? selectedDate.value;
  //   if (date != null) {
  //     final dateKey =
  //         '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  //     final eventIndex =
  //         events[dateKey]?.indexWhere(
  //           (event) => event['title'] == originalTitle,
  //         ) ??
  //         -1;
  //     if (eventIndex != -1) {
  //       events[dateKey]![eventIndex] = {
  //         ...events[dateKey]![eventIndex],
  //         ...updatedEvent,
  //       };
  //       events.refresh();
  //     }
  //   }
  // }

  // void addEvent({
  //   required String title,
  //   String description = '',
  //   String type = 'personal',
  //   String time = '9:00 AM',
  //   String frequency = 'Once',
  //   String location = '',
  //   String organizer = '',
  //   DateTime? eventDate,
  // }) {
  //   final date = eventDate ?? selectedDate.value;
  //   if (date != null) {
  //     final dateKey =
  //         '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  //     events[dateKey] ??= [];
  //     events[dateKey]!.add({
  //       'id': DateTime.now().millisecondsSinceEpoch.toString(),
  //       'title': title,
  //       'description': description,
  //       'type': type,
  //       'time': time,
  //       'frequency': frequency,
  //       'location': location,
  //       'organizer': organizer,
  //       'date': date,
  //       'createdAt': DateTime.now(),
  //     });
  //     events.refresh();
  //   }
  // }

  final updateId = 0.obs;

  final updatedEvent = <String, dynamic>{}.obs;
  void updateEventById(
    String eventId, // Use eventId to identify the event
    Map<String, dynamic> updatedEvent,
  ) {
    // Loop through the events to find the event by its id
    events.forEach((dataKey, eventList) {
      final eventIndex = eventList.indexWhere(
        (event) => event['id'] == eventId,
      );

      if (eventIndex != -1) {
        // Update the event
        eventList[eventIndex] = {...eventList[eventIndex], ...updatedEvent};
      }
    });
    // Get.back();
    // Refresh the events list
    events.refresh();
  }

  Future<void> updateEvent(int eventId) async {
    selectChildByName(selectedChildName.value.toString());
    selectRepeatByName(selectedRepeatType.value.toString());
    selectEventByName(selectedEventType.value.toString());
    // Validate input fields
    if (selectedRepeatType.value.toString().isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please select a repeat",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }
    if (selectedEventType.value.toString().isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please select a event type",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }
    if (selectedChildId.value.toString().isEmpty ||
        selectedChildId.value == 0) {
      kSnackBar(
        title: "Validation Error",
        message: "Please select a chile",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }
    if (eventName.text.trim().isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please enter the event name",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }

    if (eventDate.text.trim().isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please select the event date",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }

    if (eventSTime.text.trim().isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please enter the event start time",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }

    if (eventETime.text.trim().isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please enter the event end time",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }

    if (eventLocation.text.trim().isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please enter the event location",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }

    if (eventDescription.text.trim().isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please enter the event description",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }

    if (eventReminderTime.text.trim().isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please enter the reminder time",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }

    try {
      isLoading.value = true;
      String formattedDate = DateFormat(
        'yyyy-MM-dd',
      ).format(DateTime.parse(eventDate.text.trim()));
      // Create EventRequestModel using the controllers' values
      final eventRequest = CreateEventRequestModel(
        child:
            selectedChildId.value, // Assuming 'child' is not passed dynamically
        title: eventName.text.trim(),
        type:
            selectedEventType.value ??
            'activity', // Assuming 'eventType' is text-based
        date: formattedDate,
        startTime: eventSTime.text.trim(),
        endTime: eventETime.text.trim(),
        location: eventLocation.text.trim(),
        repeat:
            selectedRepeatType.value ??
            'Does not repeat', // Assuming default repeat value, update as needed
        // customStartDate: eventDate.text.trim(),
        // customEndDate: eventDate.text.trim(),
        reminderMinutes:
            int.tryParse(eventReminderTime.text.trim()) ??
            0, // Parse reminder time
        description: eventDescription.text.trim(),
      );

      // Make API call to create the event
      final response = await BaseClient.patchRequest(
        api: '${Api.events}$eventId/edit/',
        body: jsonEncode(eventRequest.toJson()),
        headers: BaseClient.authHeaders(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parse response
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final eventResponse = CreateEventResponseModel.fromJson(responseData);
        updateCheck(false);
        updateEventById(updateId.value.toString(), {
          'child': selectedChildName.value ?? 'Not specified',
          'organizer': eventOwnerName.text,
          'title': eventName.text,
          'type': selectedEventType.value ?? 'unknown',
          'date': eventDate.text,
          'start_time': eventSTime.text,
          'end_time': eventETime.text,
          'description': eventDescription.text,
          'location': eventLocation.text,
          'repeat': selectedRepeatType.value ?? 'once',
        });

        clearFormData();

        // Navigate to event details page or another page
        Get.back();
        kSnackBar(
          title: "Success",
          message: eventResponse.message.isNotEmpty
              ? eventResponse.message
              : "Event created successfully",
          bgColor: AppColors.appColor,
        );
      } else {
        // Handle error response
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        String errorMessage = "Failed to create event. Please try again.";

        // Check for error messages
        if (errorData.containsKey('non_field_errors')) {
          final errors = errorData['non_field_errors'];
          if (errors is List && errors.isNotEmpty) {
            errorMessage = errors[0].toString();
          }
        } else if (errorData.containsKey('message')) {
          errorMessage = errorData['message'];
        } else if (errorData.containsKey('detail')) {
          errorMessage = errorData['detail'];
        } else if (errorData.containsKey('error')) {
          errorMessage = errorData['error'];
        }

        kSnackBar(
          title: "Event Creation Failed",
          message: errorMessage,
          bgColor: AppColors.snackBarWarning,
        );
      }
    } catch (e) {
      // Handle exceptions
      kSnackBar(
        title: "Error",
        message: "An error occurred during event creation. Please try again.",
        bgColor: AppColors.snackBarWarning,
      );
      debugPrint("Event creation error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void updateHolidayById(
    String holidayId, // Use eventId to identify the event
    Map<String, dynamic> updatedHoliday,
  ) {
    // Loop through the events to find the event by its id
    holidays.forEach((dataKey, holidayList) {
      final holidayIndex = holidayList.indexWhere(
        (holiday) => holiday['id'] == holidayId,
      );

      if (holidayIndex != -1) {
        // Update the event
        holidayList[holidayIndex] = {
          ...holidayList[holidayIndex],
          ...updatedHoliday,
        };
      }
    });
    // Get.back();
    // Refresh the events list
    holidays.refresh();
  }

  Future<void> updateHoliday(int holidayId) async {
    selectChildByName(selectedChildName.value.toString());
    // Validate input fields
    if (selectedChildId.value.toString().isEmpty ||
        selectedChildId.value == 0) {
      kSnackBar(
        title: "Validation Error",
        message: "Please select a chile",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }
    if (assignValue.value.toString().isEmpty ||
        assignValue.value == 'Assigned to') {
      kSnackBar(
        title: "Validation Error",
        message: "Please select a assigned to",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }
    if (holidayValue.value.toString().isEmpty ||
        holidayValue.value == 'Select or type holiday name') {
      kSnackBar(
        title: "Validation Error",
        message: "Please select a holiday",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }
    if (eventDate.text.trim().isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please select the start event date",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }
    if (eventEDate.text.trim().isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please select the end event date",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }
    if (eventLocation.text.trim().isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please enter the event location",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }
    if (eventDescription.text.trim().isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please enter the event description",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }
    try {
      isLoading.value = true;

      // Create HolidayRequestModel using the controllers' values
      final holidayRequest = HolidayRequestModel(
        child:
            selectedChildId.value, // Assuming 'child' is not passed dynamically
        name: holidayValue.value ?? '',
        startDate: eventDate.text.trim(),
        endDate: eventEDate.text.trim(),
        assignedTo: assignValue.value ?? '',
        location: eventLocation.text.trim(),
        description: eventDescription.text.trim(),
      );

      // Make API call to create the holiday
      final response = await BaseClient.patchRequest(
        api: '${Api.holidays}$holidayId/edit/',
        body: jsonEncode(holidayRequest.toJson()),
        headers: BaseClient.authHeaders(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parse response
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final eventResponse = HolidayResponseModel.fromJson(responseData);
        updateCheck(false);
        updateHolidayById(updateId.value.toString(), {
          'child': selectedChildName.value ?? 'Not specified',
          'organizer': eventOwnerName.text,
          'name': holidayValue.value,
          'assigned_to': assignValue.value,
          'location': eventLocation.text,
          'description': eventDescription.text,
          'start_date': eventDate.text,
          'end_date': eventEDate.text,
        });

        clearFormData();

        // Navigate to event details page or another page
        Get.back();
        kSnackBar(
          title: "Success",
          message: eventResponse.message.isNotEmpty
              ? eventResponse.message
              : "Event created successfully",
          bgColor: AppColors.appColor,
        );
      } else {
        // Handle error response
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        String errorMessage = "Failed to create holiday. Please try again.";

        // Check for error messages
        if (errorData.containsKey('non_field_errors')) {
          final errors = errorData['non_field_errors'];
          if (errors is List && errors.isNotEmpty) {
            errorMessage = errors[0].toString();
          }
        } else if (errorData.containsKey('message')) {
          errorMessage = errorData['message'];
        } else if (errorData.containsKey('detail')) {
          errorMessage = errorData['detail'];
        } else if (errorData.containsKey('error')) {
          errorMessage = errorData['error'];
        }

        kSnackBar(
          title: "Holiday Creation Failed",
          message: errorMessage,
          bgColor: AppColors.snackBarWarning,
        );
      }
    } catch (e) {
      // Handle exceptions
      kSnackBar(
        title: "Error",
        message: "An error occurred during holiday creation. Please try again.",
        bgColor: AppColors.snackBarWarning,
      );
      debugPrint("Holiday creation error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  ///event
  final eventItems = ['Activity', 'School', 'Custody', 'Medical', 'Other'];
  final selectedEventTypes = [
    'activity',
    'school',
    'custody',
    'medical',
    'other',
  ];
  final updateCheck = false.obs;
  var selectedEventType = Rx<String?>(
    'activity',
  ); // Default value is 'activity_type'

  void selectEventByName(String name) {
    // Find the corresponding index in eventItems
    final index = eventItems.indexOf(name);

    if (index != -1) {
      // Update selectedEventType with the corresponding value from selectedEventTypes
      selectedEventType.value = selectedEventTypes[index];
    } else {
      // Default to 'activity_type' if not found
      selectedEventType.value = 'activity';
    }

    // Now, selectedEventType will hold the selected event type from selectedEventTypes
    debugPrint('Selected Event Type: ${selectedEventType.value}');
  }

  final repeatItems = ['Does not repeat', 'Weekly', 'Monthly', 'Custom'];
  final selectedRepeatItems = ['once', 'weekly', 'monthly', 'custom'];

  var selectedRepeatType = Rx<String?>('once'); // Default value is 'once'

  void selectRepeatByName(String name) {
    // Find the corresponding index in repeatItems
    final index = repeatItems.indexOf(name);

    if (index != -1) {
      // Update selectedRepeat with the corresponding value from selectedRepeatItems
      selectedRepeatType.value = selectedRepeatItems[index];
    } else {
      // Default to 'once' if not found
      selectedRepeatType.value = 'once';
    }

    // Now, selectedRepeat will hold the selected repeat type from selectedRepeatItems
    debugPrint('Selected Repeat: ${selectedRepeatType.value}');
  }

  // List to store the names of the children
  final List<String> childNames = [];

  // List to store the corresponding IDs of the children
  final List<int> childIds = [];

  // The variable to store the selected child's name
  var selectedChildName = Rx<String?>('Select child\'s');

  // The variable to store the selected child's ID based on the selected name
  Rx<int> selectedChildId = Rx<int>(0); // Use Rx<int> for reactive updates

  void selectChildByName(String name) {
    selectedChildName.value = name; // Use .value to update the Rx variable

    // Find the corresponding ID based on the selected name
    final index = childNames.indexOf(name);

    if (index != -1) {
      selectedChildId.value =
          childIds[index]; // Update selectedChildId using .value
    } else {
      selectedChildId.value = 0; // Default to 0 if not found
    }

    // Now, selectedChildName and selectedChildId will hold the selected name and ID respectively
    debugPrint('Selected Child Name: ${selectedChildName.value}');
    debugPrint('Selected Child ID: ${selectedChildId.value}');
  }

  Future<void> createEvent() async {
    selectChildByName(selectedChildName.value.toString());
    selectRepeatByName(selectedRepeatType.value.toString());
    selectEventByName(selectedEventType.value.toString());
    // Validate input fields
    if (selectedRepeatType.value.toString().isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please select a repeat",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }
    if (selectedEventType.value.toString().isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please select a event type",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }
    if (selectedChildId.value.toString().isEmpty ||
        selectedChildId.value == 0) {
      kSnackBar(
        title: "Validation Error",
        message: "Please select a chile",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }
    if (eventName.text.trim().isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please enter the event name",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }

    if (eventDate.text.trim().isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please select the event date",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }

    if (eventSTime.text.trim().isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please enter the event start time",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }

    if (eventETime.text.trim().isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please enter the event end time",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }

    if (eventLocation.text.trim().isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please enter the event location",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }

    if (eventDescription.text.trim().isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please enter the event description",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }

    if (eventReminderTime.text.trim().isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please enter the reminder time",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }

    try {
      isLoading.value = true;

      // Create EventRequestModel using the controllers' values
      final eventRequest = CreateEventRequestModel(
        child:
            selectedChildId.value, // Assuming 'child' is not passed dynamically
        title: eventName.text.trim(),
        type:
            selectedEventType.value ??
            'activity', // Assuming 'eventType' is text-based
        date: eventDate.text.trim(),
        startTime: eventSTime.text.trim(),
        endTime: eventETime.text.trim(),
        location: eventLocation.text.trim(),
        repeat:
            selectedRepeatType.value ??
            'Does not repeat', // Assuming default repeat value, update as needed
        // customStartDate: eventDate.text.trim(),
        // customEndDate: eventDate.text.trim(),
        reminderMinutes:
            int.tryParse(eventReminderTime.text.trim()) ??
            0, // Parse reminder time
        description: eventDescription.text.trim(),
      );

      // Make API call to create the event
      final response = await BaseClient.postRequest(
        api: Api.createEvent, // Replace with your actual API endpoint
        body: jsonEncode(eventRequest.toJson()),
        headers: BaseClient.authHeaders(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parse response
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final eventResponse = CreateEventResponseModel.fromJson(responseData);
        clearFormData();

        // Navigate to event details page or another page
        Get.back();
        kSnackBar(
          title: "Success",
          message: eventResponse.message.isNotEmpty
              ? eventResponse.message
              : "Event created successfully",
          bgColor: AppColors.appColor,
        );
      } else {
        // Handle error response
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        String errorMessage = "Failed to create event. Please try again.";

        // Check for error messages
        if (errorData.containsKey('non_field_errors')) {
          final errors = errorData['non_field_errors'];
          if (errors is List && errors.isNotEmpty) {
            errorMessage = errors[0].toString();
          }
        } else if (errorData.containsKey('message')) {
          errorMessage = errorData['message'];
        } else if (errorData.containsKey('detail')) {
          errorMessage = errorData['detail'];
        } else if (errorData.containsKey('error')) {
          errorMessage = errorData['error'];
        }

        kSnackBar(
          title: "Event Creation Failed",
          message: errorMessage,
          bgColor: AppColors.snackBarWarning,
        );
      }
    } catch (e) {
      // Handle exceptions
      kSnackBar(
        title: "Error",
        message: "An error occurred during event creation. Please try again.",
        bgColor: AppColors.snackBarWarning,
      );
      debugPrint("Event creation error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  final holidayItems = [
    "New Year's Day",
    "Martin Luther King Jr. Day",
    "Presidents Day",
    "Easter",
    "Memorial Day",
    "Independence Day",
    "Labor Day",
    "Columbus Day",
    "Halloween",
    "Thanksgiving",
    "Christmas Eve",
  ];
  var holidayValue = Rx<String?>('Select or type holiday name');
  final assignItems = ["Dad", "Mom"];
  var assignValue = Rx<String?>('Assigned to'); // Default value is 'once'
  Future<void> createHoliday() async {
    selectChildByName(selectedChildName.value.toString());
    // Validate input fields
    if (selectedChildId.value.toString().isEmpty ||
        selectedChildId.value == 0) {
      kSnackBar(
        title: "Validation Error",
        message: "Please select a chile",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }
    if (assignValue.value.toString().isEmpty ||
        assignValue.value == 'Assigned to') {
      kSnackBar(
        title: "Validation Error",
        message: "Please select a assigned to",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }
    if (holidayValue.value.toString().isEmpty ||
        holidayValue.value == 'Select or type holiday name') {
      kSnackBar(
        title: "Validation Error",
        message: "Please select a holiday",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }
    if (eventDate.text.trim().isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please select the start event date",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }
    if (eventEDate.text.trim().isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please select the end event date",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }
    if (eventLocation.text.trim().isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please enter the event location",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }
    if (eventDescription.text.trim().isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please enter the event description",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }
    try {
      isLoading.value = true;

      // Create HolidayRequestModel using the controllers' values
      final holidayRequest = HolidayRequestModel(
        child:
            selectedChildId.value, // Assuming 'child' is not passed dynamically
        name: holidayValue.value ?? '',
        startDate: eventDate.text.trim(),
        endDate: eventEDate.text.trim(),
        assignedTo: assignValue.value ?? '',
        location: eventLocation.text.trim(),
        description: eventDescription.text.trim(),
      );

      // Make API call to create the holiday
      final response = await BaseClient.postRequest(
        api: Api.createHoliday, // Replace with your actual API endpoint
        body: jsonEncode(holidayRequest.toJson()),
        headers: BaseClient.authHeaders(),
      );
      debugPrint('response.statusCode: ${response.statusCode}');
      debugPrint('response.body: ${response.body}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parse response
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final activityResponse = HolidayResponseModel.fromJson(responseData);

        // Navigate to activity details page or another page
        Get.back();
        clearFormData();
        kSnackBar(
          title: "Success",
          message: activityResponse.message.isNotEmpty
              ? activityResponse.message
              : "Holiday created successfully",
          bgColor: AppColors.appColor,
        );
      } else {
        // Handle error response
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        String errorMessage = "Failed to create holiday. Please try again.";

        // Check for error messages
        if (errorData.containsKey('non_field_errors')) {
          final errors = errorData['non_field_errors'];
          if (errors is List && errors.isNotEmpty) {
            errorMessage = errors[0].toString();
          }
        } else if (errorData.containsKey('message')) {
          errorMessage = errorData['message'];
        } else if (errorData.containsKey('detail')) {
          errorMessage = errorData['detail'];
        } else if (errorData.containsKey('error')) {
          errorMessage = errorData['error'];
        }

        kSnackBar(
          title: "Holiday Creation Failed",
          message: errorMessage,
          bgColor: AppColors.snackBarWarning,
        );
      }
    } catch (e) {
      // Handle exceptions
      kSnackBar(
        title: "Error",
        message: "An error occurred during holiday creation. Please try again.",
        bgColor: AppColors.snackBarWarning,
      );
      debugPrint("Holiday creation error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void clearFormData() {
    // Clear all form data and reset the selections
    selectedChildId.value = 0;
    selectedRepeatType.value = 'once'; // Default value
    selectedEventType.value = 'activity'; // Default value
    holidayValue.value = 'Select or type holiday name'; // Default value
    assignValue.value = 'Assigned to'; // Default value

    eventName.clear();
    eventDate.clear();
    eventEDate.clear();
    eventSTime.clear();
    eventETime.clear();
    eventLocation.clear();
    eventDescription.clear();
    eventReminderTime.clear();

    selectedChildName.value = null; // Reset selected child name
  }

  ///brigde
  Future<void> bridgeInfo() async {
    try {
      isLoading.value = true;

      // Make API call to create the activity
      final response = await BaseClient.getRequest(
        api: Api.bridgeInfo, // Replace with your actual API endpoint
        headers: BaseClient.authHeaders(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parse response
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final activityResponse = ParentBridgeResponseModel.fromJson(
          responseData,
        );

        for (var child in activityResponse.data.children) {
          childNames.add(child.name);
          childIds.add(child.id);
        }
        debugPrint('$childNames');
        debugPrint('$childIds');
        // Show success message
        kSnackBar(
          title: "Success",
          message: activityResponse.message.isNotEmpty
              ? activityResponse.message
              : "Bridge info successfully get",
          bgColor: AppColors.appColor,
        );
      } else {
        // Handle error response
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        String errorMessage = "Failed to get bridge info. Please try again.";

        // Check for error messages
        if (errorData.containsKey('non_field_errors')) {
          final errors = errorData['non_field_errors'];
          if (errors is List && errors.isNotEmpty) {
            errorMessage = errors[0].toString();
          }
        } else if (errorData.containsKey('message')) {
          errorMessage = errorData['message'];
        } else if (errorData.containsKey('detail')) {
          errorMessage = errorData['detail'];
        } else if (errorData.containsKey('error')) {
          errorMessage = errorData['error'];
        }

        kSnackBar(
          title: "Bridge info Get Failed",
          message: errorMessage,
          bgColor: AppColors.snackBarWarning,
        );
      }
    } catch (e) {
      // Handle exceptions
      kSnackBar(
        title: "Error",
        message: "An error occurred during bridge info get. Please try again.",
        bgColor: AppColors.snackBarWarning,
      );
      debugPrint("Bridge info get error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchEvents() async {
    try {
      isLoading.value = true;
      DateTime currentDates =
          currentDate.value; // Or set this to a specific month if needed

      // Calculate the start and end dates of the current month
      DateTime firstDateOfMonth = DateTime(
        currentDates.year,
        currentDates.month,
        1,
      );
      DateTime lastDateOfMonth = DateTime(
        currentDates.year,
        currentDates.month + 1,
        0,
      );

      // Convert these DateTime objects to string format
      String startDateString = firstDateOfMonth.toIso8601String();
      String endDateString = lastDateOfMonth.toIso8601String();


      // Make API call to fetch event and holiday data
      final response = await BaseClient.getRequest(
        api: Api.eventList, // Replace with your actual API endpoint for events
        params: {
          "start_date": startDateString,
          "end_date": endDateString,
        }, // Add params to the request
        headers: BaseClient.authHeaders(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parse response
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        final eventList = (responseData['data']['events'] as List);
        final holidayList = (responseData['data']['holidays'] as List);
        final message = responseData['message'];

        // Clear existing events and holidays before adding new ones
        events.clear();
        holidays.clear();

        // Loop through the events and store them grouped by date
        for (var eventJson in eventList) {
          final event = EventResponseModel.fromJson(eventJson);

          // Add event to the events map grouped by date
          addEventToDate(events, event);
        }

        // Loop through the holidays and store them grouped by date
        for (var holidayJson in holidayList) {
          final holiday = HolidayViewResponseModel.fromJson(holidayJson);

          // Add holiday to the holidays map grouped by start date
          addHolidayToDate(holidays, holiday);
        }

        // Show success message
        kSnackBar(
          title: "Success",
          message: message,
          bgColor: AppColors.appColor,
        );

        debugPrint('Fetched events: $events');
        debugPrint('Fetched holidays: $holidays');
      } else {
        // Handle error response
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        String errorMessage =
            "Failed to fetch events and holidays. Please try again.";

        if (errorData.containsKey('message')) {
          errorMessage = errorData['message'];
        }

        kSnackBar(
          title: "Event and Holiday Fetch Failed",
          message: errorMessage,
          bgColor: AppColors.snackBarWarning,
        );
      }
    } catch (e) {
      // Handle exceptions
      kSnackBar(
        title: "Error",
        message:
            "An error occurred while fetching events and holidays. Please try again.",
        bgColor: AppColors.snackBarWarning,
      );
      debugPrint("Event and holiday fetch error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void addHolidayToDate(
    Map<String, List<Map<String, dynamic>>> holidays,
    HolidayViewResponseModel holiday,
  ) {
    // Format the date to YYYY-MM-DD
    String holidayDate = DateFormat(
      'yyyy-MM-dd',
    ).format(DateTime.parse(holiday.startDate));

    // If the holiday's date doesn't already exist in the map, create a new entry for it
    if (!holidays.containsKey(holidayDate)) {
      holidays[holidayDate] = [];
    }

    // Format the holiday fields correctly
    final holidayData = {
      'id': holiday.id.toString(),
      'child': holiday.child,
      'organizer': holiday.postBy,
      'name': holiday.name,
      'assigned_to': holiday.assignedTo,
      'location': holiday.location,
      'description': holiday.description,
      'start_date': formatEventDate(holiday.startDate),
      'end_date': formatEventDate(holiday.endDate),
      'created_at': holiday.createdAt,
      'updated_at': holiday.updatedAt,
    };

    // Add the holiday to the list for the corresponding date
    holidays[holidayDate]?.add(holidayData);
  }

  void addEventToDate(
    Map<String, List<Map<String, dynamic>>> events,
    EventResponseModel event,
  ) {
    // Format the date to YYYY-MM-DD
    String eventDate = DateFormat(
      'yyyy-MM-dd',
    ).format(DateTime.parse(event.date));

    // If the event's date doesn't already exist in the map, create a new entry for it
    if (!events.containsKey(eventDate)) {
      events[eventDate] = [];
    }

    // Format the event fields correctly
    final eventData = {
      'id': event.id.toString(),
      'child': event.child,
      'child_id': event.childId,
      'title': event.title,
      'description': event.description,
      'type': event.type,
      'time': formatEventTime(event.startTime),
      'location': event.location,
      'organizer': event.postBy, // Fix: Use 'assignedTo' as the organizer
      'date': formatEventDate(event.date),
      'createdAt': formatEventDate(event.createdAt),
      'start_time': formatEventTime(event.startTime),
      'end_time': formatEventTime(event.endTime),
      'repeat': event.repeat,
      'custom_start_date': event.customStartDate,
      'custom_end_date': event.customEndDate,
      'reminder_minutes': event.reminderMinutes,
    };

    // Add the event to the list for the corresponding date
    events[eventDate]?.add(eventData);
  }

  String formatEventDate(String date) {
    // Convert date to proper format (e.g., 'yyyy-MM-dd HH:mm:ss')
    try {
      return DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(date));
    } catch (e) {
      return date; // Return original if there's an issue
    }
  }

  String formatEventTime(String time) {
    // Just return the time if it's valid
    return time.isNotEmpty ? time : '00:00';
  }

  List<Map<String, dynamic>> getWeeklyEvents() {
    final startOfWeek = currentDate.value.subtract(
      Duration(days: currentDate.value.weekday % 7),
    );
    final endOfWeek = startOfWeek.add(Duration(days: 6));
    List<Map<String, dynamic>> weeklyEvents = [];
    for (
      var date = startOfWeek;
      date.isBefore(endOfWeek.add(Duration(days: 1)));
      date = date.add(Duration(days: 1))
    ) {
      final events = _getEventsForDate(date);
      if (events.isNotEmpty) weeklyEvents.add({'date': date, 'events': events});
    }
    return weeklyEvents;
  }

  List<Map<String, dynamic>> getMonthEvents() {
    final firstDay = DateTime(
      currentDate.value.year,
      currentDate.value.month,
      1,
    );
    final lastDay = DateTime(
      currentDate.value.year,
      currentDate.value.month + 1,
      0,
    );
    List<Map<String, dynamic>> monthEvents = [];
    for (
      var date = firstDay;
      date.isBefore(lastDay.add(Duration(days: 1)));
      date = date.add(Duration(days: 1))
    ) {
      final events = _getEventsForDate(date);
      if (events.isNotEmpty) monthEvents.add({'date': date, 'events': events});
    }
    return monthEvents;
  }

  List<Map<String, dynamic>> getDayEvents() {
    if (selectedDate.value == null) return [];
    final events = _getEventsForDate(selectedDate.value!);
    if (events.isEmpty) return [];
    return [
      {'date': selectedDate.value, 'events': events},
    ];
  }

  List<Map<String, dynamic>> getHolidays() {
    List<Map<String, dynamic>> holidayList = [];

    // Loop through the holidays and organize them by date
    holidays.forEach((holidayDate, holidayEvents) {
      // Add holidays for each date to the list
      holidayList.add({'date': holidayDate, 'holidays': holidayEvents});
    });

    return holidayList;
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
      days.add({
        'day': date.day,
        'date': date,
        'isCurrentMonth': false,
        'isToday': _isToday(date),
        'isSelected': _isSelected(date),
        'events': _getEventsForDate(date),
      });
    }

    for (int day = 1; day <= lastDay.day; day++) {
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
      final date = lastDay.add(Duration(days: i));
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
    final startOfWeek = currentDate.value.subtract(
      Duration(days: currentDate.value.weekday % 7),
    );
    List<Map<String, dynamic>> days = [];
    for (int i = 0; i < 7; i++) {
      final date = startOfWeek.add(Duration(days: i));
      days.add({
        'day': date.day,
        'date': date,
        'isCurrentMonth': true,
        'isToday': _isToday(date),
        'isSelected': _isSelected(date),
        'events': _getEventsForDate(date),
      });
    }
    return days;
  }

  bool _isToday(DateTime date) {
    final today = DateTime.now();
    return date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;
  }

  bool _isSelected(DateTime date) =>
      selectedDate.value != null &&
      date.year == selectedDate.value!.year &&
      date.month == selectedDate.value!.month &&
      date.day == selectedDate.value!.day;

  List<Map<String, dynamic>> _getEventsForDate(DateTime date) {
    return events['${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}'] ??
        [];
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
