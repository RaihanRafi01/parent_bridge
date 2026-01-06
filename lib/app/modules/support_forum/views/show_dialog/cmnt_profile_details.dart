import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:parent_bridge/common/appColors.dart';
import 'package:parent_bridge/common/customFont.dart';

import '../reply_section/reply_page.dart';

class cmt_profile_details extends StatelessWidget {
  const cmt_profile_details({
    super.key,
    required this.name,
    required this.message,
    required this.time,
    this.image,
    required this.postId,
    required this.commentId,
    required this.color,
    this.replies = const [],
  });

  final String name;
  final String message;
  final String time;
  final String? image;
  final int postId;
  final int commentId;
  final Color color;
  final List<dynamic> replies;

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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: image != null && image!.isNotEmpty
                ? Image.network(
                    image!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Center(
                      child: Text(
                        name.isNotEmpty ? name[0].toUpperCase() : "A",
                        style: h2.copyWith(
                          color: AppColors.darkSlateBlue,
                          fontSize: 16.58.sp,
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Text(
                      name.isNotEmpty ? name[0].toUpperCase() : "A",
                      style: h2.copyWith(
                        color: AppColors.darkSlateBlue,
                        fontSize: 16.58.sp,
                      ),
                    ),
                  ),
          ),
        ),
        SizedBox(width: 15),

        // Comment details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name
              Text(
                name,
                style: h2.copyWith(
                  color: AppColors.custom_anonymous_parent_02,
                  fontSize: 16.43.sp,
                ),
              ),
              const SizedBox(height: 3),

              // Comment text
              Text(
                message,
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
                    time,
                    style: h4.copyWith(
                      fontSize: 11.5.sp,
                      color: AppColors.show_dialog_with_Comment_02,
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      Get.dialog(
                        reply_page(
                          color: color,
                          postId: postId,
                          commentId: commentId,
                          originalComment: {
                            'name': name,
                            'message': message,
                            'time': time,
                            'image': image,
                            'replies': replies,
                          },
                        ),
                        barrierColor: AppColors.post_page_01.withOpacity(0.6),
                      );
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
        ),
      ],
    );
  }
}
