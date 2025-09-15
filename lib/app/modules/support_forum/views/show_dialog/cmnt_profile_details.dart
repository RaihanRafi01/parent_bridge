import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:parent_bridge/common/appColors.dart';
import 'package:parent_bridge/common/customFont.dart';

class cmt_profile_details extends StatelessWidget {
  const cmt_profile_details({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Container(
          height: 34.h,
          width: 34.w,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.clrBlack.withOpacity(0.5),
                blurRadius: 3,
                offset: Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              "AP",
              style: h2.copyWith(
                color: AppColors.darkSlateBlue,
                fontSize: 16.58.sp,
              ),
            ),
          ),
        ),
        SizedBox(width: 15),

        // Comment details
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name
            Text(
              'Pronoy Sarkar',
              style: h2.copyWith(
                color: AppColors.custom_anonymous_parent_02,
                fontSize: 16.43.sp,
              ),
            ),
            const SizedBox(height: 3),

            // Comment text
            Text(
              "I am a Flutter App Devoloper \nfrom Noakhali ",
              style: h4.copyWith(
                fontSize: 13.14.sp,
                color: AppColors.show_dialog_with_Comment_01,
              ),
            ),
            const SizedBox(height: 5),

            // Time + Reply
            Row(
              children: [
                Text(
                  "3h",
                  style: h4.copyWith(
                    fontSize: 11.5.sp,
                    color: AppColors.show_dialog_with_Comment_02,
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    // handle reply
                  },
                  child: Text(
                    "Reply",
                    style: h4.copyWith(
                      fontSize: 11.5.sp,
                      color: AppColors.show_dialog_with_Comment_02,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
