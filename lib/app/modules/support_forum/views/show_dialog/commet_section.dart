import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_bridge/common/appColors.dart';

import '../../../../../common/customFont.dart';
import 'cmnt_profile_details.dart';

class comment_section extends StatelessWidget {
  const comment_section({super.key});

  @override
  Widget build(BuildContext context) {


    return Container(
      width: 362.w,
         decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),color: AppColors.white),
         child:  Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Comments",
                style: h4.copyWith(
                  fontSize: 16.43,
                  color: AppColors.custom_anonymous_parent_02
                ),
              ),
                SizedBox(height: 10.h),
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


