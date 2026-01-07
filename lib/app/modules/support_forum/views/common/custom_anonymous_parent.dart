import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../common/app_colors.dart';
import '../../../../../common/custom_font.dart';
import '../reply_section/reply_page.dart';
import 'custom_react_comment.dart';

class CustomAnonymousParent extends StatelessWidget {
  const CustomAnonymousParent({
    super.key,
    required this.color,
    this.scheTitle,
    this.threeDotOnTap,
    this.bodyTitle,
    this.bodySubtitle,
    this.bgColor,
    this.dialogOnTap,
  });

  final Color color;
  final Color? bgColor;
  final String? scheTitle;
  final String? bodyTitle;
  final String? bodySubtitle;
  final VoidCallback? threeDotOnTap;
  final VoidCallback? dialogOnTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.r),
      child: Container(
        width: 394.w,
        height: 310.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0.r),
          color: bgColor,
        ),
        child: Padding(
          padding: EdgeInsets.all(15.0.r),
          child: Column(
            children: [
              /// header ..
              SizedBox(
                height: 55.h,
                child: Row(
                  children: [
                    // text logo ..
                    Container(
                      width: 37.w,
                      height: 37.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1000.r),
                        color: AppColors.white,
                      ),
                      child: Center(
                        child: Text(
                          'AP',
                          style: h2.copyWith(
                            fontSize: 18.16.sp,
                            color: AppColors.darkSlateBlue,
                          ),
                        ),
                      ),
                    ),
                    // space ..
                    SizedBox(width: 15.w),
                    // title ..
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Anonymous Parent',
                              style: h3.copyWith(
                                color: AppColors.darkSlateBlue,
                                fontSize: 17.9.sp,
                              ),
                            ),
                            SizedBox(width: 20.w),

                            // scheduling part...
                            Container(
                              height: 22.h,

                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(850.75.sp),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 5.r, right: 5.r),
                                child: Center(
                                  child: Text(
                                    '$scheTitle',
                                    style: h3.copyWith(
                                      fontSize: 11.91.sp,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 20.h),
                            // three dot ...
                            GestureDetector(
                              onTap: threeDotOnTap,
                              child: SizedBox(
                                height: 21.48.h,
                                width: 21.48.w,
                                child: SvgPicture.asset(
                                  'assets/svg/support_forum_/icons/threeDot.svg',
                                ),
                              ),
                            ),
                          ],
                        ),

                        // time ..
                        Text(
                          '3d',
                          style: h4.copyWith(
                            color: AppColors.customAnonymousParent_01,
                            fontSize: 14.32.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// header ends ...
              SizedBox(height: 30.h),

              /// body start ..
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // body title text ..
                  Text(
                    "$bodyTitle",
                    style: h2.copyWith(color: color, fontSize: 20.sp),
                  ),
                  SizedBox(height: 10.h),
                  // body part ...
                  SizedBox(
                    width: 330.w,
                    child: GestureDetector(
                      onTap: dialogOnTap,
                      child: RichText(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        text: TextSpan(
                          text: "$bodySubtitle",

                          style: h4.copyWith(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 14.32.sp,
                            color: AppColors.customAnonymousParent_02,
                          ),
                          children: [
                            TextSpan(
                              text: ' See more',
                              style: h2.copyWith(
                                fontSize: 14.32.sp,
                                color: color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // body end ....
              SizedBox(height: 25.h),

              /// end part ....
              // react and comments ....
              Row(
                children: [
                  CustomReactComment(
                    count: '100',
                    svgImage:
                        'assets/svg/support_forum_/icons/heart_shape.svg',
                  ),
                  SizedBox(width: 30.w),
                  GestureDetector(
                    onTap: () {
                      Get.dialog(
                        ReplyPage(color: color),
                        barrierColor: AppColors.postPage_01.withAlpha(154),
                      );
                    },
                    child: CustomReactComment(
                      count: '100',
                      svgImage:
                          'assets/svg/support_forum_/icons/message_icon.svg',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
