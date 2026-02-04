import 'package:get/get.dart';
import 'package:parent_bridge/app/core/services/base_client.dart';
import 'package:parent_bridge/app/modules/calendar/controllers/calendar_controller.dart';
import 'package:parent_bridge/app/modules/call/controllers/call_controller.dart';
import 'package:parent_bridge/app/modules/chat/controllers/chat_controller.dart';
import 'package:parent_bridge/app/modules/expense_tracker/controllers/expense_tracker_controller.dart';

import '../modules/authentication/controllers/authentication_controller.dart';
// Sets up dependency injection using GetX for the app's dependencies.
Future<void> setupDependencies() async {

  // Controllers

  Get.put(AuthenticationController());
  Get.put(CalendarController());
  Get.put(ChatController());
  Get.put(ExpenseTrackerController());

  final bool isLoggedIn = await BaseClient.isLoggedIn();

  if(isLoggedIn){
    Get.put(CallController());
  }

}