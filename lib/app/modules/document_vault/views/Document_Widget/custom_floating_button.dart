import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parent_bridge/common/app_colors.dart';

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
              color: Colors.grey.withAlpha(128),
              offset: Offset(0, 3),
            ),
          ],
          border: Border.all(width: 1.5.r, color: Color(0xFFFFFFFF)),
        ),
        child: FloatingActionButton(
          highlightElevation: 0,
          shape: CircleBorder(),
          onPressed: () {},
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(Icons.add, size: 36.83),
        ),
      ),
    );
  }
}
