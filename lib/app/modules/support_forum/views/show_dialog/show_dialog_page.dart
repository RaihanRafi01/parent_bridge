import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:parent_bridge/app/modules/support_forum/views/show_dialog/show_dialog_comment_section.dart';
import 'package:parent_bridge/common/app_colors.dart';
import 'package:parent_bridge/common/custom_font.dart';

import '../common/custom_react_comment.dart';

class ShowDialogPage extends StatelessWidget {
  const ShowDialogPage({
    super.key,
    this.bodyTitle,
    required this.color,
    this.dialogSubtitle,
  });

  final String? bodyTitle;
  final String? dialogSubtitle;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
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
                  color: AppColors.anonymousParent_02,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      Text(
                        "$bodyTitle",
                        style: h2.copyWith(color: color, fontSize: 20.sp),
                      ),
                      SizedBox(height: 20.h),

                      Text(
                        "$dialogSubtitle",
                        style: h4.copyWith(
                          color: AppColors.customAnonymousParent_02,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 40.h),

                      // react and comments ....
                      Padding(
                        padding: EdgeInsets.only(bottom: 30.r),
                        child: Row(
                          children: [
                            CustomReactComment(
                              count: '100',
                              svgImage:
                                  'assets/svg/support_forum_/icons/heart_shape.svg',
                            ),
                            SizedBox(width: 30.w),
                            CustomReactComment(
                              count: '100',
                              svgImage:
                                  'assets/svg/support_forum_/icons/message_icon.svg',
                              commentOnTap: () {
                                // second show dialog with comments ..
                                Get.dialog(
                                  ShowDialogCommentSection(
                                    color: color,
                                    bodyTitle: '$bodyTitle',
                                    cmtDialogSubtitle: '$dialogSubtitle',
                                  ),
                                  barrierColor: AppColors.transparent,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
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
