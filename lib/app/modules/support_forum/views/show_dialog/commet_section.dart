import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parent_bridge/app/modules/support_forum/controllers/support_forum_controller.dart';
import 'package:parent_bridge/common/appColors.dart';

import '../../../../../common/customFont.dart';
import 'cmnt_profile_details.dart';

class comment_section extends StatelessWidget {
  const comment_section({super.key, required this.postId, required this.color});

  final int postId;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SupportForumController>();

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
                color: AppColors.custom_anonymous_parent_02,
              ),
            ),
            SizedBox(height: 10.h),
            Obx(() {
              if (controller.isCommentsLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              if (controller.comments.isEmpty) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Center(
                    child: Text(
                      "No comments yet",
                      style: h4.copyWith(color: AppColors.textColorHint),
                    ),
                  ),
                );
              }

              // Filter to show only top-level comments (reply_to == null)
              final topLevelComments = controller.comments
                  .where((c) => c['reply_to'] == null)
                  .toList();

              return Column(
                children: topLevelComments.map((comment) {
                  final user = comment['comment_user'] ?? {};
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: cmt_profile_details(
                      name: user['name'] ?? user['username'] ?? "Anonymous",
                      message: comment['message'] ?? "",
                      time: comment['time_since_commented'] ?? "",
                      image: user['image'],
                      postId: postId,
                      commentId: comment['id'],
                      color: color,
                      replies: comment['replies'] ?? [],
                    ),
                  );
                }).toList(),
              );
            }),
          ],
        ),
      ),
    );
  }
}
