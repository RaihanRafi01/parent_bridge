import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:parent_bridge/app/modules/support_forum/views/show_dialog/cmnt_profile_details.dart';
import '../../../../../common/appColors.dart';
import '../../../../../common/customFont.dart';
import '../../controllers/support_forum_controller.dart';

class reply_page extends StatelessWidget {
  const reply_page({
    super.key,
    required this.color,
    required this.postId,
    required this.commentId,
    required this.originalComment,
  });

  final Color color;
  final int postId;
  final int commentId;
  final Map<String, dynamic> originalComment;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SupportForumController>();
    final TextEditingController replyController = TextEditingController();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Container(
        width: 387.w,
        height: 600.h,
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Header   ...
              Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsGeometry.all(10.r),
                  child: Row(
                    children: [
                      // back button ..
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: SvgPicture.asset(
                          'assets/svg/support_forum_/icons/back.svg',
                        ),
                      ),

                      SizedBox(width: 90),

                      // text logo ..
                      Center(
                        child: Text(
                          'Reply',
                          style: h2.copyWith(
                            fontSize: 20.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  color: Color(0xffFFFBF3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      cmt_profile_details(
                        name: originalComment['name'] ?? "Anonymous Parent",
                        message: originalComment['message'] ?? "",
                        time: originalComment['time'] ?? "",
                        image: originalComment['image'],
                        postId: postId,
                        commentId: commentId,
                        color: color,
                      ),

                      SizedBox(height: 12.h),

                      // Replies list (if any)
                      Obx(() {
                        final comment = controller.comments.firstWhere(
                          (c) => c['id'] == commentId,
                          orElse: () => originalComment,
                        );

                        final List<dynamic> replies = comment['replies'] ?? [];
                        if (replies.isEmpty) {
                          return SizedBox.shrink();
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Replies',
                                style: h4.copyWith(
                                  fontSize: 14.sp,
                                  color: AppColors.custom_anonymous_parent_02,
                                ),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Column(
                              children: replies.map<Widget>((r) {
                                final rUser = r['comment_user'] ?? {};
                                final rName =
                                    rUser['name'] ??
                                    rUser['username'] ??
                                    'Anonymous';
                                final rMsg = r['message'] ?? '';
                                final rTime =
                                    r['time_since_commented'] ??
                                    r['created_at'] ??
                                    '';

                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 10.h,
                                    left: 20.w,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 30.h,
                                        width: 30.w,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.clrBlack
                                                  .withOpacity(0.5),
                                              blurRadius: 3,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          child:
                                              rUser['image'] != null &&
                                                  (rUser['image'] as String)
                                                      .isNotEmpty
                                              ? Image.network(
                                                  rUser['image'],
                                                  fit: BoxFit.cover,
                                                  errorBuilder:
                                                      (
                                                        context,
                                                        error,
                                                        stackTrace,
                                                      ) => Center(
                                                        child: Text(
                                                          rName.isNotEmpty
                                                              ? rName[0]
                                                                    .toUpperCase()
                                                              : 'A',
                                                          style: h2.copyWith(
                                                            color: AppColors
                                                                .darkSlateBlue,
                                                            fontSize: 14.sp,
                                                          ),
                                                        ),
                                                      ),
                                                )
                                              : Center(
                                                  child: Text(
                                                    rName.isNotEmpty
                                                        ? rName[0].toUpperCase()
                                                        : 'A',
                                                    style: h2.copyWith(
                                                      color: AppColors
                                                          .darkSlateBlue,
                                                      fontSize: 14.sp,
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              rName,
                                              style: h2.copyWith(
                                                color: AppColors
                                                    .custom_anonymous_parent_02,
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                            SizedBox(height: 4.h),
                                            Text(
                                              rMsg,
                                              style: h4.copyWith(
                                                fontSize: 12.sp,
                                                color: AppColors
                                                    .show_dialog_with_Comment_01,
                                              ),
                                            ),
                                            SizedBox(height: 4.h),
                                            Text(
                                              rTime,
                                              style: h4.copyWith(
                                                fontSize: 11.sp,
                                                color: AppColors
                                                    .show_dialog_with_Comment_02,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 12.h),
                          ],
                        );
                      }),

                      // this is message type and sent section ...
                      SizedBox(
                        height: 43.h,
                        width: 349.w,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 43.h,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: color.withOpacity(
                                      0.5,
                                    ), // the problem is here
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(100.r),
                                  ),
                                  color: color.withOpacity(0.1),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 12.0,
                                    right: 15,
                                    left: 20,
                                  ),
                                  child: TextField(
                                    controller: replyController,
                                    decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: ' Type here ..',
                                      hintStyle: h4.copyWith(
                                        fontSize: 12.sp,
                                        color: AppColors.reply_msg_1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // sent button ..
                            Obx(() {
                              final isReplying = controller.isReplying.value;
                              return GestureDetector(
                                onTap: isReplying
                                    ? null
                                    : () async {
                                        final text = replyController.text
                                            .trim();
                                        if (text.isEmpty) return;
                                        final success = await controller
                                            .postReply(postId, commentId, text);
                                        if (success) {
                                          replyController.clear();
                                          // Optionally scroll to bottom or focus
                                        }
                                      },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: isReplying
                                      ? SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation(
                                              color,
                                            ),
                                          ),
                                        )
                                      : SvgPicture.asset(
                                          'assets/svg/support_forum_/icons/sent.svg',
                                          color: color,
                                        ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
