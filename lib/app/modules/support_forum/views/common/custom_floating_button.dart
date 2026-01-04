import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common/app_colors.dart';

class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 91.h,
        width: 91.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [AppColors.customSkyBlue, AppColors.customPurple],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 8.r,
              color: AppColors.clrBlack.withAlpha(128),
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: FloatingActionButton(
          highlightElevation: 0,
          shape: CircleBorder(),
          onPressed: () {},
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Icon(Icons.add, size: 21.49.sp),
        ),
      ),
    );
  }
}
