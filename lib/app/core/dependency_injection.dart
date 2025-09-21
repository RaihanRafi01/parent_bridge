import 'package:get/get.dart';
import 'package:parent_bridge/app/modules/calendar/controllers/calendar_controller.dart';
import 'package:parent_bridge/app/modules/chat/controllers/chat_controller.dart';
import 'package:parent_bridge/app/modules/expense_tracker/controllers/expense_tracker_controller.dart';

import '../modules/authentication/controllers/authentication_controller.dart';
// Sets up dependency injection using GetX for the app's dependencies.
void setupDependencies() {

  // Controllers

  Get.put(AuthenticationController());
  Get.put(CalendarController());
  Get.put(ChatController());
  Get.put(ExpenseTrackerController());
}