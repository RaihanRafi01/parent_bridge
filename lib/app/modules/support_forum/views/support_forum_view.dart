import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/support_forum_controller.dart';

class SupportForumView extends GetView<SupportForumController> {
  const SupportForumView({super.key});
  @override
  Widget build(BuildContext context) {
    final _dropdownControler = Get.put(SupportForumController());
    return Scaffold(
      body: Column(
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
                          onTap: () {},
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
                  prefixIcon: Icon(Icons.search, color: Color(0xFFBEB4B4)),
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
              ()=> DropdownButton(
                
                value: _dropdownControler.selectedValue.value,
                items: _dropdownControler.items.map((String element) {
                  return DropdownMenuItem<String>(
                    value: element,
                    child: Text(element),
                  );
                }).toList(),
                onChanged: (value) {
                  if(value!=null){
                    _dropdownControler.setSelected(value);
                  }
                },
              ),
            ),
            ],
          ),
        )
        ],
      ),
    );
  }
}
