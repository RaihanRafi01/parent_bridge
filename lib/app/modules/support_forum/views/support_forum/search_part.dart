import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../common/app_colors.dart';
import '../../../../../common/custom_font.dart';

class SearchPart extends StatelessWidget {
  const SearchPart({super.key});

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
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',

          prefixIcon: SvgPicture.asset(
            'assets/svg/support_forum_/icons/search_icon.svg',
            colorFilter: ColorFilter.mode(
              AppColors.searchBar_01,
              BlendMode.srcIn,
            ),
          ),
          border: InputBorder.none,
          hintStyle: h4.copyWith(
            color: AppColors.searchBar_01,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }
}
