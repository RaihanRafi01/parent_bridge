import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parent_bridge/common/app_colors.dart';

import '../../../../../common/custom_font.dart';
import 'comment_profile_details.dart';

class CommentSection extends StatelessWidget {
  const CommentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 362.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: AppColors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Comments",
              style: h4.copyWith(
                fontSize: 16.43,
                color: AppColors.customAnonymousParent_02,
              ),
            ),
            SizedBox(height: 10.h),
            // Avatar Circle
            SizedBox(height: 20.h),

            CommentProfileDetails(),
            SizedBox(height: 10),
            CommentProfileDetails(),
            SizedBox(height: 10),
            CommentProfileDetails(),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
