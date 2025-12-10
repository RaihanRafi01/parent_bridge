import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:parent_bridge/app/modules/legal_records/views/Widget/Custom_card_legal.dart';
import 'package:parent_bridge/app/modules/legal_records/views/Widget/Custom_legaldialog.dart';

import '../../../../common/appColors.dart';
import '../../../../common/customFont.dart';
import '../../../../common/widgets/nav/circularMenuWidget.dart';
import '../controllers/legal_records_controller.dart';

class LegalRecordsView extends GetView<LegalRecordsController> {
  const LegalRecordsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.only(top: 20.r, left: 16.r, right: 16.r),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.appColor2, AppColors.appColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: Get.back,
                        child: SvgPicture.asset(
                          'assets/images/common/back_icon.svg',
                          width: 40.w,
                        ),
                      ),

                      Text(
                        "Legal Records",
                        style: h2.copyWith(
                          fontSize: 24.47.sp,
                          color: AppColors.textColor7,
                        ),
                      ),
                      SizedBox(width: 40.w),
                    ],
                  ),
                  SizedBox(height: 200.w),
                  InkWell(
                    onTap: () {
                      Get.dialog(
                        Document_dialoglegal(
                          title: 'Message Records Report',
                          subtitle:
                              'Generate Court-Ready Message Documentation',
                        ),
                      );
                    },
                    child: DocumentCardLegal(
                      title: 'Message',
                      text:
                          "View and analyze all message interactions between co-parents,' "
                          "organized by date and time. Messages flagged for negative or "
                          "concerning content are highlighted for legal clarity. This section "
                          "helps you monitor communication patterns and supports court-ready documentation",

                      image: "assets/images/document_svg/msg.png",
                      color: AppColors.barColor,
                      color2: AppColors.barColor,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  InkWell(
                    onTap: () {
                      Get.dialog(
                        Document_dialoglegal(
                          title: 'Call Records Report',
                          subtitle: 'Generate Court-Ready Call Documentation',
                        ),
                      );
                    },
                    child: DocumentCardLegal(
                      color: AppColors.barColor2,
                      color2: AppColors.barColor2,
                      title: 'Call',
                      text:
                          "View and analyze all message interactions between co-parents,' "
                          "organized by date and time. Messages flagged for negative or "
                          "concerning content are highlighted for legal clarity. This section "
                          "helps you monitor communication patterns and supports court-ready documentation",

                      image: "assets/images/document_svg/call.png",
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Search Bar

          // Filter Buttons

          // Document list
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CircularMenuWidget(homeScreenIndex: 9),
    );
  }
}
