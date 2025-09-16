import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_bridge/app/modules/settings/views/co_parentInformation.dart';
import 'package:parent_bridge/app/modules/settings/views/help_and_support.dart';
import 'package:parent_bridge/app/modules/settings/views/privacy_policy.dart';
import 'package:parent_bridge/app/modules/settings/views/profile.dart';
import 'package:parent_bridge/app/modules/settings/views/subscription.dart';
import 'package:parent_bridge/common/widgets/home/custom_listTile.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/home/showLogout_dialog.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: Get.back,
                    child: SvgPicture.asset('assets/images/common/back_icon.svg',width: 40.w,),
                  ),
                  Text(
                    'Settings',
                    style: GoogleFonts.lato(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1D3856),
                    ),
                  ),
                  SizedBox(width: 40.w)
                ],
              ),
              SizedBox(height: 12.h),
              Container(
                padding: const EdgeInsets.all(8.0),
                height: 110.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFB7E8FC),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 21.18.h,
                          width: 100.13.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFF7A5CF1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              'ParentBridge Pro(+)',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w400,
                                height: 1,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 30.w),
                      ],
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 28.r,
                          backgroundColor: Colors.black,
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/auth/img.png',
                              fit: BoxFit.cover,
                              width: 56.r,
                              height: 56.r,
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Michael Smith",
                              style: GoogleFonts.lato(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1D3856),
                              ),
                            ),
                            Text(
                              'michaelsmith@gmail.com',
                              style: GoogleFonts.lato(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF63768A),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 13.h),
              Text(
                'Account',
                style: GoogleFonts.lato(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF474747),
                ),
              ),
              CustomListTile(
                leadingSvgAsset: 'assets/images/settings/profile.svg',
                title: 'Profile Information',
                trailingWidget: SvgPicture.asset(
                  'assets/images/settings/arrow.svg',
                ),
                onTap: () => Get.to(() => Profile()),
              ),
              CustomListTile(
                leadingSvgAsset: 'assets/images/settings/subscription.svg',
                title: 'Subscription',
                trailingWidget: SvgPicture.asset(
                  'assets/images/settings/arrow.svg',
                ), onTap: () => Get.to(() => Subscription()),
              ),
              CustomListTile(
                leadingSvgAsset: 'assets/images/settings/choose_app.svg',
                title: 'Choose the App',
                trailingWidget: SvgPicture.asset(
                  'assets/images/settings/arrow.svg',
                ),
              ),
              CustomListTile(
                leadingSvgAsset: 'assets/images/settings/co_parent.svg',
                title: 'Co-parent Information',
                trailingWidget: SvgPicture.asset(
                  'assets/images/settings/arrow.svg',
                ),
                onTap: () => Get.to(() => CoParentinformation()),
              ),
              Text(
                'contact',
                style: GoogleFonts.lato(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF474747),
                ),
              ),
              CustomListTile(
                leadingSvgAsset: 'assets/images/settings/help_s.svg',
                title: 'Help & suppor',
                trailingWidget: SvgPicture.asset(
                  'assets/images/settings/arrow.svg',
                ),
                onTap: () => Get.to(() => HelpAndSupport()),
              ),
              CustomListTile(
                leadingSvgAsset: 'assets/images/settings/terms_condition.svg',
                title: 'Terms & Condition',
                trailingWidget: SvgPicture.asset(
                  'assets/images/settings/arrow.svg',
                ),
              ),
              CustomListTile(
                leadingSvgAsset: 'assets/images/settings/privacy.svg',
                title: 'Privacy Policy',
                trailingWidget: SvgPicture.asset(
                  'assets/images/settings/arrow.svg',
                ),
                onTap: () => Get.to(() => PrivacyPolicy()),
              ),
              Text(
                'notifications',
                style: GoogleFonts.lato(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF474747),
                ),
              ),
              CustomListTile(
                leadingSvgAsset: 'assets/images/settings/messege.svg',
                title: 'Message Notifications',
                trailingWidget: Transform.scale(
                  scale: 0.6,
                  child: Switch(
                    value: true,
                    onChanged: (value) {},
                    activeColor: Colors.white,
                    activeTrackColor: Color(0xFF171717),
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.grey.shade300,
                  ),
                ),
              ),
              CustomListTile(
                leadingSvgAsset: 'assets/images/settings/call_s.svg',
                title: 'Call Notifications',
                trailingWidget: Transform.scale(
                  scale: 0.6,
                  child: Switch(
                    value: true,
                    onChanged: (value) {},
                    activeColor: Colors.white,
                    activeTrackColor: Color(0xFF171717),
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.grey.shade300,
                  ),
                ),
              ),
              CustomListTile(
                leadingSvgAsset: 'assets/images/settings/Calender.svg',
                title: 'Calendar Notifications',
                trailingWidget: Transform.scale(
                  scale: 0.6,
                  child: Switch(
                    value: false,
                    onChanged: (value) {},
                    activeColor: Colors.white,
                    activeTrackColor: Color(0xFF171717),
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.grey,
                  ),
                ),
              ),
              CustomListTile(
                leadingSvgAsset: 'assets/images/settings/expences.svg',
                title: 'Expense Requests',
                trailingWidget: Transform.scale(
                  scale: 0.6,
                  child: Switch(
                    value: false,
                    onChanged: (value) {},
                    activeColor: Colors.white,
                    activeTrackColor: Color(0xFF171717),
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 13.h),
              InkWell(
                onTap: () {
                  Get.bottomSheet(
                    showLogoutDialog(),
                    barrierColor: Colors.deepPurpleAccent.withOpacity(0.4),
                  );
                },
            child: Container(
              height: 45.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFD22853),
                borderRadius: BorderRadius.circular(22.r),
              ),
              child: Center(
                child: Text(
                  "Log Out",
                  style: GoogleFonts.lato(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFFFFFFF),
                  ),
                ),
              ),
            ),
              ),
              SizedBox(height: 30.h),
            ],

          ),
        ),
      ),
    );
  }
}