import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'cmnt_profile_details.dart';

class comment_section extends StatelessWidget {
  const comment_section({super.key});

  @override
  Widget build(BuildContext context) {


    return Container(
      width: 362.w,

         decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),color: Colors.white),
         child:  Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Comments",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // Avatar Circle
           SizedBox(height: 20.h),

              cmt_profile_details(),
               SizedBox(height: 10),
              cmt_profile_details(),
               SizedBox(height: 10),
              cmt_profile_details(),
               SizedBox(height: 10),


            ]
          )
        )
    );
  }
}


