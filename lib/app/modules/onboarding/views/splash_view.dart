import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

class SplashView extends GetView {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 68.w,
            top: 315.h,
            child: Image.asset(
              'assets/images/onboarding/splash_screen_center.png',
              scale: 4,
            ),
          )
        ],
      ),
    );
  }
}
