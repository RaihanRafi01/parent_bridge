import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common/appColors.dart';
import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(padding: EdgeInsetsGeometry.all(10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Get.back();

            },
            child: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.black,
              size: 28,
            ),
          ),
          Text(
            'Subscription',
            style: GoogleFonts.lato(
              fontSize: 28.sp,
              fontWeight: FontWeight.w600,
                color: AppColors.txtclr5,
            ),
          ),
          SizedBox(width: 28),
        ],
      ),



      )
    );
  }
}
