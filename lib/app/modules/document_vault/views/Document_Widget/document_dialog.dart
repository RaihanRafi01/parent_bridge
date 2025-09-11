import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Document_dialog extends StatelessWidget {
  const Document_dialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Container(
        width: 390.w,
        height: 531.h,
        // padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// 🔹 Header
            Container(
              height: 67.89.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: const Color(0xFF68B961),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "School Emergency Contact Form",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  InkWell(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
            ),

            SizedBox(height: 2.h),

            /// 🔹 Buttons Row (Preview, Details)
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                color: Color(0xFFEEFEED),
                height: 65.h,
                width: 355.w,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.remove_red_eye,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "Preview",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF68B961),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.description,
                            color: Color(0xFF68B961),
                          ),
                          label: const Text(
                            "Details",
                            style: TextStyle(color: Color(0xFF68B961)),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFF68B961)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 0.h),

            /// 🔹 User Info + Tag
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: [
                  const Icon(Icons.person_outline, color: Colors.black54),
                  SizedBox(width: 8.w),
                  const Text(
                    "Michael",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF68B961),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: const Text(
                      "School",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 2.h),

            /// 🔹 File Info
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Uploaded • 2024-12-10"),
                    Text(
                      "Expires • 2024-12-10",
                      style: TextStyle(color: Colors.red),
                    ),
                    Text("File Type • Image"),
                    Text("File Size • 856 KB"),
                  ],
                ),
              ),
            ),

            SizedBox(height: 2.h),

            /// 🔹 Description Box
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                height: 88.h,
                width: 347.w,
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFDEFDDB),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: Text(
                    "Emergency Contact Information Form For Emma's School Including Medical Conditions And Authorized",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ),

            SizedBox(height: 2.h),

            /// 🔹 Footer buttons
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 28.87.h,
                    width: 101.73.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/document_svg/edit.svg',
                          width: 18.w, // smaller so it fits well
                          height: 18.h,
                          colorFilter: ColorFilter.mode(
                            Color(0xFF000000),
                            BlendMode.srcIn,
                          ),
                        ),
                        Text(
                          "Edit",
                          style: TextStyle(
                            height: .6,
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 28.87.h,
                    width: 101.73.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/document_svg/download.svg',
                          width: 18.w, // smaller so it fits well
                          height: 18.h,
                          colorFilter: ColorFilter.mode(
                            Color(0xFF000000),
                            BlendMode.srcIn,
                          ),
                        ),
                        Text(
                          "Download",
                          style: TextStyle(
                            height: .6,
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 28.87.h,
                    width: 101.73.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      border: Border.all(color: Colors.red),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/document_svg/delete.svg',
                          width: 18.w, // smaller so it fits well
                          height: 18.h,
                          colorFilter: ColorFilter.mode(
                            Colors.red,
                            BlendMode.srcIn,
                          ),
                        ),
                        Text(
                          "Delete",
                          style: TextStyle(
                            height: .6,
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ],
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
