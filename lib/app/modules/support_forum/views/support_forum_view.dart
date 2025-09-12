
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parent_bridge/app/modules/support_forum/views/support_forum/search_part.dart';
import '../controllers/support_forum_controller.dart';
import 'common/custom_floating_button.dart';
import 'support_forum/anonymous_parent_part.dart';
import 'support_forum/app_bar_section.dart';
import 'package:google_fonts/google_fonts.dart';

class SupportForumView extends GetView<SupportForumController> {
  const SupportForumView({super.key});

  @override
  Widget build(BuildContext context) {
    final dropdown_Controler = Get.put(SupportForumController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // appbar start  ..
            app_bar_section(),

            SizedBox(height: 10.h),

            ///body ...
            Padding(
              padding: const EdgeInsets.all(15),
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
                          value: dropdown_Controler.selectedValue.value,
                          items: dropdown_Controler.items.map((element) {
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
                              dropdown_Controler.setSelected(value);
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
                  // space
                  SizedBox(height: 15.h),
                  // anonymous parent ..
                  anonymous_parent_section(),
                  // space
                  SizedBox(height: 130),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Custom_floating_button(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
