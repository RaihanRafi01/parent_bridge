
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

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
          colors: [const Color(0xFFBD9DED), const Color(0xFF90CAE2)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40.sp),
          bottomRight: Radius.circular(40.sp),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            /// back button ...
            IconButton(
              onPressed: () {
                // return back ..
                Get.back();
              },
              icon: const Icon(Icons.arrow_back),
            ),

            /// page name and post button  ..
            Expanded(
              child: Row(
                children: [
                  // page name
                  Text(
                    'Support Forum',
                    style: GoogleFonts.lato(
                      fontSize: 24.75.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // space between two item
                  Spacer(),
                  // post button
                  GestureDetector(
                    // ontap ..
                    onTap: () {
                      print('This is Post button ');
                    },
                    child: Container(
                      width: 74.w,
                      height: 35.16.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        color: Color(0xFFBD9DED),
                      ),
                      child: Center(
                        child: Text(
                          'Post',
                          style: GoogleFonts.lato(
                            fontSize: 18.16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}