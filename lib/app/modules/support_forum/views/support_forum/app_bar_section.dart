

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:parent_bridge/app/modules/support_forum/views/post_page/custom_textfeild.dart';
import 'package:parent_bridge/common/appColors.dart';
import 'package:parent_bridge/common/customFont.dart';

import '../post_page/post_page.dart';

class app_bar_section extends StatelessWidget {
  const app_bar_section({
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    return Container(
      height: 145.h,
      width: 440.w,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.appbar_color_01, AppColors.appbar_color_02],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40.r),
          bottomRight: Radius.circular(40.r),
        ),
      ),
      child: Padding(
        padding:   EdgeInsets.all(8.0.r),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// back button ...
            GestureDetector(
              onTap: Get.back,
              child: SvgPicture.asset('assets/images/common/back_icon.svg'),
            ),

            /// page name and post button  ..
            Expanded(
              child: Row(
                children: [
                  // page name
                  Text(
                    'Support Forum',
                    style:h2.copyWith(fontSize: 24.47.sp)
                  ),
                  // space between two item
                  Spacer(),
                  // post button
                  GestureDetector(

                    onTap: () {
                      Get.to(()=>post_page());
                      print('This is Post button ');
                    },
                    child: Container(
                      width: 74.w,
                      height: 35.16.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: AppColors.appbar_color_01,
                      ),
                      child: Center(
                        child: Text(
                          'Post',
                          style:h2.copyWith(
                            fontSize: 18.16.sp
                          )
                        )
                      )
                    )
                  )
                ]
              )
            )
          ]
        )
      ),
    );
  }
}