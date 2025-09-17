// common/widgets/home/custom_listTile.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../../appColors.dart';

class CustomListTile extends StatelessWidget {
  final String leadingSvgAsset;
  final String title;
  final Widget? trailingWidget; // এটি এখন যেকোনো উইজেট (Icon, Switch, etc.) হতে পারে
  final VoidCallback? onTap;

  const CustomListTile({
    Key? key,
    required this.leadingSvgAsset,
    required this.title,
    this.trailingWidget, // এটি আর required নয়
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque, // ফাঁকা জায়গায়ও যেন ট্যাপ কাজ করে
      child: Container(
        height:56 ,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        decoration: BoxDecoration(
          color: AppColors.clrWhite,
          borderRadius: BorderRadius.circular(50.0),
          border: Border.all( color: AppColors.borderColor, width: 1.0.w),
          boxShadow: [
            BoxShadow(
              color: AppColors.boxShadowColor.withOpacity(0.14),
              spreadRadius: 0,
              blurRadius:  12.6,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            // সামনের SVG আইকন
            SvgPicture.asset(
              leadingSvgAsset,
              width: 22,
              height: 22,
              color :AppColors.gray2,
            ),
            const SizedBox(width: 16),

            // মাঝখানের টেক্সট
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.gray2,
                ),
              ),
            ),

            // পিছনের উইজেট (যদি থাকে)
            if (trailingWidget != null)
              trailingWidget!,
          ],
        ),
      ),
    );
  }
}