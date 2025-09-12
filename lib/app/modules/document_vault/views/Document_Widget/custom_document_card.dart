import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_document_dialog.dart';

class DocumentCard extends StatelessWidget {
  const DocumentCard({
    super.key,
    required this.title,
    required this.label,
    required this.date,
    required this.type,

    required this.person,

    required this.labelcontainer,
    required this.bgcolor,
    required this.sidebar,
    this.exp_date,
    required this.onTap,
  });

  final String title;
  final String label;
  final String date;
  final String type;
  final String? exp_date;
  final Color labelcontainer;
  final Color bgcolor;
  final Color sidebar;
  final VoidCallback onTap;
  final String person;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 399.w,
      height: 176.h, //change
      decoration: BoxDecoration(
        color: bgcolor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2.r,
            blurRadius: 5.r,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left red bar
          Container(
            width: 8.w,
            height: 166.h,
            decoration: BoxDecoration(
              color: sidebar,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                bottomLeft: Radius.circular(16.r),
              ),
            ),
          ),
          SizedBox(width: 12.w, height: 166.h),
          // Right content
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title + Download button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: GoogleFonts.lato(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1D3856),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      InkWell(
                        onTap: onTap,
                        child: Container(
                          width: 41.w,
                          height: 33.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(5.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 2.r,
                                blurRadius: 5.r,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(5.0.r),
                            child: SvgPicture.asset(
                              'assets/images/document_svg/download.svg',
                              height: 2.h,
                              width: 2.w,
                              colorFilter: ColorFilter.mode(
                                Color(0xFF93C7E3),
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),

                  // Legal tag
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.r,
                      vertical: 4.r,
                    ),
                    decoration: BoxDecoration(
                      color: labelcontainer,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      label,
                      style: GoogleFonts.lato(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),

                  // People
                  Row(
                    children: [
                      SizedBox(
                        width: 12.w,
                        height: 12.h,
                        child: SvgPicture.asset(
                          'assets/images/document_svg/people.svg',

                          colorFilter: ColorFilter.mode(
                            Color(0xFF666666),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        person,
                        style: GoogleFonts.lato(color: Color(0xFF666666)),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),

                  // Upload date + file type
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Uploaded • ',

                            style: GoogleFonts.lato(
                              fontSize: 12.sp, // responsive font size
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1D3856),
                            ),
                          ),
                          Text(
                            date,

                            style: GoogleFonts.lato(
                              fontSize: 12.52.sp, // responsive font size
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF1D3856),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: .6.h),
                      Row(
                        children: [
                          Text(
                            'File Type • ',

                            style: GoogleFonts.lato(
                              fontSize: 12.52.sp, // responsive font size
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF1D3856),
                            ),
                          ),
                          Text(
                            type,

                            style: GoogleFonts.lato(
                              fontSize: 12.52.sp, // responsive font size
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF1D3856),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: .6.h),
                      Text(
                        exp_date!,

                        style: GoogleFonts.lato(
                          fontSize: 12.52.sp, // responsive font size
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFFBA0306),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
