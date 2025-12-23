import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:parent_bridge/app/modules/onboarding/views/onboarding_view.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final AnimationController anim;
  late final Animation<double> fade;

  @override
  void onInit() {
    super.onInit();
    print('Hi');

    anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    fade = CurvedAnimation(parent: anim, curve: Curves.easeIn);
    anim.forward();

    _bootstrap();
  }

  Future<void> _bootstrap() async {
    await Future.delayed(const Duration(seconds: 2));
    final bool isLoggedIn = await _fakeAuthCheck();

    if (isLoggedIn) {
      Get.offAllNamed('/home');
    } else {
      Get.offAll(OnboardingView());
    }
  }

  Future<bool> _fakeAuthCheck() async {
    return false;
  }

  @override
  void onClose() {
    anim.dispose();
    super.onClose();
  }
}
