import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:parent_bridge/app/modules/calendar/views/calendar_view.dart';
import 'package:parent_bridge/app/modules/call/views/call_view.dart';
import 'package:parent_bridge/app/modules/chat/views/chat_view.dart';
import 'package:parent_bridge/app/modules/document_vault/views/document_vault_view.dart';
import 'package:parent_bridge/app/modules/expense_tracker/views/expense_tracker_view.dart';
import 'package:parent_bridge/app/modules/legal_records/views/legal_records_view.dart';
import 'package:parent_bridge/app/modules/settings/views/settings_view.dart';
import 'package:parent_bridge/app/modules/support_forum/views/support_forum_view.dart';
import '../../../../common/appColors.dart';
import '../../../../common/customFont.dart';
import '../../../../common/widgets/home/circularfabmenu.dart';
import '../../../../common/widgets/home/dashboard_container.dart';
import '../../../../common/widgets/home/home_container.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Keep transparent to allow Container gradient to show
      body: Container(
        width: double.infinity, // Ensure Container takes full width
        height: double.infinity, // Ensure Container takes full height
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.customLightBlue, // Light Blue
              AppColors.customLightPurple, // Light Purple
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50.w,
                        height: 50.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/images/home/person.png'),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 6.r,
                              offset: Offset(0.w, 2.h),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Good Day!",
                            style: h1.copyWith(
                              fontSize: 30.sp,
                              color: AppColors.textColor7,
                              letterSpacing: 1,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "Connected with Samantha",
                            style: h2.copyWith(
                              fontSize: 14.sp,
                              color: AppColors.textColor21,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  DashboardStats(
                    messagesToday: '12',
                    eventsThisWeek: '3',
                    pendingExpenses: '\$45',
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconWithBadge(
                        onPressed: (){
                          Get.to(ChatView());
                        },
                        childImage: Image.asset(
                          'assets/images/home/img_3.png',
                          height: 68.h,
                          width: 68.w,
                          fit: BoxFit.contain,
                        ),
                        label: "Message",
                        badgeCount: 3,
                      ),
                      IconWithBadge(
                        onPressed: (){
                          Get.to(CallView());
                        },
                        childImage: Image.asset(
                          'assets/images/home/img_4.png',
                          height: 68.h,
                          width: 68.w,
                          fit: BoxFit.contain,
                        ),
                        label: "Calls",
                        badgeCount: 3,
                      ),
                      IconWithBadge(
                        onPressed: (){
                          Get.to(DocumentVaultView());
                        },
                        childImage: Image.asset(
                          'assets/images/home/img_5.png',
                          height: 68.h,
                          width: 68.w,
                          fit: BoxFit.contain,
                        ),
                        label: "Documents",
                        badgeCount: 3,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconWithBadge(
                        onPressed: (){
                          Get.to(CalendarView());
                        },
                        childImage: Image.asset(
                          'assets/images/home/img_8.png',
                          height: 68.h,
                          width: 68.w,
                          fit: BoxFit.contain,
                        ),
                        label: "Calender",
                        badgeCount: 3,
                      ),
                      IconWithBadge(
                        onPressed: (){
                          Get.to(ExpenseTrackerView());
                        },
                        childImage: Image.asset(
                          'assets/images/home/img_6.png',
                          height: 68.h,
                          width: 68.w,
                          fit: BoxFit.contain,
                        ),
                        label: "Expenses",
                        badgeCount: 3,
                      ),
                      IconWithBadge(
                        onPressed: (){
                          Get.to(SupportForumView());
                        },
                        childImage: Image.asset(
                          'assets/images/home/img_7.png',
                          height: 68.h,
                          width: 68.w,
                          fit: BoxFit.contain,
                        ),
                        label: "Support",
                        badgeCount: 3,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Align(
                    alignment: Alignment.topLeft, // Fixed from AlignmentGeometry.topLeft
                    child: IconWithBadge(
                      onPressed: (){
                        Get.to(LegalRecordsView());
                      },
                      childImage: Image.asset(
                        'assets/images/home/img_9.png',
                        height: 68.h,
                        width: 68.w,
                        fit: BoxFit.contain,
                      ),
                      label: "Legit Records",
                      badgeCount: 3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(top: 20.0.h),
        child: CircularMenu(
          fabMargin: EdgeInsets.only(top: 1.h),
          ringGradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.customSkyBlue,
              Color(0xFF9AA0FF),
              AppColors.customDeepPurple,
            ],
            stops: [0.0, 0.3, 1.0],
          ),
          alignment: Alignment.bottomCenter,
          ringDiameter: 285.r,
          ringWidth: 90.w,
          fabSize: 70.w,
          fabOpenIcon: Icon(Icons.add, color: AppColors.white, size: 40.sp),
          fabCloseIcon: Icon(Icons.close, color: AppColors.white, size: 35.sp),
          fabOpenGradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.customSkyBlue2,
              Color(0xFF9AA0FF),
              AppColors.customDeepPurple,
            ],
            stops: [0.0, 0.3, 1.0],
          ),
          fabGradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.customSkyBlue2,
              Color(0xFF9AA0FF),
              AppColors.customDeepPurple,
            ],
            stops: [0.0, 0.3, 1.0],
          ),
          fabCloseGradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.customSkyBlue2,
              Color(0xFF9AA0FF),
              AppColors.customDeepPurple,
            ],
            stops: [0.0, 0.3, 1.0],
          ),
          children: <Widget>[
            _buildMenuIcon(
              svg: 'assets/images/home/home.svg',
              onPressed: () {},
              ishome: true,
            ),
            _buildMenuIcon(svg: 'assets/images/home/chaticon.svg', onPressed: () {Get.to(ChatView());}),
            _buildMenuIcon(svg: 'assets/images/home/schedule.svg', onPressed: () {Get.to(CalendarView());}),
            _buildMenuIcon(svg: 'assets/images/home/form.svg', onPressed: () {Get.to(DocumentVaultView());}),
            _buildMenuIcon(svg: 'assets/images/home/settings.svg', onPressed: () {Get.to(SettingsView());}),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuIcon({
    bool ishome = false,
    required String svg,
    required VoidCallback onPressed,
  }) {
    return RawMaterialButton(
      onPressed: onPressed,
      shape: const CircleBorder(),
      fillColor: Colors.transparent,
      elevation: 4,
      constraints: BoxConstraints.tightFor(width: 70.w, height: 60.h),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 2.w,
            color: ishome ? AppColors.white : Colors.transparent,
          ),
          gradient: ishome
              ? const LinearGradient(
            colors: [
              Color(0xFFA14CDD),
              Color(0xFF52B6E4),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
              : LinearGradient(
            colors: [
              AppColors.white,
              AppColors.white,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SvgPicture.asset(svg, height: 25.h, width: 25.w),
        ),
      ),
    );
  }
}