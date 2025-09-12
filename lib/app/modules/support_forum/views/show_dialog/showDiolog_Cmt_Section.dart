
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:parent_bridge/app/modules/support_forum/views/show_dialog/commet_section.dart';

import '../common/custom_react_comment.dart';

class show_dialog_cmt_section extends StatelessWidget {
  const show_dialog_cmt_section({super.key, this.body_title, this.color, this.body_subtitle});

  final String? body_title;
  final String? body_subtitle;
  final Color?color;
  @override
  Widget build(BuildContext context) {
    return Dialog(

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      child: SingleChildScrollView(
        child: SizedBox(

          width: 387.w,
          child: Column(
            children: [
              //Header ...
              Container(
                decoration: BoxDecoration(
                    color: color,
                    borderRadius:BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                ),
                child: Padding(
                  padding: EdgeInsetsGeometry.all(10),
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          // text logo ..
                          Container(
                            width: 37.sp,
                            height: 37.sp,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1000.r),
                              color: Color(0xffffffff),
                            ),
                            child: Center(
                              child: Text(
                                'AP',
                                style: GoogleFonts.lato(
                                  fontSize: 18.16.sp,
                                  fontWeight: FontWeight.w600,
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
                                    style: GoogleFonts.lato(
                                      fontSize: 17.9.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),

                              // time ..
                              Text(
                                '3d',
                                style: GoogleFonts.lato(
                                  fontSize: 14.32.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),

                            ],
                          ),
                          Spacer(),
                          // three dot ...

                        ],
                      ),
                      Positioned(
                        top:0.sp,
                        right: 2.sp,
                        child: Container(
                          padding: EdgeInsets.all(3.sp),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100.r),color: Colors.white),
                          child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child:SvgPicture.asset('assets/svg/support_forum_/icons/cross.svg')
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
                decoration: BoxDecoration(color: Color(0xffFFFBF3),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding:   EdgeInsets.all(10.sp),
                  child: Column(
                    children: [
                      SizedBox(height: 30.h),
                      Text(
                        "$body_title",
                        style: GoogleFonts.lato(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: color,
                        ),
                      ),
                      SizedBox(height: 20.h),

                      Text(
                        "$body_subtitle",
                        style: GoogleFonts.lato(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 40.h),

                      // react and comments ....
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Row(
                          children: [
                            custom_react_comment(count: '100',svg_image:'assets/svg/support_forum_/icons/heart_shape.svg'),
                            SizedBox(width: 30.w),
                            custom_react_comment(count: '100',svg_image:'assets/svg/support_forum_/icons/message_icon.svg',)
                          ],
                        ),
                      ),
                      // comment section ..
                      comment_section()




                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
