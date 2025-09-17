import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../common/appColors.dart';
import '../../../../common/customFont.dart';
import '../../../../common/widgets/home/add_child_button.dart';
import '../../../../common/widgets/home/child_info_tile.dart';
import '../../../../common/widgets/home/styledTextField.dart';
//import '../../../../common/widgets/styled_text_field.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController =
    TextEditingController(text: 'Michael Smith');
    final TextEditingController emailController =
    TextEditingController(text: 'michaelsmith@gmail.com');
    final TextEditingController contactController =
    TextEditingController(text: '+881 01405366393');
    final TextEditingController passwordController =
    TextEditingController(text: 'password');

    final BoxDecoration styledContainerDecoration = BoxDecoration(
      color: AppColors.clrWhite,
      borderRadius: BorderRadius.circular(24.0),
      border: Border.all(
        color: AppColors.boxShadowColor,
        width: 0.5,
      ),
      boxShadow: [
        BoxShadow(
          color: AppColors.boxShadowColor.withOpacity(0.14),
          spreadRadius: 0,
          blurRadius: 12.6,
          offset: const Offset(0, 8),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: AppColors.clrWhite,
      appBar: AppBar(
        backgroundColor:AppColors.clrWhite,
        elevation:  0,
        scrolledUnderElevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
            size: 28,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Profile',
          style: h2.copyWith(
            fontSize: 28.sp,
            color: AppColors.darkSlateBlue,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),
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
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: AppColors.pchangeButtonclr,
                           border: Border.all( color: AppColors.customblueclr, width: 1.0.w),
                          borderRadius: BorderRadius.circular(10.r),


                        ),
                        child: Text(
                          'Change Picture',
                          style: h3.copyWith(
                            fontSize: 12.sp,
                            color: AppColors.txtclr2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              StyledTextField(
                label: 'Full name',
                svgAsset: 'assets/images/settings/profile.svg',
                controller: nameController,
                decoration: styledContainerDecoration,
              ),
              StyledTextField(
                label: 'Email',
                svgAsset: 'assets/images/profile/mail.svg',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: styledContainerDecoration,
              ),
              StyledTextField(
                label: 'Contact number',
                svgAsset: 'assets/images/profile/contact.svg',
                controller: contactController,
                keyboardType: TextInputType.phone,
                decoration: styledContainerDecoration,
              ),
              StyledTextField(
                label: 'Password',
                svgAsset: 'assets/images/profile/pass.svg',
                controller: passwordController,
                isPassword: true,
                decoration: styledContainerDecoration,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  'child’s (2)',
                  style: h2.copyWith(
                    fontSize: 18.sp,
                    color: AppColors.txtclr4,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: styledContainerDecoration,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child: const ChildInfoTile(
                        index: '1',
                        name: 'Max Smith',
                        age: '8 Years',
                      ),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.boxShadowColor.withOpacity(0.14),
                            spreadRadius: 0,
                            blurRadius:  12.6,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Container(
                      child: const ChildInfoTile(
                        index: '2',
                        name: 'Emma Smith',
                        age: '9 Years',
                      ),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.boxShadowColor.withOpacity(0.14),
                            spreadRadius: 0,
                            blurRadius:  12.6,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    Container(
                      child: AddChildButton(
                        onTap: () {
                          print('Add new child button tapped!');
                        },
                      ),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.boxShadowColor.withOpacity(0.16),
                            spreadRadius: 0,
                            blurRadius:  12.6,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              StyledTextField(
                label: 'State',
                svgAsset: 'assets/images/profile/state.svg',
                initialValue: 'Tennessee',
                readOnly: true,
                decoration: styledContainerDecoration,
              ),
              StyledTextField(
                label: 'Is use of this app court mandated?',
                svgAsset: 'assets/images/profile/court.svg',
                initialValue: 'Yes, court mandated',
                readOnly: true,
                decoration: styledContainerDecoration,
              ),
              SizedBox(height: 24.h),
              InkWell(
                onTap: () {
                  print('Edit button tapped');
                },
                child: Container(
                  height: 45.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [ AppColors.buttonColor2,AppColors.buttonColor,],
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                    ),
                    borderRadius: BorderRadius.circular(22.r),
                  ),
                  child: Center(
                    child: Text(
                      "Edit",
                      style: h2.copyWith(
                        fontSize: 18.sp,
                        color: AppColors.clrWhite,
                      ),
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