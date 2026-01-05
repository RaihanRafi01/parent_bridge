import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parent_bridge/app/core/constants/api.dart';

import '../../../../common/appColors.dart';
import '../../../../common/customFont.dart';
import '../../../../common/widgets/home/add_child_button.dart';
import '../../../../common/widgets/home/child_info_tile.dart';
import '../../../../common/widgets/home/styledTextField.dart';
import '../controllers/settings_controller.dart';

class Profile extends GetView<SettingsController> {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordController = TextEditingController(
      text: '********',
    );

    final BoxDecoration styledContainerDecoration = BoxDecoration(
      color: AppColors.clrWhite,
      borderRadius: BorderRadius.circular(24.0),
      border: Border.all(color: AppColors.boxShadowColor, width: 0.5),
      boxShadow: [
        BoxShadow(
          color: AppColors.boxShadowColor.withValues(alpha: 0.14),
          spreadRadius: 0,
          blurRadius: 12.6,
          offset: const Offset(0, 8),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: AppColors.clrWhite,
      appBar: AppBar(
        backgroundColor: AppColors.clrWhite,
        elevation: 0,
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
          style: h2.copyWith(fontSize: 28.sp, color: AppColors.darkSlateBlue),
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
                      GestureDetector(
                        onTap: () => controller.pickImage(),
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 40.r,
                              backgroundColor: Colors.grey,
                              child: ClipOval(
                                child: Obx(() {
                                  if (controller.selectedImage.value != null) {
                                    return Image.file(
                                      controller.selectedImage.value!,
                                      fit: BoxFit.cover,
                                      width: 80.r,
                                      height: 80.r,
                                    );
                                  } else if (controller
                                      .profileImage
                                      .value
                                      .isNotEmpty) {
                                    String imageUrl =
                                        controller.profileImage.value;
                                    if (!imageUrl.startsWith('http')) {
                                      imageUrl = '${Api.baseUrl}$imageUrl';
                                    }
                                    return Image.network(
                                      imageUrl,
                                      fit: BoxFit.cover,
                                      width: 80.r,
                                      height: 80.r,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Image.asset(
                                                'assets/images/auth/img.png',
                                                fit: BoxFit.cover,
                                                width: 80.r,
                                                height: 80.r,
                                              ),
                                    );
                                  } else {
                                    return Image.asset(
                                      'assets/images/auth/img.png',
                                      fit: BoxFit.cover,
                                      width: 80.r,
                                      height: 80.r,
                                    );
                                  }
                                }),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(4.r),
                                decoration: BoxDecoration(
                                  color: AppColors.appColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 16.r,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.pchangeButtonclr,
                          border: Border.all(
                            color: AppColors.customblueclr,
                            width: 1.0.w,
                          ),
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
                controller: controller.nameController,
                decoration: styledContainerDecoration,
              ),
              StyledTextField(
                label: 'Email',
                svgAsset: 'assets/images/profile/mail.svg',
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: styledContainerDecoration,
              ),
              StyledTextField(
                label: 'Contact number',
                svgAsset: 'assets/images/profile/contact.svg',
                controller: controller.phoneController,
                keyboardType: TextInputType.phone,
                decoration: styledContainerDecoration,
              ),
              GestureDetector(
                onTap: () {
                  _showChangePasswordDialog(context);
                },
                child: AbsorbPointer(
                  child: StyledTextField(
                    label: 'Password',
                    svgAsset: 'assets/images/profile/pass.svg',
                    controller: passwordController,
                    isPassword: true,
                    decoration: styledContainerDecoration,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Obx(
                  () => Text(
                    'child’s (${controller.profileChildren.length})',
                    style: h2.copyWith(
                      fontSize: 18.sp,
                      color: AppColors.txtclr4,
                    ),
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
                    Obx(
                      () => Column(
                        children: controller.profileChildren
                            .asMap()
                            .entries
                            .map((entry) {
                              int idx = entry.key;
                              var child = entry.value;
                              return Container(
                                margin: const EdgeInsets.only(bottom: 16.0),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.boxShadowColor
                                          .withValues(alpha: 0.14),
                                      spreadRadius: 0,
                                      blurRadius: 12.6,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: ChildInfoTile(
                                  index: '${idx + 1}',
                                  name: child['name'] ?? 'Child ${idx + 1}',
                                  age: child['age'] != null
                                      ? '${child['age']} Years'
                                      : '',
                                ),
                              );
                            })
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.boxShadowColor.withValues(
                              alpha: 0.16,
                            ),
                            spreadRadius: 0,
                            blurRadius: 12.6,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: AddChildButton(
                        onTap: () {
                          print('Add new child button tapped!');
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              StyledTextField(
                label: 'State',
                svgAsset: 'assets/images/profile/state.svg',
                controller: controller.stateController,
                readOnly: true,
                decoration: styledContainerDecoration,
              ),
              StyledTextField(
                label: 'Is use of this app court mandated?',
                svgAsset: 'assets/images/profile/court.svg',
                controller: controller.courtMandatedController,
                readOnly: true,
                decoration: styledContainerDecoration,
              ),
              SizedBox(height: 24.h),
              InkWell(
                onTap: () {
                  controller.updateProfile();
                },
                child: Container(
                  height: 45.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.buttonColor2, AppColors.buttonColor],
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

  void _showChangePasswordDialog(BuildContext context) {
    final oldPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text("Change Password"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: oldPasswordController,
              decoration: const InputDecoration(labelText: "Old Password"),
              obscureText: true,
            ),
            TextField(
              controller: newPasswordController,
              decoration: const InputDecoration(labelText: "New Password"),
              obscureText: true,
            ),
            TextField(
              controller: confirmPasswordController,
              decoration: const InputDecoration(
                labelText: "Confirm New Password",
              ),
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              if (newPasswordController.text !=
                  confirmPasswordController.text) {
                Get.snackbar(
                  "Error",
                  "Passwords do not match",
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
                return;
              }
              if (newPasswordController.text.isEmpty) {
                Get.snackbar(
                  "Error",
                  "Password cannot be empty",
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
                return;
              }
              controller.changePassword(
                oldPasswordController.text,
                newPasswordController.text,
              );
            },
            child: const Text("Change"),
          ),
        ],
      ),
    );
  }
}
