import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:parent_bridge/app/modules/support_forum/views/show_dialog/show_dialog_page.dart';

import '../../../../../common/appColors.dart';
import '../../../../../common/customFont.dart';
import 'custom_react_comment.dart';

class custom_anonymous_parent extends StatelessWidget {
  const custom_anonymous_parent({
    super.key,
    this.color,
    this.sche_title,
    this.threeDot_ontap,
    this.body_title,
    this.body_subtitle,
    this.bg_color,
    this.dialog_ontap,
  });

  final Color? color;
  final Color? bg_color;
  final String? sche_title;
  final String? body_title;
  final String? body_subtitle;
  final VoidCallback? threeDot_ontap;
  final VoidCallback? dialog_ontap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 394.w,
      height: 310.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: bg_color,
      ),
      child: Padding(
        padding:   EdgeInsets.all(15.0.r),
        child: Column(
          children: [
            /// header ..
            SizedBox(
              height: 50.h,
              child: Row(
                children: [
                  // text logo ..
                  Container(
                    width: 37.sp,
                    height: 37.sp,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1000.r),
                      color: AppColors.white,
                    ),
                    child: Center(
                      child: Text(
                        'AP',
                        style:h2.copyWith(fontSize: 18.16.sp,
                          color: AppColors.darkSlateBlue,)
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
                            style:h3.copyWith(
                              color:AppColors.darkSlateBlue,
                              fontSize: 17.9.sp
                            )
                          ),
                          SizedBox(width: 20.w),

                          // scheduling part...
                          Container(
                            width: 72.w,
                            height: 22.h,
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(850.75.sp),
                            ),
                            child: Center(
                              child: Text(
                                '$sche_title',
                                style: h3.copyWith(
                                  fontSize: 11.91.sp,
                                  color: AppColors.white,
                                )
                              ),
                            ),
                          ),
                          SizedBox(width: 30),
                          // three dot ...
                          GestureDetector(
                            onTap: threeDot_ontap,
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
                          color: AppColors.custom_anonymous_parent_01,
                          fontSize: 14.32
                        )
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// header ends ...
            SizedBox(height: 30),

            /// body start ..
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // body title text ..
                Text(
                  "$body_title",
                  style: h2.copyWith(
                    color: color,
                    fontSize: 20.sp
                  )
                ),
                SizedBox(height: 10),
                // body part ...
                GestureDetector(
                  onTap:dialog_ontap,
                  child: RichText(
                    text: TextSpan(
                      text: "$body_subtitle",
                      style: h4.copyWith(
                        fontSize: 14.32.sp,
                        color: AppColors.custom_anonymous_parent_02
                      ),
                      children: [
                        TextSpan(
                          text: ' See more',
                          style: h2.copyWith(
                            fontSize: 14.32,
                            color: color
                          )
                        ),


                      ],
                    ),
                  ),
                ),
              ],
            ),
            // body end ....
            SizedBox(height: 40),
            /// end part ....
            // react and comments ....
            Row(
              children: [
                custom_react_comment(count: '100',svg_image:'assets/svg/support_forum_/icons/heart_shape.svg'),
                SizedBox(width: 30),
                custom_react_comment(count: '100',svg_image:'assets/svg/support_forum_/icons/message_icon.svg')
              ],
            )
          ],
        ),
      ),
    );
  }
}