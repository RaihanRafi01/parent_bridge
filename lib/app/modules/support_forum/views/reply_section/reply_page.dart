import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:parent_bridge/app/modules/support_forum/views/show_dialog/cmnt_profile_details.dart';
import '../../../../../common/appColors.dart';
import '../../../../../common/customFont.dart';
class reply_page extends StatelessWidget {
  const reply_page({super.key, required this.color });

  final Color color;


  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: SizedBox(
          width: 387.w,
          height: 750.h,
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
                      SizedBox(height: 30),
                      cmt_profile_details(),

                      SizedBox(height: 435),

                      // this is message type and sent section ...
                      SizedBox(
                        height: 43.h,
                        width: 349.w,
                        child: Row(
                          children: [
                            Container(
                              width: 270,
                              height: 43,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: color.withOpacity(0.5), // the problem is here
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
                            // sent button ..
                            GestureDetector(
                              onTap: () {

                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: SvgPicture.asset(
                                  'assets/svg/support_forum_/icons/sent.svg',
                                  color: color,
                                ),
                              ),
                            ),
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
