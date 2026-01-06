import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../common/appColors.dart';
import '../../../../../common/customFont.dart';

class search_partl extends StatelessWidget {
  const search_partl({super.key, required this.controller});

  final dynamic controller; // SupportForumController is passed from view

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsGeometry.only(top: 8.r, bottom: 12.r),
      width: 394.w,
      height: 46.h,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.btnBorder),
        borderRadius: BorderRadius.circular(10.96.r),
      ),
      child: Obx(
        () => TextField(
          controller: controller.searchController,
          onChanged: controller.setSearchQuery,
          decoration: InputDecoration(
            hintText: 'Search',
            prefixIcon: SvgPicture.asset(
              'assets/svg/support_forum_/icons/search_icon.svg',
              color: AppColors.search_bar_01,
            ),
            suffixIcon: controller.searchQuery.value.isEmpty
                ? null
                : IconButton(
                    icon: Icon(Icons.close, size: 18.sp),
                    onPressed: () {
                      controller.searchController.clear();
                      controller.setSearchQuery('');
                    },
                  ),
            border: InputBorder.none,
            hintStyle: h4.copyWith(
              color: AppColors.search_bar_01,
              fontSize: 14.sp,
            ),
          ),
        ),
      ),
    );
  }
}
