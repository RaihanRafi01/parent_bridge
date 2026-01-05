import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parent_bridge/app/modules/calendar/views/calendar_view.dart';
import 'package:parent_bridge/app/modules/call/views/call_view.dart';
import 'package:parent_bridge/app/modules/chat/views/chat_view.dart';
import 'package:parent_bridge/app/modules/document_vault/views/document_vault_view.dart';
import 'package:parent_bridge/app/modules/expense_tracker/views/expense_tracker_view.dart';
import 'package:parent_bridge/app/modules/legal_records/views/legal_records_view.dart';
import 'package:parent_bridge/app/modules/support_forum/views/support_forum_view.dart';
import 'package:parent_bridge/app/modules/settings/controllers/settings_controller.dart';
import 'package:parent_bridge/app/core/constants/api.dart';
import '../../../../common/appColors.dart';
import '../../../../common/customFont.dart';
import '../../../../common/widgets/home/dashboard_container.dart';
import '../../../../common/widgets/home/home_container.dart';
import '../../../../common/widgets/nav/circularMenuWidget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsController controller = Get.put(SettingsController());
    return Scaffold(
      backgroundColor: Colors
          .transparent, // Keep transparent to allow Container gradient to show
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
                      Obx(() {
                        String imageUrl = controller.profileImage.value;
                        if (imageUrl.isNotEmpty &&
                            !imageUrl.startsWith('http')) {
                          imageUrl = '${Api.baseUrl}$imageUrl';
                        }
                        return Container(
                          width: 50.w,
                          height: 50.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageUrl.isNotEmpty
                                  ? NetworkImage(imageUrl)
                                  : const AssetImage(
                                          'assets/images/home/person.png',
                                        )
                                        as ImageProvider,
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
                        );
                      }),
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
                        onPressed: () {
                          Get.to(ChatView());
                        },
                        childImage: Image.asset(
                          'assets/images/home/img_3.png',
                          height: 68.h,
                          width: 68.w,
                          fit: BoxFit.contain,
                        ),
                        label: "Message",
                        badgeCount: 100,
                      ),
                      IconWithBadge(
                        onPressed: () {
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
                        onPressed: () {
                          Get.to(DocumentVaultView());
                        },
                        childImage: Image.asset(
                          'assets/images/home/img_5.png',
                          height: 68.h,
                          width: 68.w,
                          fit: BoxFit.contain,
                        ),
                        label: "Documents",
                        badgeCount: 10,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconWithBadge(
                        onPressed: () {
                          Get.to(CalendarView());
                        },
                        childImage: Image.asset(
                          'assets/images/home/img_8.png',
                          height: 68.h,
                          width: 68.w,
                          fit: BoxFit.contain,
                        ),
                        label: "Calender",
                        badgeCount: 2,
                      ),
                      IconWithBadge(
                        onPressed: () {
                          Get.to(ExpenseTrackerView());
                        },
                        childImage: Image.asset(
                          'assets/images/home/img_6.png',
                          height: 68.h,
                          width: 68.w,
                          fit: BoxFit.contain,
                        ),
                        label: "Expenses",
                        badgeCount: 6,
                      ),
                      IconWithBadge(
                        onPressed: () {
                          Get.to(SupportForumView());
                        },
                        childImage: Image.asset(
                          'assets/images/home/img_7.png',
                          height: 68.h,
                          width: 68.w,
                          fit: BoxFit.contain,
                        ),
                        label: "Support",
                        badgeCount: 5,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconWithBadge(
                      onPressed: () {
                        Get.to(LegalRecordsView());
                      },
                      childImage: Image.asset(
                        'assets/images/home/img_9.png',
                        height: 68.h,
                        width: 68.w,
                        fit: BoxFit.contain,
                      ),
                      label: "Legal Records",
                      badgeCount: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CircularMenuWidget(),
    );
  }
}
