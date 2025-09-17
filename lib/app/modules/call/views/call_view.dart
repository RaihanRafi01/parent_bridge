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
            Container(
              height: 187.h, // responsive height
              padding: EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w), // responsive padding
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Color(0xFFCB93F2), Color(0xFF89C5E1)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.r), // responsive radius
                  bottomRight: Radius.circular(40.r), // responsive radius
                ),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: Get.back,
                    child: SvgPicture.asset('assets/images/common/back_icon.svg'),
                  ),
                  SizedBox(width: 12.w), // responsive width
                  CircleAvatar(
                    backgroundImage: const AssetImage("assets/images/auth/img.png"),
                    radius: 28.r, // responsive radius
                  ),
                  SizedBox(width: 10.w), // responsive width
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 30.h), // responsive height
                        Text("Michael",
                            style: GoogleFonts.lato(
                                fontSize: 24.47.sp, // responsive font size
                                fontWeight: FontWeight.w600,
                                color: AppColors.txtclr5)),
                        Row(
                          children: [
                            Icon(Icons.circle,
                                color: const Color(0xFF14F269), size: 10.r), // responsive size
                            SizedBox(width: 5.w), // responsive width
                            Text("Online Now",
                                style: GoogleFonts.lato(
                                    fontSize: 12.23.sp, // responsive font size
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF474747))),
                          ],
                        ),
                        SizedBox(height: 5.83.h), // responsive height
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/svg/call3.svg",
                              height: 15.h, // responsive height
                              width: 15.w, // responsive width
                            ),
                            Text("(555) 123-4567",
                                style: GoogleFonts.lato(
                                    fontSize: 13.77.sp, // responsive font size
                                    fontWeight: FontWeight.w600,
                                    color:  AppColors.txtclr5)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.to(IncomingOngoingCallView());
                    },
                    icon: SvgPicture.asset(
                      "assets/svg/call2.svg",
                      height: 25.h, // responsive height
                      width: 25.w, // responsive width
                    ),
                    label: Text("Call Now",
                        style: GoogleFonts.lato(
                            fontSize: 18.sp, // responsive font size
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h), // responsive padding
                      backgroundColor: const Color(0xFFE971DD),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.r), // responsive radius
                      ),
                    ),
                  ),
                ],
              ),
            ),
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