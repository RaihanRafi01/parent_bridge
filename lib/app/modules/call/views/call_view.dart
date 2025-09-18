import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_bridge/app/modules/call/views/call_recording.dart';
import 'package:parent_bridge/app/modules/call/views/incoming_ongoing_call.dart';
import 'package:parent_bridge/common/appColors.dart';


import '../../../../common/widgets/CallLogCard.dart';
import '../controllers/call_controller.dart';

class CallView extends GetView<CallController> {
  const CallView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.w), // responsive padding
              child: Row(
                children: [
                  ChoiceChip(

                    label: const Text("All (10)"),
                    selectedColor: const Color(0xFF90CAE2),
                    selected: true,
                    showCheckmark: false,

                    labelStyle: const TextStyle(color: Colors.black),
                  ),
                  SizedBox(width: 8.w),
                  ChoiceChip(
                    // 1.
                    label: Text("Missed (1)"),
                    selected: false,
                    showCheckmark: false,
                    // 2. এখানেও সামঞ্জস্যের জন্য labelStyle যোগ করুন
                    labelStyle: TextStyle(fontSize: 14.sp, color: Colors.black),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w), // responsive padding
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search Calls, Date",
                  prefixIcon: const Icon(Icons.search,color: Colors.grey,size: 30,),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0.r), // responsive radius
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: .5.w, // responsive width
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h), // responsive height
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w), // responsive padding
              child: Text(
                'Recent calls',
                style: GoogleFonts.lato(
                  fontSize: 20.sp, // responsive font size
                  fontWeight: FontWeight.w600,
                  color: AppColors.txtclr5,
                ),
              ),
            ),

            CustomCallCard(
              title: 'Outgoing',
              dateTime: 'Jan 15, 2024 At 2:30 PM',
              duration: '12:45',
              icon: SvgPicture.asset(
                "assets/svg/callu.svg",
                height: 30.h, // responsive height
                width: 30.w, // responsive width
              ),
              iconBackgroundColor: Color(0xFF90CAE2),
              cardBackgroundColor: Colors.lightBlue.shade50,
              onPlayRecording: () {
                Get.to(CallRecording());
              },
            ),
            CustomCallCard(
              title: 'Incoming',
              dateTime: 'Jan 15, 2024 At 2:30 PM',
              duration: '12:45',
              icon: SvgPicture.asset(
                "assets/svg/callu.svg",
                height: 30.h, // responsive height
                width: 30.w, // responsive width
              ),
              iconBackgroundColor: Color(0xFFCB93F3),
              cardBackgroundColor: Colors.purple.shade50,
              onPlayRecording: () {
                Get.to(CallRecording());
              },
            ),
            CustomCallCard(
              title: 'Missed Calls',
              dateTime: 'Jan 15, 2024 At 2:30 PM',
              duration: '12:45',
              icon: SvgPicture.asset(
                "assets/svg/callu.svg",
                height: 30.h, // responsive height
                width: 30.w, // responsive width
              ),
              iconBackgroundColor: Color(0xFFF46668),
              cardBackgroundColor: Colors.red.shade50,
              //onPlayRecording: () {},
            ),
            CustomCallCard(
              title: 'Incoming',
              dateTime: 'Jan 15, 2024 At 2:30 PM',
              duration: '12:45',
              icon: SvgPicture.asset(
                "assets/svg/callu.svg",
                height: 30.h, // responsive height
                width: 30.w, // responsive width
              ),
              iconBackgroundColor: Color(0xFFCB93F3),
              cardBackgroundColor: Colors.purple.shade50,
              onPlayRecording: () {
                Get.to(CallRecording());
              },
            ),
            SizedBox(height: 40.h) // responsive height
          ],
        ),
      ),
    );
  }
}