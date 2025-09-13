import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class search_partl extends StatelessWidget {
  const search_partl({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 394.w,
      height: 46.h,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFEBEBEB)),
        borderRadius: BorderRadius.circular(10.96.sp),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xFFBEB4B4),
          ),
          border: InputBorder.none,
          hintStyle: GoogleFonts.lato(color: Color(0xffBEB4B4)),
        ),
        style: GoogleFonts.lato(),
      ),
    );
  }
}