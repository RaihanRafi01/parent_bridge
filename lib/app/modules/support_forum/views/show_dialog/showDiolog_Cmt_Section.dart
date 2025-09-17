import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:parent_bridge/app/modules/support_forum/views/reply_section/reply_page.dart';
import 'package:parent_bridge/app/modules/support_forum/views/show_dialog/commet_section.dart';

import '../../../../../common/appColors.dart';
import '../../../../../common/customFont.dart';
import '../common/custom_react_comment.dart';

class show_dialog_cmt_section extends StatelessWidget {
  const show_dialog_cmt_section({
    super.key,
    this.body_title,
    required this.color,
    this.cmt_dialog_subtitle,
  });

  final String? body_title;
  final String? cmt_dialog_subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Dialog(

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: SizedBox(
          width: 387.w,
          child: Column(
            children: [
              //Header ...
              Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsGeometry.all(10.r),
                  child: Stack(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,

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
                                      fontSize: 17.9.sp,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ],
                              ),

                              // time ..
                              Text(
                                '3d',
                                style: h4.copyWith(
                                  fontSize: 14.32.sp,
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),

                          // three dot ...
                        ],
                      ),
                      Positioned(
                        top: 0.sp,
                        right: 2.sp,
                        child: Container(
                          padding: EdgeInsets.all(3.sp),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            color: Colors.white,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: SvgPicture.asset(
                              'assets/svg/support_forum_/icons/cross.svg',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // header end  ..

              // body
              // title ...
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffFFFBF3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      Text(
                        "$body_title",
                        style: h2.copyWith(color: color, fontSize: 20.sp),
                      ),
                      SizedBox(height: 20.h),

                      Text(
                        "$cmt_dialog_subtitle",
                        style: h4.copyWith(
                          color: AppColors.custom_anonymous_parent_02,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 40.h),

                      // react and comments ....
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Row(
                          children: [
                            custom_react_comment(
                              count: '100',
                              svg_image:
                                  'assets/svg/support_forum_/icons/heart_shape.svg',
                            ),
                            SizedBox(width: 30.w),
                            custom_react_comment(
                              count: '100',
                              svg_image:
                                  'assets/svg/support_forum_/icons/message_icon.svg',
                            ),
                          ],
                        ),
                      ),
                      // comment section ..
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.show_dialog_with_Comment_03.withOpacity(0.5),

                              blurRadius: 4.0,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: comment_section(),
                      ),

                      SizedBox(height: 50),

                      SizedBox(
                        height: 43.h,
                        width: 349.w,
                        child: Row(
                          children: [
                            Container(
                              width: 270,
                              height: 43,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: color,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100.r),
                                ),
                                color: color.withOpacity(0.1),
                              ),
                              child: Padding(
                                padding:   EdgeInsets.only(bottom: 12.0,right: 15,left: 20),
                                child: TextField(
                                  decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                   focusedBorder : InputBorder.none,
                                    hintText: ' Type here ..',
                                    hintStyle: h4.copyWith(
                                      fontSize: 12.sp,
                                      color: AppColors.reply_msg_1,
                                    )
                                  ),
                                ),
                              ),
                            ),
                            // sent button ..


                             Padding(
                                padding:   EdgeInsets.only(left: 10.r),
                                child: SvgPicture.asset('assets/svg/support_forum_/icons/sent.svg',color: color,),

                              )
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
