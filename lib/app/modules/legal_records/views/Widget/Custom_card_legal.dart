import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_bridge/common/appColors.dart';
import '../../../../../common/customFont.dart';

class DocumentCardLegal extends StatelessWidget {
  const DocumentCardLegal({
    super.key,
    required this.title,
    required this.text,
    required this.image,
    required this.color,
    required this.color2,
  });

  final String title;
  final String text;

  final String image;
  final Color color;
  final Color color2;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 399.w,
      height: 212.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.customGrey.withOpacity(0.1),
            spreadRadius: 2.r,
            blurRadius: 5.r,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 12.w,
            height: 212.h,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                bottomLeft: Radius.circular(16.r),
              ),
            ),
          ),
          SizedBox(width: 15.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.h),
              Row(
                children: [
                  Container(
                    width: 40.w,
                    height: 40.h,
                    child: Image.asset(image),
                  ),
                  SizedBox(width: 10.h),
                  Text(
                    title,
                    style: h1.copyWith(
                      fontSize: 22,
                      color: AppColors.legalText,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Container(
                width: 342.w,
                height: 72.h,
                child: Text(
                  text,
                  style: h4.copyWith(fontSize: 10, color: AppColors.customGrey),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                width: 108.w,
                height: 32.h,
                decoration: BoxDecoration(
                  color: AppColors.legalButton,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Container(
                  width: 12.w,
                  height: 212.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16.r),
                      bottomRight: Radius.circular(16.r),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 5.w),
                      Container(
                        width: 16.w,
                        height: 16.h,
                        child: Image.asset(
                          "assets/images/document_svg/pdf.png",
                        ),
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        'Download',
                        style: h3.copyWith(
                          fontSize: 10,
                          color: AppColors.clrBlack,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          Container(
            width: 12.w,
            height: 212.h,
            decoration: BoxDecoration(
              color: color2,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16.r),
                bottomRight: Radius.circular(16.r),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
