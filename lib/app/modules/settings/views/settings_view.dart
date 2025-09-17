import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:parent_bridge/app/modules/settings/views/co_parentInformation.dart';
import 'package:parent_bridge/app/modules/settings/views/help_and_support.dart';
import 'package:parent_bridge/app/modules/settings/views/privacy_policy.dart';
import 'package:parent_bridge/app/modules/settings/views/profile.dart';
import 'package:parent_bridge/app/modules/settings/views/subscription.dart';
import 'package:parent_bridge/common/widgets/home/custom_listTile.dart';
import '../../../../common/customFont.dart';
import '../../../../common/widgets/home/showLogout_dialog.dart';
import '../../../../common/appColors.dart';


class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.clrWhite,
      appBar: AppBar(
        backgroundColor: AppColors.clrWhite,
        elevation:  0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: Get.back,
          child: Padding(
            padding: const EdgeInsets.only(left: 16).r,
            child: SvgPicture.asset('assets/images/common/back_icon.svg'),
          ),
        ),
        title: Text(
          'Settings',
          style: h2.copyWith( // Using h2 from your custom typography file
            fontSize: 28.sp,
            color:  AppColors.darkSlateBlue,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),
              Container(
                padding: const EdgeInsets.all(8.0),
                height: 110.h,
                decoration: BoxDecoration(
                  color: AppColors.profileboxclr,
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
                            color: AppColors.titlepurple,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              'ParentBridge Pro(+)',
                              style: h4.copyWith( // Using h4 from your custom typography file
                                color: AppColors.clrWhite,
                                fontSize: 9.sp,
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
                              style: h2.copyWith( // Using h2
                                fontSize: 24.sp,
                                color: AppColors.darkSlateBlue,
                              ),
                            ),
                            Text(
                              'michaelsmith@gmail.com',
                              style: h4.copyWith( // Using h4
                                fontSize: 14.sp,
                                color:  AppColors.txtclr1,
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
                style: h2.copyWith( // Using h2
                  fontSize: 18.sp,
                  color: AppColors.darkSlateBlue,
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
                ),
                onTap: () => Get.to(() => Subscription()),
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
                style: h2.copyWith( // Using h2
                  fontSize: 18.sp,
                  color: AppColors.darkSlateBlue,

                ),
              ),
              CustomListTile(
                leadingSvgAsset: 'assets/images/settings/help_s.svg',
                title: 'Help & support',
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
                style: h2.copyWith( // Using h2
                  fontSize: 18.sp,
                  color: AppColors.darkSlateBlue,

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
                    activeColor: AppColors.clrWhite,
                    activeTrackColor: AppColors.blackactive,
                    inactiveThumbColor:AppColors.clrWhite,
                    inactiveTrackColor: AppColors.gray3,
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
                    activeColor: AppColors.clrWhite,
                    activeTrackColor: AppColors.blackactive,
                    inactiveThumbColor:AppColors.clrWhite,
                    inactiveTrackColor: AppColors.gray3,
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
                    activeColor: AppColors.clrWhite,
                    activeTrackColor: AppColors.blackactive,
                    inactiveThumbColor:AppColors.clrWhite,
                    inactiveTrackColor: AppColors.gray3,
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
                    activeColor: AppColors.clrWhite,
                    activeTrackColor: AppColors.blackactive,
                    inactiveThumbColor:AppColors.clrWhite,
                    inactiveTrackColor: AppColors.gray3,
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
                      style: h2.copyWith( // Using h2
                        fontSize: 18.sp,
                        color: AppColors.clrWhite,
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