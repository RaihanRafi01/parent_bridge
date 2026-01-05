import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parent_bridge/app/modules/support_forum/views/show_dialog/show_dialog_page.dart';
import 'package:parent_bridge/app/modules/support_forum/views/support_forum/search_part.dart';
import 'package:parent_bridge/common/appColors.dart';
import 'package:parent_bridge/common/customFont.dart';
import '../../../../common/widgets/nav/circularMenuWidget.dart';
import '../controllers/support_forum_controller.dart';
import 'common/custom_anonymous_parent.dart';
import 'support_forum/app_bar_section.dart';

class SupportForumView extends GetView<SupportForumController> {
  const SupportForumView({super.key});

  @override
  Widget build(BuildContext context) {
    final dropdownControler = Get.put(SupportForumController());
    return Scaffold(
      body: Column(
        children: [
          // appbar start  ..
          app_bar_section(),
          //space
          SizedBox(height: 10.h),

          ///body ...
          Padding(
            padding: EdgeInsets.all(15.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // search part
                search_partl(),
                // space
                SizedBox(height: 15.h),
                // dropdown section ..
                Obx(
                  () => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 140.w,
                        height: 28.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 0.7.w,
                            color: AppColors.support_forum_view_blue01,
                          ),
                          borderRadius: BorderRadius.circular(8.96.r),
                        ),
                        child: Center(
                          child: DropdownButton(
                            borderRadius: BorderRadius.circular(10.r),
                            hint: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 5.r),
                                  child: Text(
                                    'Select catagory',
                                    style: h4.copyWith(
                                      fontSize: 14.sp,
                                      color:
                                          AppColors.support_forum_view_blue01,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: AppColors.support_forum_view_blue01,
                                ),
                              ],
                            ),
                            value: dropdownControler.selectedValue.value,
                            items: dropdownControler.items.map((element) {
                              return DropdownMenuItem<dynamic>(
                                value: element['name'],
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                  ),
                                  height: 22.h,
                                  decoration: BoxDecoration(
                                    color: element['color'],
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Text(
                                    element['name'],
                                    style: h4.copyWith(
                                      color: element['fcolor'],
                                      fontSize: 12.9.sp,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                dropdownControler.setSelected(value);
                              }
                            },
                            isExpanded: true,
                            icon: SizedBox.shrink(),
                            underline: SizedBox(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // space ...
                SizedBox(height: 15.h),
                // anonymous parents ...
              ],
            ),
          ),
          //anonymous parent section ...
          Expanded(
            child: Obx(() {
              // filter posts based on selected category
              final filteredPosts =
                  dropdownControler.selectedCategory.value == null
                  ? dropdownControler.posts
                  : dropdownControler.posts
                        .where(
                          (post) =>
                              post['sche_title'] ==
                              dropdownControler.selectedCategory.value,
                        )
                        .toList();

              return SingleChildScrollView(
                child: Column(
                  children: [
                    for (dynamic post in filteredPosts)
                      custom_anonymous_parent(
                        sche_title: post['sche_title'],
                        color: post['color'],
                        bg_color: post['bg_color'],
                        body_title: post['body_title'],
                        body_subtitle: post['body_subtitle'],
                        // three dot button ..
                        threeDot_ontap: () {},
                        // this is see more button ...
                        dialog_ontap: () {
                          Get.dialog(
                            show_dialog(
                              color: post['color'],
                              body_title: post['body_title'],
                              dialog_subtitle: post['dialog_subtitle'],
                            ),
                            barrierColor: AppColors.anonymous_parent_03
                                .withOpacity(.6),
                          );
                        },
                      ),
                    SizedBox(height: 130.h),
                  ],
                ),
              );
            }),
          ),
          // space
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CircularMenuWidget(homeScreenIndex: 9),
    );
  }
}
