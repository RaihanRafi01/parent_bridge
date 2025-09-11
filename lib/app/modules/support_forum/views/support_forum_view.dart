import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/support_forum_controller.dart';
import 'common/custom_anonymous_parent.dart';
import 'common/custom_react_comment.dart';

class SupportForumView extends GetView<SupportForumController> {
  const SupportForumView({super.key});

  @override
  Widget build(BuildContext context) {
    final _dropdownControler = Get.put(SupportForumController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // appbar start  ..
            Container(
              height: 145.h,
              width: 440.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color(0xFFBD9DED), const Color(0xFF90CAE2)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.sp),
                  bottomRight: Radius.circular(40.sp),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    /// back button ...
                    IconButton(
                      onPressed: () {
                        // return back ..
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),

                    /// page name and post button  ..
                    Expanded(
                      child: Row(
                        children: [
                          // page name
                          Text(
                            'Support Forum',
                            style: GoogleFonts.lato(
                              fontSize: 24.75.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          // space between two item
                          Spacer(),
                          // post button
                          GestureDetector(
                            // ontap ..
                            onTap: () {
                              print('This is Post button ');
                            },
                            child: Container(
                              width: 74.w,
                              height: 35.16.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.sp),
                                color: Color(0xFFBD9DED),
                              ),
                              child: Center(
                                child: Text(
                                  'Post',
                                  style: GoogleFonts.lato(
                                    fontSize: 18.16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
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
            // appbar ends here ...
            SizedBox(height: 10.h),

            ///body ...
            // search section start ...
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 394.w,
                    height: 46.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFEBEBEB)),
                      borderRadius: BorderRadius.circular(10.96.sp),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color(0xFFBEB4B4),
                        ),
                        border: InputBorder.none,
                        hintStyle: GoogleFonts.lato(color: Color(0xffBEB4B4)),
                      ),
                      style: GoogleFonts.lato(),
                    ),
                  ),
                  // search section end ...
                  SizedBox(height: 15.h),
                  // dropdown section ..
                  Obx(
                    () => Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 145.w,
                          height: 28.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.7.sp,
                              color: Color(0xff93C7E3),
                            ),
                            borderRadius: BorderRadius.circular(8.96.sp),
                          ),
                          child: Center(
                            child: DropdownButton(
                              borderRadius: BorderRadius.circular(10),
                              hint: Row(
                                children: [
                                  Text(
                                    'Select catagory',
                                    style: GoogleFonts.lato(
                                      fontSize: 14.h,
                                      color: Color(0xff93C7E3),
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Color(0xff93C7E3),
                                  ),
                                ],
                              ),
                              value: _dropdownControler.selectedValue.value,
                              items: _dropdownControler.items.map((element) {
                                return DropdownMenuItem<dynamic>(
                                  value: element['name'],
                                  child: Container(
                                    height: 22.h,
                                    decoration: BoxDecoration(
                                      color: element['color'],
                                      borderRadius: BorderRadius.circular(
                                        10.sp,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 7,
                                        left: 7,
                                      ),
                                      child: Text(
                                        element['name'],
                                        style: GoogleFonts.lato(
                                          color: element['fcolor'],
                                          fontSize: 12.9.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  _dropdownControler.setSelected(value);
                                }
                              },
                              icon: const SizedBox.shrink(),
                              underline: SizedBox(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.h),

                  /// anonymous parent part ...
                  custom_anonymous_parent(
                    sche_title: 'Scheduling',
                    color: Color(0xffFFAD13),
                    bg_color: Color(0xffFFFBF3),

                    body_title:
                        'How do you handle holiday scheduling conflicts?',
                    body_subtitle:
                        'My co-parent frequently changes plans at the last minute, which creates a lot of stress and confusion, especially for the children. see more .',
                    ontap: () {},
                  ),

                  SizedBox(height: 20),
                  custom_anonymous_parent(
                    sche_title: 'Parenting',
                    color: Color(0xff1E40AF),
                    bg_color: Color(0xffDEE6FF),

                    body_title: 'Dealing with different parenting styles',
                    body_subtitle:
                        'One ongoing challenge is that my co-parent frequently changes plans at the last minute, which creates instability for both me and the child. Clear and consistent scheduling is important, especially for co-parents .',
                    ontap: () {},
                  ),
                  SizedBox(height: 20),
                  custom_anonymous_parent(
                    sche_title: 'Scheduling',
                    color: Color(0xff089F0A),
                    bg_color: Color(0xffE6FFE7),
                    body_title: 'Success story ,Communication improvement',
                    body_subtitle:
                        'One of our biggest successes as co-parents has been improving our communication. In the beginning, we often misunderstood each other .',
                    ontap: () {},
                  ),
                  SizedBox(height: 20),
                  custom_anonymous_parent(
                    sche_title: 'Scheduling',
                    color: Color(0xffEF4444),
                    bg_color: Color(0xffFFEBEB),
                    body_title: 'The Foundation of Successful Co-Parenting',
                    body_subtitle:
                        'One of our biggest successes as co-parents has been improving our communication. In the beginning, we often misunderstood each other . .',
                    ontap: () {},
                  ),
                  SizedBox(height: 80),
                  
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        
      },child: Icon(Icons.add) , ),
    );
  }
}
