import 'package:get/get.dart';

class SettingsController extends GetxController {
  var messageNotifications = true.obs;
  var callNotifications = true.obs;
  var calendarNotifications = true.obs;
  var expenseRequests = false.obs;

  void toggleMessageNotifications(bool value) {
    messageNotifications.value = value;
  }

  void toggleCallNotifications(bool value) {
    callNotifications.value = value;
  }

  void toggleCalendarNotifications(bool value) {
    calendarNotifications.value = value;
  }

  void toggleExpenseRequests(bool value) {
    expenseRequests.value = value;
  }
}
