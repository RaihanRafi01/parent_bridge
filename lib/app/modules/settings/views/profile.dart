import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common/widgets/home/add_child_button.dart';
import '../../../../common/widgets/home/child_info_tile.dart';
import '../../../../common/widgets/home/custom_listTile.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),
              // ---------- Header ----------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(
                      Icons.arrow_back_outlined,
                      color: Colors.black,
                      size: 28,
                    ),
                  ),
                  Text(
                    'Profile',
                    style: GoogleFonts.lato(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1D3856),
                    ),
                  ),
                  SizedBox(width: 28),
                ],
              ),

              SizedBox(height: 12.h),
              // ---------- Profile Picture ----------
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 40.r,
                        backgroundColor: Colors.grey,
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/auth/img.png',
                            fit: BoxFit.cover,
                            width: 80.r,
                            height: 80.r,
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFFCFF0FF),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          'Change Picture',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xFF007BFF),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              // ---------- Full Name ----------
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  'Full name',
                  style: GoogleFonts.lato(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF474747),
                  ),
                ),
              ),
              CustomListTile(
                leadingSvgAsset: 'assets/images/settings/profile.svg',
                title: 'Michael Smith',
              ),

              // ---------- Email ----------
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  'Email',
                  style: GoogleFonts.lato(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF474747),
                  ),
                ),
              ),
              CustomListTile(
                leadingSvgAsset: 'assets/images/profile/mail.svg',
                title: 'michaelsmith@gmail.com',
              ),

              // ---------- Contact ----------
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  'Contact number',
                  style: GoogleFonts.lato(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF474747),
                  ),
                ),
              ),
              CustomListTile(
                leadingSvgAsset: 'assets/images/profile/contact.svg',
                title: '+881 01405366393',
              ),

              // ---------- Password ----------
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  'Password',
                  style: GoogleFonts.lato(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF474747),
                  ),
                ),
              ),
              CustomListTile(
                leadingSvgAsset: 'assets/images/profile/pass.svg',
                title: '*******',
                  trailingWidget: SvgPicture.asset(
                    'assets/images/profile/invisible_pass.svg',
                  ),
              ),

              // ---------- Children ----------
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  'child’s (2)',
                  style: GoogleFonts.lato(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF474747),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.0),
                  border: Border.all(
                    color: const Color(0xFFCC94EF).withOpacity(0.5),
                    width: 0.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFCC94EF).withOpacity(0.14),
                      spreadRadius: 0,
                      blurRadius: 12.6,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const ChildInfoTile(

                      index: '1',
                      name: 'Max Smith',
                      age: '8 Years',
                    ),
                    const SizedBox(height: 16.0),
                    const ChildInfoTile(
                      index: '2',
                      name: 'Emma Smith',
                      age: '9 Years',
                    ),
                    const SizedBox(height: 24.0),
                    AddChildButton(
                      onTap: () {
                        print('Add new child button tapped!');
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              // ---------- State ----------
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  'state',
                  style: GoogleFonts.lato(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF474747),
                  ),
                ),
              ),
              CustomListTile(
                leadingSvgAsset: 'assets/images/profile/state.svg',
                title: 'Tennessee',
                trailingWidget: SvgPicture.asset(
                  'assets/images/settings/arrow.svg',
                ),
              ),

              // ---------- Court Mandated ----------
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  'I use of this app court mandated?',
                  style: GoogleFonts.lato(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF474747),
                  ),
                ),
              ),
              CustomListTile(
                leadingSvgAsset: 'assets/images/profile/court.svg',
                title: 'Yes, court mandated',
                trailingWidget: SvgPicture.asset(
                  'assets/images/settings/arrow.svg',
                ),
              ),

              SizedBox(height: 13.h),

              // ---------- Edit Button ----------
              Container(
                height: 45.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFBD9DED), Color(0xFF90CAE2)],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  ),
                  borderRadius: BorderRadius.circular(22.r),
                ),
                child: Center(
                  child: Text(
                    "Edit",
                    style: GoogleFonts.lato(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}
