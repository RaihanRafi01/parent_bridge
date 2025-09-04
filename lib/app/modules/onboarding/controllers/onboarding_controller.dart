import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parent_bridge/app/modules/authentication/views/sign_in_view.dart';
import 'package:parent_bridge/app/modules/authentication/views/sign_up_view.dart';

class OnboardingController extends GetxController {
  final pageController = PageController();
  final current = 0.obs;

  void onPageChanged(int i) => current.value = i;

  void skip() => Get.to(SignInView());

  void next() {
    if (current.value < 3) {
      pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      Get.offAll(SignInView());
    }
  }

  void openSignIn() => Get.to(SignInView());
  void openSignUp() => Get.to(SignUpView());

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
