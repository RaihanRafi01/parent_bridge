import 'package:get/get.dart';

import 'package:parent_bridge/app/modules/onboarding/controllers/splash_controller.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
      () => SplashController(),
    );
    Get.lazyPut<OnboardingController>(
      () => OnboardingController(),
    );
  }
}
