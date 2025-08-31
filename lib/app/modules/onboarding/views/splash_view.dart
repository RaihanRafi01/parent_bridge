import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0.w,
            top: 0.h,
            child: Image.asset(
              'assets/images/onboarding/splash_screen_topLeft.png',
              scale: 4,
            ),
          ),

          Positioned(
            left: 68.w,
            top: 315.h,
            child: Image.asset(
              'assets/images/onboarding/splash_screen_center.png',
              scale: 4,
            ),
          ),

          Positioned(
            left: 141.w,
            top: 693.h,
            child: Image.asset(
              'assets/images/onboarding/splash_screen_bottomRight.png',
              scale: 4,
            ),
          ),
        ],
      ),
    );
  }
}
