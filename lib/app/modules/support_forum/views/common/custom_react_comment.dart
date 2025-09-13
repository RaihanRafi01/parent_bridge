import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class custom_react_comment extends StatelessWidget {
  const custom_react_comment({super.key, this.svg_image, this.count, this.comment_ontap});

  final String? svg_image;
  final String? count;
  final VoidCallback?comment_ontap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // love react ..
        Container(
          height: 26.85.h,
          width: 74.29.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(875.sp),
            color: Color(0xffffffff),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 3,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               GestureDetector(onTap:comment_ontap,child: SvgPicture.asset('$svg_image')),
              SizedBox(width: 5.sp),
              Text(
                '$count',
                style: GoogleFonts.lato(
                  fontSize: 16.11.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff253240),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
