import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:parent_bridge/app/modules/home/views/home_view.dart';
import 'package:parent_bridge/app/modules/onboarding/views/onboarding_page_view.dart';
import 'package:parent_bridge/common/appColors.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: -77.w,
            top: -60.h,
            child: Image.asset(
              'assets/images/onboarding/splash_screen_topLeft.png',
              scale: 4,
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 389.w, top: 53.h,),

            child: GestureDetector(
              onTap: () => Get.offAll(HomeView()),
              child: Text(
                'Skip',
                style: TextStyle(
                  color: AppColors.textColor16,
                  fontFamily: 'lato',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

          PageView(
            controller: controller.pageController,
            onPageChanged: controller.onPageChanged,
            children: const [
              OnboardingPageView(
                image: 'assets/images/onboarding/onboarding1.png',
                title: 'Smart Communication',
                subtitle: 'AI-powered message filtering removes hostility while preserving your message\'s meaning',
              ),
              OnboardingPageView(
                image: 'assets/images/onboarding/onboarding2.png',
                title: 'Legal Protection',
                subtitle: 'All conversations are recorded and can be exported for court proceedings when needed',
              ),
              OnboardingPageView(
                image: 'assets/images/onboarding/onboarding3.png',
                title: 'Shared Planning',
                subtitle: 'Coordinate schedules, track expenses, and manage documents in one secure place',
              ),
              OnboardingPageView(
                image: 'assets/images/onboarding/onboarding4.png',
                title: 'Community Support',
                subtitle: 'Connect with other co-parents in our anonymous support forum for advice and encouragement',
              ),
            ],
          ),

          Obx(() {
            final idx = controller.current.value;
            return Positioned(
              left: 31.w,
              top: 810.h,
              child: Row(
                spacing: 5.w,
                children: [
                  Container(
                    width: 7.61904764175415.w,
                    height: 7.61904764175415.h,
                    decoration: BoxDecoration(
                      color: idx == 0 ? AppColors.nav3 : Colors.transparent,
                      borderRadius: BorderRadius.circular(2.29.r),
                      border: Border.all(
                        color: idx == 0 ? Colors.transparent : AppColors.nav3,
                        width: 0.76.r,
                      ),
                    ),
                  ),

                  Container(
                    width: 7.61904764175415.w,
                    height: 7.61904764175415.h,
                    decoration: BoxDecoration(
                      color: idx == 1 ? AppColors.nav3 : Colors.transparent,
                      borderRadius: BorderRadius.circular(2.29.r),
                      border: Border.all(
                        color: idx == 1 ? Colors.transparent : AppColors.nav3,
                        width: 0.76.r,
                      ),
                    ),
                  ),

                  Container(
                    width: 7.61904764175415.w,
                    height: 7.61904764175415.h,
                    decoration: BoxDecoration(
                      color: idx == 2 ? AppColors.nav3 : Colors.transparent,
                      borderRadius: BorderRadius.circular(2.29.r),
                      border: Border.all(
                        color: idx == 2 ? Colors.transparent : AppColors.nav3,
                        width: 0.76.r,
                      ),
                    ),
                  ),

                  Container(
                    width: 7.61904764175415.w,
                    height: 7.61904764175415.h,
                    decoration: BoxDecoration(
                      color: idx == 3 ? AppColors.nav3 : Colors.transparent,
                      borderRadius: BorderRadius.circular(2.29.r),
                      border: Border.all(
                        color: idx == 3 ? Colors.transparent : AppColors.nav3,
                        width: 0.76.r,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),

          Positioned(
            left: 371.w,
            top: -110.h,
            child: Image.asset(
              'assets/images/onboarding/side_bg.png',
              scale: 4,
            ),
          ),

          Positioned(
            left: 386.w,
            top: 655.h,
            child: GestureDetector(
              onTap: () => controller.next(),
              child: Container(
                padding: EdgeInsets.all(12.5.r),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.clrWhite.withAlpha(107),
                    width: 1.12.r,
                  )
                ),
                child: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: AppColors.clrWhite,
                  size: 18.r,
                ),
              ),
            ),
          ),

          Positioned(
            left: 219.w,
            top: 746.h,
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
