import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // <-- প্যাকেজটি ইম্পোর্ট করুন
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_bridge/app/modules/call/views/call_view.dart';

class OngoingCall extends StatelessWidget {
  const OngoingCall({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFBD9DED), Color(0xFF90CAE2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [ // Removed MainAxisAlignment
            // Back Button
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 40.h, left: 16.w), // Responsive padding
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
            ),
            SizedBox(height: 60.h), // Responsive height

            // Profile Image
            Center(
              child: CircleAvatar(
                radius: 70.r, // Responsive radius
                backgroundImage: const AssetImage("assets/images/auth/img.png"),
              ),
            ),
            SizedBox(height: 30.h), // Responsive height

            // Caller Name and Duration
            Text(
              "Michael",
              style: GoogleFonts.lato(
                fontSize: 41.sp, // Responsive font size
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1D3856),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "8:30",
              style: GoogleFonts.lato(
                fontSize: 24.sp, // Responsive font size
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1D3856),
              ),
            ),

            const Spacer(), // Pushes the buttons to the bottom

            // Action Buttons
            Padding(
              padding: EdgeInsets.only(bottom: 40.0.h), // Responsive bottom padding
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Speaker Button
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(15.0.r), // Responsive padding
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF0909091A),
                        ),
                        child: SizedBox(
                          height: 50.r, // Consistent size
                          width: 50.r,
                          child: FloatingActionButton(
                            backgroundColor: const Color(0x29FFFFFF),
                            onPressed: () {},
                            shape: const CircleBorder(),
                            elevation: 0,
                            child: SvgPicture.asset(
                              "assets/svg/speaker.svg",
                              height: 25.h, // Responsive icon size
                              width: 25.w,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h), // Responsive height
                      Text(
                        "Speaker",
                        style: TextStyle(color: Colors.black87, fontSize: 14.sp), // Responsive font size
                      ),
                    ],
                  ),

                  // End Call Button
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(15.0.r), // Responsive padding
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF0909091A),
                        ),
                        child: SizedBox(
                          height: 70.r, // Responsive size
                          width: 70.r,
                          child: FloatingActionButton(
                            backgroundColor: Colors.red,
                            onPressed: () {
                              Get.to(CallView()); // End call should navigate back or to another screen
                            },
                            shape: const CircleBorder(),
                            child: Icon(Icons.call_end, size: 35.sp), // Responsive icon size
                          ),
                        ),
                      ),
                      // SizedBox(height: 70.h), // This seemed like a mistake, removed it. Add back if needed.
                    ],
                  ),

                  // Mute Button
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(15.0.r), // Responsive padding
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF0909091A),
                        ),
                        child: SizedBox(
                          height: 50.r, // Consistent size
                          width: 50.r,
                          child: FloatingActionButton(
                            backgroundColor: const Color(0x29FFFFFF),
                            onPressed: () {},
                            shape: const CircleBorder(),
                            elevation: 0,
                            child: SvgPicture.asset(
                              "assets/svg/speaker2.svg", // Assuming this is a mute icon
                              height: 25.h, // Responsive icon size
                              width: 25.w,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h), // Responsive height
                      Text(
                        "Mute", // Label changed to Mute to reflect icon
                        style: TextStyle(color: Colors.black87, fontSize: 14.sp), // Responsive font size
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}