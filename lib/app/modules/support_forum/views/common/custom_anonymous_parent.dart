import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_react_comment.dart';

class custom_anonymous_parent extends StatelessWidget {
  const custom_anonymous_parent({
    super.key,
    this.color,
    this.sche_title,
    this.ontap,
    this.body_title,
    this.body_subtitle, this.bg_color,
  });

  final Color? color;
  final Color? bg_color;
  final String? sche_title;
  final String? body_title;
  final String? body_subtitle;
  final VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 394.w,
      height: 310.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: bg_color,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
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
                      borderRadius: BorderRadius.circular(1000),
                      color: Color(0xffffffff),
                    ),
                    child: Center(
                      child: Text(
                        'AP',
                        style: GoogleFonts.lato(
                          fontSize: 18.16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  // space ..
                  SizedBox(width: 15),
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
                          SizedBox(width: 25),

                          // scheduling part...
                          Container(
                            width: 72.w,
                            height: 22.w,
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(850.75.sp),
                            ),
                            child: Center(
                              child: Text(
                                '$sche_title',
                                style: GoogleFonts.lato(
                                  fontSize: 11.91.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 30),
                          // three dot ...
                          GestureDetector(
                            onTap: ontap,
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
                        style: GoogleFonts.lato(
                          fontSize: 14.32.sp,
                          fontWeight: FontWeight.w400,
                        ),
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
              children: [
                // body title text ..
                Text(
                  "$body_title",
                  style: GoogleFonts.lato(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                SizedBox(height: 10),
                // body part ...
                GestureDetector(
                  onTap: () {

                  },
                  child: RichText(
                    text: TextSpan(
                      text: "$body_subtitle",
                      style: GoogleFonts.lato(
                        fontSize: 14.32.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff253240),
                      ),
                      children: [
                        TextSpan(
                          text: ' See More',
                          style: GoogleFonts.lato(
                            fontSize: 14.32.sp,
                            fontWeight: FontWeight.w600,
                            color: color,
                          ),
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