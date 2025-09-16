import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common/appColors.dart';
import '../../../../common/widgets/_buildDetailItem.dart';
import '../../../../common/widgets/customButton.dart';
import '../../../../common/widgets/detailsrowWidget.dart';
import '../../../../common/widgets/speedButton.dart';

class CallRecording extends StatefulWidget {
  const CallRecording({super.key});

  @override
  State<CallRecording> createState() => _CallRecordingState();
}

class _CallRecordingState extends State<CallRecording> {
  double selectedSpeed = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFBD9DED), Color(0xFF90CAE2)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Foreground UI
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: 40.h, left: 16.w),
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 60.w),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 40.h),
                        Text(
                          "Call Recording",
                          style: GoogleFonts.lato(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.txtclr5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 47.h),

                // Call details card
                Container(
                  width: 377.w,
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0x802FCEF1), Color(0x807222EA)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    border: Border.all(color: Color(0x4DFFFFFF), width: 1.0.w),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 5.w),
                          CircleAvatar(
                            backgroundImage:
                            const AssetImage("assets/images/auth/img.png"),
                            radius: 35.r,
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Michael",
                                  style: GoogleFonts.lato(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF1D3856),
                                  ),
                                ),
                                SizedBox(height: 5.83.h),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/svg/callu.svg",
                                      height: 15.h,
                                      width: 15.w,
                                      color: const Color(0xFF1D3856),
                                    ),
                                    SizedBox(width: 10.w),
                                    Text(
                                      "Outgoing",
                                      style: GoogleFonts.lato(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF1D3856),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 5.w),
                          BuildDetailItem(
                            icon:
                            SvgPicture.asset("assets/svg/calender.svg"),
                            value: "2024-01-12",
                            label: "Call date",
                          ),
                          const Spacer(),
                          BuildDetailItem(
                            icon: SvgPicture.asset("assets/svg/clock.svg"),
                            value: "4:20 PM",
                            label: "Start time",
                          ),
                          const Spacer(),
                          BuildDetailItem(
                            icon: SvgPicture.asset("assets/svg/timer.svg"),
                            value: "8:12",
                            label: "Duration",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),

                // Waveform container
                Container(
                  padding: EdgeInsets.all(16.r),
                  width: 377.w,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0x807222EA), Color(0x802FCEF1)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    border: Border.all(color: Color(0x4DFFFFFF), width: 1.0.w),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Audio Waveform",
                          style: GoogleFonts.lato(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1D3856),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Container(
                        padding: EdgeInsets.all(16.r),
                        child: SvgPicture.asset("assets/svg/wave.svg",
                            width: 100.w),
                        height: 92.h,
                        width: 344.w,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0x807222EA), Color(0x802FCEF1)],
                            begin: Alignment.bottomLeft,
                            end: Alignment.bottomRight,
                          ),
                          border:
                          Border.all(color: Color(0x4DFFFFFF), width: 1.0.w),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                      SizedBox(height: 25.h),
                      LinearProgressIndicator(
                        value: 0.6,
                        minHeight: 8.h,
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('0:16'),
                          Text('8:24'),
                        ],
                      ),
                      SizedBox(height: 10.h),

                      // Player controls
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 40.h,
                            width: 60.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18.r),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 3.r,
                                  offset: Offset(0, 2.h),
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: SvgPicture.asset("assets/svg/play_prev.svg",
                                  width: 15.w),
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(width: 30.w),
                          Container(
                            padding: EdgeInsets.all(8.r),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [Color(0xFF2FCEF1), Color(0xFF7222EA)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: IconButton(
                              icon: SvgPicture.asset(
                                  "assets/svg/play_button.svg",
                                  width: 30.w),
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(width: 30.w),
                          Container(
                            height: 40.h,
                            width: 60.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18.r),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 3.r,
                                  offset: Offset(0, 2.h),
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: SvgPicture.asset("assets/svg/play_next.svg",
                                  width: 15.w),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10.h),

                      // Speed + Recording Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset("assets/svg/recordV.svg",
                                  width: 20.w, height: 15.h),
                              SizedBox(width: 10.w),
                              SvgPicture.asset("assets/svg/pbar.svg",
                                  width: 40.w, height: 10.h),
                              SizedBox(width: 10.w),
                              Text("70%", style: TextStyle(fontSize: 12.sp)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Speed:",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1D3856),
                                ),
                              ),
                              SizedBox(width: 3.w),
                              SpeedButton(
                                speed: 0.5,
                                isSelected: selectedSpeed == 0.5,
                                onTap: () =>
                                    setState(() => selectedSpeed = 0.5),
                              ),
                              SizedBox(width: 3.w),
                              SpeedButton(
                                speed: 1.0,
                                isSelected: selectedSpeed == 1.0,
                                onTap: () =>
                                    setState(() => selectedSpeed = 1.0),
                              ),
                              SizedBox(width: 3.w),
                              SpeedButton(
                                speed: 2.0,
                                isSelected: selectedSpeed == 2.0,
                                onTap: () =>
                                    setState(() => selectedSpeed = 2.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),

                // Call details bottom card
                Container(
                  width: 377.w,
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0x802FCEF1), Color(0x807222EA)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(color: Color(0x4DFFFFFF), width: 1.0.w),
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Call Details",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1D3856),
                        ),
                      ),
                      SizedBox(height: 15),
                      DetailRowWidget(
                        title: "Initiated By:",
                        value: "you",
                      ),
                      SizedBox(height: 10),
                      DetailRowWidget(
                        title: "Ended By:",
                        value: "Michael",
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30.h),

                // Bottom buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      label: "Download",
                      svgPath: "assets/svg/B_downlod_icon.svg",
                      onPressed: () {},
                      height: 54.h,
                      width: 183.w,
                      bgClr: const Color(0xFF6A30F4),
                      radius: 30.r,
                    ),
                    SizedBox(width: 16.w),
                    CustomButton(
                      borderColor: const Color(0xFF7222EA),
                      label: "Share",
                      svgPath: "assets/svg/B_downlod_icon.svg",
                      onPressed: () {},
                      height: 54.h,
                      width: 183.w,
                      bgClr: Colors.deepPurpleAccent,
                      radius: 30.r,
                    ),
                  ],
                ),

                SizedBox(height: 24.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
