import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:parent_bridge/app/modules/onboarding/views/onboarding_page_view.dart';
import 'package:parent_bridge/common/app_colors.dart';
import 'package:parent_bridge/common/custom_font.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure controller is initialized
    Get.put(OnboardingController());

    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none, // Prevent clipping of positioned widgets
        children: [
          // Background SVGs
          Positioned(
            left: 0.w,
            top: 0.h,
            child: SvgPicture.asset('assets/images/onboarding/top_left.svg'),
          ),
          Positioned(
            right: 0.w,
            bottom: 0.h,
            child: SvgPicture.asset(
              'assets/images/onboarding/bottom_right.svg',
            ),
          ),
          // PageView for onboarding content
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.onPageChanged,
            children: const [
              OnboardingPageView(
                image: 'assets/images/onboarding/onboarding_1.svg',
                title: 'Smart Communication',
                subtitle:
                    'AI-powered message filtering removes hostility while preserving your message\'s meaning',
              ),
              OnboardingPageView(
                image: 'assets/images/onboarding/onboarding_2.svg',
                title: 'Legal Protection',
                subtitle:
                    'All conversations are recorded and can be exported for court proceedings when needed',
              ),
              OnboardingPageView(
                image: 'assets/images/onboarding/onboarding_3.svg',
                title: 'Shared Planning',
                subtitle:
                    'Coordinate schedules, track expenses, and manage documents in one secure place',
              ),
              OnboardingPageView(
                image: 'assets/images/onboarding/onboarding_4.svg',
                title: 'Community Support',
                subtitle:
                    'Connect with other co-parents in our anonymous support forum for advice and encouragement',
              ),
            ],
          ),
          // Skip button
          Positioned(
            right: 0.w,
            top: 40.h,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                debugPrint("Skip button tapped");
                controller.skip();
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 20.h,
                ), // Larger tap area
                child: Text(
                  'Skip',
                  style: h1.copyWith(
                    color: AppColors.textColor16,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          ),
          // Next button
          Positioned(
            right: 0.w,
            top: 500.h, // Moved from -50.h to ensure tappable area
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                debugPrint("Next button tapped");
                controller.next();
              },
              child: SvgPicture.asset('assets/images/onboarding/side_bg.svg'),
            ),
          ),
          // Page indicators
          Positioned(
            left: 31.w,
            top:
                810.h, // Kept as per your code, but adjusted for responsiveness
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(
                  4,
                  (index) =>
                      IndicatorDot(isActive: controller.current.value == index),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IndicatorDot extends StatelessWidget {
  final bool isActive;

  const IndicatorDot({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.5.w),
      width: 7.62.w,
      height: 7.62.h,
      decoration: BoxDecoration(
        color: isActive ? AppColors.nav3 : Colors.transparent,
        borderRadius: BorderRadius.circular(2.29.r),
        border: Border.all(
          color: isActive ? Colors.transparent : AppColors.nav3,
          width: 0.76.r,
        ),
      ),
    );
  }
}
