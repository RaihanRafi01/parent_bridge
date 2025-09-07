import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:parent_bridge/common/appColors.dart';
import 'package:parent_bridge/common/customFont.dart';
import 'package:parent_bridge/common/widgets/customButton.dart';
import 'package:parent_bridge/common/widgets/customTextField.dart';

class BridgeModeView extends GetView {
  final RxBool isSendInvite;
  final TextEditingController coParentsNameController;
  final TextEditingController phoneNumberController;
  final TextEditingController emailAddressController;
  final TextEditingController stateController;

  const BridgeModeView({
    required this.isSendInvite,
    required this.coParentsNameController,
    required this.phoneNumberController,
    required this.emailAddressController,
    required this.stateController,
    super.key
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.r,),
          child: Obx(() {
            return Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50.h,),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 25.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    gradient: LinearGradient(
                      colors: [
                        AppColors.buttonColor,
                        AppColors.buttonColor2,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )
                  ),
                  child: Column(
                    spacing: 8.h,
                    children: [
                      Image.asset(
                        'assets/images/sign_up_process/bridge_mode.png',
                        scale: 2,
                      ),

                      Text(
                        'Bridge Mode',
                        style: h1.copyWith(
                          color: AppColors.clrWhite,
                          fontSize: 20.sp,
                        ),
                      ),

                      Text(
                        'Add your co-parent to start communicating. You can call them right away, and they\'ll get an invitation to join for full app features like shared calendars and filtered messaging.',
                        style: h4.copyWith(
                          color: AppColors.clrWhite,
                          fontSize: 12.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 33.h,),

                Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: AppColors.clrWhite,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.clrBlack.withAlpha(64),
                        blurRadius: 4.r,
                        offset: Offset(1.w, 1.h),
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          isSendInvite.value = false;
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 53.w, vertical: 14.h,),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              gradient: LinearGradient(
                                colors: [
                                  isSendInvite.value ? AppColors.clrTransparent : AppColors.buttonColor,
                                  isSendInvite.value ? AppColors.clrTransparent : AppColors.buttonColor2,
                                ],
                              )
                          ),
                          child: Text(
                            'Co-Parent',
                            style: h2.copyWith(
                              color: AppColors.textColor51,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),



                      GestureDetector(
                        onTap: () {
                          isSendInvite.value = true;
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 53.w, vertical: 14.h,),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            gradient: LinearGradient(
                              colors: [
                                isSendInvite.value ? AppColors.buttonColor : AppColors.clrTransparent,
                                isSendInvite.value ? AppColors.buttonColor2 : AppColors.clrTransparent,
                              ],
                            )
                          ),
                          child: Text(
                            'Send invite',
                            style: h2.copyWith(
                              color: AppColors.textColor51,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 43.h,),

                isSendInvite.value ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Share Invite Link',
                      style: h3.copyWith(
                        color: AppColors.textColor51,
                        fontSize: 19.sp,
                      ),
                    ),

                    SizedBox(height: 23.52.h,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 340.w,
                          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 15.h,),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9.8.r),
                              color: AppColors.card51,
                              border: Border.all(
                                color: AppColors.borderColor52,
                                width: 0.98.r,
                              )
                          ),
                          child: Text(
                            'https://parentbridge.app/invite/abc123xyz',
                            style: h3.copyWith(
                              color: AppColors.textColor51,
                              fontSize: 15.54.sp,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        Container(
                          width: 51.w,
                          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 15.h,),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9.8.r),
                              color: AppColors.card51,
                              border: Border.all(
                                color: AppColors.borderColor52,
                                width: 0.98.r,
                              )
                          ),
                          child: SvgPicture.asset(
                              'assets/images/sign_up_process/copy.svg'
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 48.h,),

                    CustomPBButton(
                      text: 'Copy & Share Link',
                      icon: 'assets/images/sign_up_process/share.svg',
                      onPressed: () {  },
                    ),
                  ],
                )

                :

                SizedBox(
                  height: 548.h,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Add Co-parent Contact',
                          style: h1.copyWith(
                            color: AppColors.textColor51,
                            fontSize: 22.sp,
                          ),
                        ),

                        SizedBox(height: 8.h,),

                        Text(
                          'Add their contact info to start calling immediately.',
                          style: h4.copyWith(
                            color: AppColors.textColor52,
                            fontSize: 14.sp,
                          ),
                        ),

                        SizedBox(height: 39.h,),

                        CustomTextField(
                          hintText: 'Co-parent\'s name',
                          prefixIcon: 'assets/images/sign_up_process/co_parent.svg',
                          controller: coParentsNameController,
                        ),

                        CustomTextField(
                          hintText: 'Phone number',
                          prefixIcon: 'assets/images/sign_up_process/phone_number.svg',
                          controller: phoneNumberController,
                        ),

                        CustomTextField(
                          hintText: 'Email address',
                          prefixIcon: 'assets/images/sign_up_process/email.svg',
                          controller: emailAddressController,
                        ),

                        CustomTextField(
                          hintText: 'Enter your state',
                          prefixIcon: 'assets/images/sign_up_process/state.svg',
                          controller: stateController,
                        ),

                        SizedBox(height: 48.h,),

                        CustomPBButton(
                          text: 'Send Invited',
                          icon: 'assets/images/sign_up_process/share.svg',
                          onPressed: () {  },
                        ),

                        SizedBox(height: 40.h,),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
