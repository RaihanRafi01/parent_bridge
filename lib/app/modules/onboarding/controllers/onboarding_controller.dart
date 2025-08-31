import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  final pageController = PageController();
  final current = 0.obs;

  void onPageChanged(int i) => current.value = i;

  void skip() => Get.offAllNamed('/home');

  void next() {
    if (current.value < 3) {
      pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      Get.offAllNamed('/home');
    }
  }

  void openSignIn() => Get.toNamed('/sign-in');
  void openSignUp() => Get.toNamed('/sign-up');

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
