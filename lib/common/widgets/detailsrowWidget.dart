import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_bridge/common/appColors.dart';


class DetailRowWidget extends StatelessWidget {

  final String title;
  final String value;


  const DetailRowWidget({
    super.key,
    required this.title,
    required this.value,
  });

  @override

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grayborderclr, width: 1.0.w),
        borderRadius: BorderRadius.circular(15),
        //color: Colors.white.withOpacity(0.1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(

            title,
            style: GoogleFonts.lato(color: AppColors.txtclr5, fontSize: 15,fontWeight: FontWeight.w600),
          ),
          Text(

            value,
            style: GoogleFonts.lato(color: AppColors.txtclr5, fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}