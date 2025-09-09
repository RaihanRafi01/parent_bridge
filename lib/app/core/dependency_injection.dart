import 'package:get/get.dart';

import '../modules/authentication/controllers/authentication_controller.dart';
// Sets up dependency injection using GetX for the app's dependencies.
void setupDependencies() {

  // Controllers

  Get.put(AuthenticationController());
}