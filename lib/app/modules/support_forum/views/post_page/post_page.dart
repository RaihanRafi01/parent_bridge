import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:parent_bridge/app/modules/support_forum/controllers/post_page_controller.dart';

import '../../../../../common/appColors.dart';
import '../../../../../common/customFont.dart';

class post_page extends StatelessWidget {
  const post_page({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PostPageController());
    return Scaffold(
      body: SingleChildScrollView(
        //  Added scroll
        child: Column(
          children: [
            // header ..
            Container(
              height: 147.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.post_page_01, AppColors.post_page_02],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.r),
                  bottomRight: Radius.circular(40.r),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: Get.back,
                      child: SvgPicture.asset(
                        'assets/images/common/back_icon.svg',
                        width: 40.w,
                      ),
                    ),
                    Text(
                      "New Post",
                      style: h2.copyWith(
                        fontSize: 24.47.sp,
                        color: AppColors.textColor7,
                      ),
                    ),
                    SizedBox(width: 40.w),
                  ],
                ),
              ),
            ),

            SizedBox(height: 30.h),

            SizedBox(
              height: 750.h,
              width: 383.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  // 🔹 Title Input
                  Center(
                    child: Container(
                      height: 56.h,
                      width: 382.73.w,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.btnBorder,
                          width: 1.0.w,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.post_page_03.withOpacity(0.1.r),
                            spreadRadius: 1.r,
                            blurRadius: 6.r,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        color: AppColors.textInputFillColor,
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: TextField(
                          controller: controller.titleController,
                          decoration: InputDecoration(
                            hintText: 'Enter Title',
                            hintStyle: h4.copyWith(
                              color: AppColors.textColorHint,
                              fontSize: 14.sp,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 30.h),

                  // 🔹 Category field (fake dropdown look)
                  GestureDetector(
                    onTap: () {
                      Get.bottomSheet(
                        Container(
                          color: Colors.white,
                          child: Wrap(
                            children: controller.categories
                                .map((category) => ListTile(
                                      title: Text(category.capitalizeFirst!),
                                      onTap: () {
                                        controller.selectedCategory.value =
                                            category;
                                        Get.back();
                                      },
                                    ))
                                .toList(),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 56.h,
                      width: 382.73.w,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.btnBorder,
                          width: 1.0.w,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.post_page_03.withOpacity(.2),
                            spreadRadius: 1.r,
                            blurRadius: 6.r,
                            offset: Offset(0, 3),
                          ),
                        ],
                        color: AppColors.textInputFillColor,
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(() => Text(
                                  controller.selectedCategory.value != null
                                      ? controller.selectedCategory.value!
                                          .capitalizeFirst!
                                      : 'Select Category',
                                  style: h4.copyWith(
                                    color: controller.selectedCategory.value !=
                                            null
                                        ? Colors.black
                                        : AppColors.textColorHint,
                                    fontSize: 14.sp,
                                  ),
                                )),
                            Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: AppColors.textColorHint,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 30.h),

                  // 🔹 Description
                  Container(
                    height: 94.h,
                    width: 383.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.btnBorder,
                        width: 1.0.w,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.post_page_03.withOpacity(0.2.r),
                          spreadRadius: 1.r,
                          blurRadius: 6.r,
                          offset: const Offset(0, 5),
                        ),
                      ],
                      color: AppColors.textInputFillColor,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 25.r, top: 10.r),
                      child: TextField(
                        controller: controller.descriptionController,
                        maxLines: null,
                        expands: true,

                        decoration: InputDecoration(
                          hintText:
                              'Share your thoughts, questions, or experiences',
                          hintStyle: h4.copyWith(
                            color: AppColors.textColorHint,
                            fontSize: 14.sp,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 50.h),

                  // Post  Button
                  SizedBox(
                    width: double.infinity,
                    height: 52.h,

                    child: Obx(() => InkWell(
                          onTap: controller.isLoading.value
                              ? null
                              : () {
                                  controller.createPost();
                                },
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.btnBorder),
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.appColor2,
                                  AppColors.appColor
                                ],
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                              ),

                              borderRadius: BorderRadius.circular(100.r),
                            ),
                            child: Center(
                              child: controller.isLoading.value
                                  ? CircularProgressIndicator(
                                      color: AppColors.clrWhite)
                                  : Text(
                                      'Post Anonymously',
                                      style: h1.copyWith(
                                        color: AppColors.clrWhite,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                            ),
                          ),
                        )),
                  ),

                  SizedBox(height: 80.h),

                  // Text ..
                  Container(
                    width: double.infinity,
                    height: 86.h,
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFD9FF), // light purple background
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.post_page_03.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Remember: ",
                            style: h3.copyWith(
                              // your custom font
                              color: AppColors.post_page_04,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp,
                            ),
                          ),
                          TextSpan(
                            text:
                                "All Posts Are Anonymous And Your Co-Parent Cannot See Your Contributions To Maintain \nPrivacy.",
                            style: h4.copyWith(
                              color: AppColors.post_page_04,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
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
