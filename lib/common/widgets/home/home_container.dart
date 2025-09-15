import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../appColors.dart';
import '../../customFont.dart';


class IconWithBadge extends StatelessWidget {
  final Widget childImage;
  final String label;
  final int badgeCount;
  final String backgroundImage;
  final VoidCallback onPressed;

  const IconWithBadge({
    super.key,
    required this.onPressed,
    required this.childImage,
    required this.label,
    this.badgeCount = 0,
    this.backgroundImage = "assets/images/home/img_1.png", // default background
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              // Background container
              Container(
                padding: EdgeInsets.all(25).r,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(backgroundImage),
                    fit: BoxFit.contain,
                  ),
                ),
                child: childImage,
              ),

              // Notification badge (only if > 0)
              if (badgeCount > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 20.w,

                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.lightPurplePink,
                          AppColors.deepPurple,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        width: 2,
                        color: AppColors.white.withOpacity(0.2),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "$badgeCount",
                        style: h1.copyWith(
                          color: AppColors.white,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 5.h),
          Text(
            label,
            style: h2Inter.copyWith(
              fontSize: 15.64.sp,
              color: AppColors.darkSlateBlue,
            ),
          ),
        ],
      ),
    );
  }
}
