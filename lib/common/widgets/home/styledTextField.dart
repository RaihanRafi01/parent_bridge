import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../appColors.dart';

// আপনার typography ফাইল থেকে h2 এবং h3 ইম্পোর্ট করুন
// import 'package:your_project/path/to/your/typography_file.dart';

class StyledTextField extends StatelessWidget {
  final String label;
  final String svgAsset;
  final BoxDecoration decoration;
  final TextEditingController? controller;
  final String? initialValue;
  final bool isPassword;
  final bool readOnly;
  final TextInputType keyboardType;

  const StyledTextField({
    super.key,
    required this.label,
    required this.svgAsset,
    required this.decoration,
    this.controller,
    this.initialValue,
    this.isPassword = false,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    // এখানে h2 এবং h3 ব্যবহার করা হয়েছে, নিশ্চিত করুন যে এগুলো আপনার প্রজেক্টে ডিফাইন করা আছে
    final h2 = TextStyle(fontWeight: FontWeight.w600); // Placeholder
    final h3 = TextStyle(fontWeight: FontWeight.w500); // Placeholder

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            label,
            style: h2.copyWith(
              fontSize: 18.sp,
              color: AppColors.darkSlateBlue,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: decoration,
          child: TextFormField(
            controller: controller,
            initialValue: initialValue,
            readOnly: readOnly,
            obscureText: isPassword,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                child: SvgPicture.asset(svgAsset),
              ),
              suffixIcon: isPassword
                  ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SvgPicture.asset(
                  'assets/images/profile/invisible_pass.svg',
                  fit: BoxFit.scaleDown,
                ),
              )
                  : null,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 16.h),
            ),
            style: h3.copyWith(fontSize: 16.sp, color: AppColors.gray2),
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}