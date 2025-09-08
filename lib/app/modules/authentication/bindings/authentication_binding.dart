import 'package:get/get.dart';

import 'package:parent_bridge/app/modules/authentication/controllers/new_password_controller.dart';
import 'package:parent_bridge/app/modules/authentication/controllers/otp_verifications_controller.dart';
import 'package:parent_bridge/app/modules/authentication/controllers/sign_up_controller.dart';

import '../controllers/authentication_controller.dart';

class AuthenticationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpVerificationsController>(
      () => OtpVerificationsController(),
    );
    Get.lazyPut<NewPasswordController>(
      () => NewPasswordController(),
    );
    Get.lazyPut<SignUpController>(
      () => SignUpController(),
    );
    Get.lazyPut<AuthenticationController>(
      () => AuthenticationController(),
    );
  }
}
