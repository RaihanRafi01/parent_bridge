import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_bridge/app/modules/call/views/ongoing_call.dart';

class IncomingecalliView extends StatelessWidget {
  const IncomingecalliView({super.key});

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
          children: [ // Removed MainAxisAlignment to use Spacer effectively
            // Back button top left
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 40.h, left: 16.w), // Responsive padding
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ),

            SizedBox(height: 60.h), // Responsive height

            // Profile Image
            Center(
              child: Container(
                padding: EdgeInsets.all(15.r), // Responsive padding for outer ring
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0x14000000), // outer ring
                ),
                child: Container(
                  padding: EdgeInsets.all(15.r), // Responsive padding for middle ring
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0x19000000), // middle ring
                  ),
                  child: CircleAvatar(
                    radius: 55.r, // Responsive radius
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 55.r, // Responsive radius
                      backgroundImage: const AssetImage("assets/images/auth/img.png"),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 30.h), // Responsive height

            // Incoming Call Text
            Text(
              "Incoming Call...",
              textAlign: TextAlign.center, // Added for better alignment on smaller screens
              style: GoogleFonts.lato(
                fontSize: 41.sp, // Responsive font size
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1D3856),
              ),
            ),

            const Spacer(), // Pushes the buttons to the bottom

            // Buttons Row
            Padding(
              padding: EdgeInsets.only(bottom: 40.0.h), // Responsive bottom padding
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Decline Button
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(15.0.r), // Responsive padding
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF0909091A),
                        ),
                        child: SizedBox(
                          height: 70.r, // Responsive height & width using .r for uniform circle
                          width: 70.r,
                          child: FloatingActionButton(
                            backgroundColor: Colors.red,
                            onPressed: () {
                              Get.back(); // Decline should probably go back
                            },
                            shape: const CircleBorder(),
                            child: Icon(Icons.call_end, size: 30.sp), // Responsive icon size
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h), // Responsive height
                      Text(
                        "Decline",
                        style: TextStyle(color: Colors.black87, fontSize: 14.sp), // Responsive font size
                      ),
                    ],
                  ),

                  // Accept Button
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(15.0.r), // Responsive padding
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF0909091A),
                        ),
                        child: SizedBox(
                          height: 70.r, // Responsive height & width using .r
                          width: 70.r,
                          child: FloatingActionButton(
                            backgroundColor: Colors.green,
                            onPressed: () {
                              Get.to(const OngoingCall());
                            },
                            shape: const CircleBorder(),
                            child: Icon(Icons.call, size: 30.sp, color: Colors.white), // Responsive icon size
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h), // Responsive height
                      Text(
                        "Accept",
                        style: TextStyle(color: Colors.black87, fontSize: 14.sp), // Responsive font size
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}