import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:parent_bridge/common/customFont.dart'; // আপনার কাস্টম ফন্ট ফাইল

import '../../../../common/appColors.dart';
import '../../../../common/customFont.dart';
import '../../../../common/widgets/_buildDetailItem.dart';
import '../../../../common/widgets/customButton.dart';
import '../../../../common/widgets/detailsrowWidget.dart';
import '../../../../common/widgets/home/gradientprogressindicator.dart';
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
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.lightPurplePink2, AppColors.customSkyBlue3],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: 40.h, left: 16.w),
                          child: GestureDetector(
                            onTap: Get.back,
                            child: SvgPicture.asset('assets/images/common/back_icon.svg'),
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
                            style: h2.copyWith(
                              fontSize: 30.sp,
                              color: AppColors.txtclr5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 47.h),
                Container(
                  width: 377.w,
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.custom1, AppColors.custom2],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    border: Border.all(color: AppColors.grayborderclr, width: 1.0.w),
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
                                  style: h2.copyWith(
                                    fontSize: 24.sp,
                                    color: AppColors.txtclr5,
                                  ),
                                ),
                                SizedBox(height: 5.83.h),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/svg/callu.svg",
                                      height: 15.h,
                                      width: 15.w,
                                      color: AppColors.txtclr5,
                                    ),
                                    SizedBox(width: 10.w),
                                    Text(
                                      "Outgoing",
                                      style: h2.copyWith(
                                        fontSize: 10.sp,
                                        color: AppColors.txtclr5,
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
                            icon: SvgPicture.asset("assets/svg/calender.svg"),
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
                Container(
                  padding: EdgeInsets.all(16.r),
                  width: 377.w,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.custom1, AppColors.custom2],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    border: Border.all(color: AppColors.grayborderclr, width: 1.0.w),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Audio Waveform",
                          style: h2.copyWith(
                            fontSize: 24.sp,
                            color: AppColors.txtclr5,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Container(
                        padding: EdgeInsets.all(16.r),
                        child: SvgPicture.asset("assets/svg/wave.svg", width: 100.w),
                        height: 92.h,
                        width: 344.w,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppColors.custom2, AppColors.custom1],
                            begin: Alignment.bottomLeft,
                            end: Alignment.bottomRight,
                          ),
                          border: Border.all(color: AppColors.grayborderclr, width: 1.0.w),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                      SizedBox(height: 25.h),

                      // i made this by using gpt _______________
                      CustomGradientProgressIndicator(
                        progress: 0.6,
                        height: 8.h,
                        radius: 20.r,
                        backgroundColor: AppColors.white.withOpacity(0.8),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF88D5F7),
                            Color(0xFF8A77F0),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('0:16', style: h4.copyWith()),
                          Text('8:24', style: h4.copyWith()),
                        ],
                      ),
                      SizedBox(height: 10.h),
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
                              icon: SvgPicture.asset("assets/svg/play_prev.svg", width: 15.w),
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(width: 30.w),
                          Container(
                            padding: EdgeInsets.all(8.r),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [AppColors.custom2, AppColors.custom1],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: IconButton(
                              icon: SvgPicture.asset("assets/svg/play_button.svg", width: 30.w),
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
                              icon: SvgPicture.asset("assets/svg/play_next.svg", width: 15.w),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset("assets/svg/recordV.svg", width: 20.w, height: 15.h),
                              SizedBox(width: 10.w),
                              SvgPicture.asset("assets/svg/pbar.svg", width: 40.w, height: 10.h),
                              SizedBox(width: 10.w),
                              Text("70%", style: h4.copyWith(fontSize: 12.sp)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Speed:",
                                style: h2.copyWith(
                                  fontSize: 12.sp,
                                  color: AppColors.txtclr5,
                                ),
                              ),
                              SizedBox(width: 3.w),
                              SpeedButton(
                                speed: 0.5,
                                isSelected: selectedSpeed == 0.5,
                                onTap: () => setState(() => selectedSpeed = 0.5),
                              ),
                              SizedBox(width: 3.w),
                              SpeedButton(
                                speed: 1.0,
                                isSelected: selectedSpeed == 1.0,
                                onTap: () => setState(() => selectedSpeed = 1.0),
                              ),
                              SizedBox(width: 3.w),
                              SpeedButton(
                                speed: 2.0,
                                isSelected: selectedSpeed == 2.0,
                                onTap: () => setState(() => selectedSpeed = 2.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                Container(
                  width: 377.w,
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.custom2, AppColors.custom1],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomLeft,
                    ),
                    border: Border.all(color: AppColors.grayborderclr, width: 1.0.w),
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Call Details",
                        style: h2.copyWith(
                          fontSize: 18,
                          color: AppColors.txtclr5,
                        ),
                      ),
                      const SizedBox(height: 15),
                      const DetailRowWidget(
                        title: "Initiated By:",
                        value: "you",
                      ),
                      const SizedBox(height: 10),
                      const DetailRowWidget(
                        title: "Ended By:",
                        value: "Michael",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      label: "Download",
                      svgPath: "assets/svg/B_downlod_icon.svg",
                      onPressed: () {},
                      height: 54.h,
                      width: 283.w,
                      radius: 30.r,
                      txtClr: AppColors.white,
                      gradient: const LinearGradient(
                        colors: [AppColors.lightPurplePink2, AppColors.custom3],
                        begin: Alignment.bottomRight,
                        end: Alignment.bottomLeft,
                      ),
                    ),
                    SizedBox(width: 16.w),

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