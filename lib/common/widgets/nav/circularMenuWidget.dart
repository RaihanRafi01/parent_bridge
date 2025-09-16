import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:parent_bridge/app/modules/calendar/views/calendar_view.dart';
import 'package:parent_bridge/app/modules/chat/views/chat_view.dart';
import 'package:parent_bridge/app/modules/document_vault/views/document_vault_view.dart';
import 'package:parent_bridge/app/modules/home/views/home_view.dart';
import 'package:parent_bridge/app/modules/settings/views/settings_view.dart';
import '../../../../common/appColors.dart';
import '../../../../common/widgets/home/circularfabmenu.dart';

class CircularMenuWidget extends StatelessWidget {
  final int homeScreenIndex; // Index of the menu item to mark as "home"

  const CircularMenuWidget({
    super.key,
    this.homeScreenIndex = 0, // Default to first item (home icon)
  });

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {'svg': 'assets/images/home/home.svg', 'onPressed': () {Get.to(HomeView());}},
      {'svg': 'assets/images/home/chaticon.svg', 'onPressed': () {Get.to(ChatView());}},
      {'svg': 'assets/images/home/schedule.svg', 'onPressed': () {Get.to(CalendarView());}},
      {'svg': 'assets/images/home/form.svg', 'onPressed': () {Get.to(DocumentVaultView());}},
      {'svg': 'assets/images/home/settings.svg', 'onPressed': () {Get.to(SettingsView());}},
    ];

    return Padding(
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
        children: List<Widget>.generate(
          menuItems.length,
              (index) => _buildMenuIcon(
            ishome: index == homeScreenIndex,
            svg: menuItems[index]['svg'] as String,
            onPressed: menuItems[index]['onPressed'] as VoidCallback,
          ),
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
          child: SvgPicture.asset(
            svg,
            height: 25.h,
            width: 25.w,
            colorFilter: ishome
                ? ColorFilter.mode(AppColors.white, BlendMode.srcIn)
                : null,
          ),
        ),
      ),
    );
  }
}