import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../common/appColors.dart';
import '../../../../common/customFont.dart';
import 'call_recording.dart';
import 'incoming_ongoing_call.dart';


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
              height: 187.h,
              padding: EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [AppColors.lightPurplePink2, AppColors.customSkyBlue3],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.r),
                  bottomRight: Radius.circular(40.r),
                ),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: Get.back,
                    child: SvgPicture.asset('assets/images/common/back_icon.svg'),
                  ),
                  SizedBox(width: 12.w),
                  CircleAvatar(
                    backgroundImage: const AssetImage("assets/images/auth/img.png"),
                    radius: 28.r,
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 30.h),
                        Text("Michael",
                            style: h2.copyWith(
                                fontSize: 24.47.sp, color: AppColors.txtclr5)),
                        Row(
                          children: [
                            Icon(Icons.circle,
                                color: AppColors.greenonline, size: 10.r),
                            SizedBox(width: 5.w),
                            Text("Online Now",
                                style: h2.copyWith(
                                    fontSize: 12.23.sp, color: AppColors.txtclr4)),
                          ],
                        ),
                        SizedBox(height: 5.83.h),
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/svg/call3.svg",
                              height: 15.h,
                              width: 15.w,
                            ),
                            Text("(555) 123-4567",
                                style: h2.copyWith(
                                    fontSize: 13.77.sp, color: AppColors.txtclr5))
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
                      height: 25.h,
                      width: 25.w,
                    ),
                    label: Text("Call Now",
                        style: h2.copyWith(fontSize: 18.sp, color: AppColors.white)),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      backgroundColor: AppColors.purplecall,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.r),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: ChipTheme(
                data: ChipThemeData(
                  backgroundColor: AppColors.clrWhite,
                  labelStyle: h2.copyWith(
                    fontSize: 14.sp,
                    color: AppColors.clrBlack,
                  ),
                  selectedColor: AppColors.customSkyBlue3,
                  // === পরিবর্তন এখানে ===
                  // আপনার দেওয়া কালো রঙটিই ব্যবহার করা হলো
                  secondaryLabelStyle: h2.copyWith(
                    fontSize: 14.sp,
                    color: AppColors.clrBlack,
                  ),
                  // === পরিবর্তন শেষ ===
                  side: BorderSide(color: AppColors.card51),
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  showCheckmark: false,
                ),
                child: Row(
                  children: [
                    ChoiceChip(
                      label: const Text("All (10)"),
                      selected: true,
                      onSelected: (bool selected) {},
                    ),
                    SizedBox(width: 8.w),
                    ChoiceChip(
                      label: const Text("Missed (1)"),
                      selected: false,
                      onSelected: (bool selected) {},
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search Calls, Date",
                  hintStyle: h4.copyWith( // h4 (w400) ব্যবহার করা হলো
                    color: AppColors.grey5,
                    fontSize: 14.sp,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    child: SvgPicture.asset(
                      'assets/svg/search.svg',
                      width: 20.w,
                      height: 20.h,
                      colorFilter: const ColorFilter.mode(
                        AppColors.grey5,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0.r),
                    borderSide: BorderSide(
                      color: AppColors.grey5,
                      width: 1.0.w,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0.r),
                    borderSide: BorderSide(
                      color: AppColors.grey5,
                      width: 1.0.w,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'Recent calls',
                style: h2.copyWith(
                  fontSize: 20.sp,
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
                height: 30.h,
                width: 30.w,
              ),
              iconBackgroundColor: AppColors.customSkyBlue3,
              cardBackgroundColor: AppColors.cardbakground1,
              onPlayRecording: () {
                Get.to(CallRecording());
              },
            ),
            CustomCallCard(
              title: 'Incoming',
              dateTime: 'Jan 15, 2024 At 2:30 PM',
              duration: '12:45',
              icon: SvgPicture.asset(
                "assets/svg/Incomecall.svg",
                height: 30.h,
                width: 30.w,
              ),
              iconBackgroundColor: AppColors.iconbackground1,
              cardBackgroundColor: AppColors.cardbakground2,
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
                height: 30.h,
                width: 30.w,
              ),
              iconBackgroundColor: AppColors.iconbackground2,
              cardBackgroundColor: AppColors.cardbakground3,
            ),
            CustomCallCard(
              title: 'Incoming',
              dateTime: 'Jan 15, 2024 At 2:30 PM',
              duration: '12:45',
              icon: SvgPicture.asset(
                "assets/svg/Incomecall.svg",
                height: 30.h,
                width: 30.w,
              ),
              iconBackgroundColor: AppColors.iconbackground1,
              cardBackgroundColor: AppColors.cardbakground2,
              onPlayRecording: () {
                Get.to(CallRecording());
              },
            ),
            SizedBox(height: 40.h)
          ],
        ),
      ),
    );
  }
}