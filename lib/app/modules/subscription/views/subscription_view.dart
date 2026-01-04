import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:parent_bridge/app/modules/home/views/home_view.dart';
import 'package:parent_bridge/common/app_colors.dart';
import 'package:parent_bridge/common/custom_font.dart';
import 'package:parent_bridge/common/widgets/custom_button.dart';

import '../controllers/subscription_controller.dart';

class SubscriptionView extends GetView<SubscriptionController> {
  const SubscriptionView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(SubscriptionController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgColor51,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10).r,
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.clrWhite,
              ),

              child: Icon(
                Icons.arrow_back_ios_outlined,
                color: AppColors.textColor51,
                size: 16.r,
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          'See attached subscription plan',
          style: h1.copyWith(
            color: AppColors.textColor51,
            fontSize: 22.5.sp,
          ),
        ),
      ),

      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.bgColor51,
                AppColors.bgColor52,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
          ),
        
          child: PageView(
            children: [
              ProSubscriptionCard(
                bgImage: 'assets/images/subscription/pro_bg.svg',
                title: '\nParentBridge Pro',
                titleColor: AppColors.textColor54,
                feePerMonth: 6.99,
                feePerYear: 76.89,
                featureImage: 'assets/images/subscription/subscription_feature.svg',
                featureList: controller.proFeatures,
                spaceBeforeButton: 68,
              ),
              ProSubscriptionCard(
                bgImage: 'assets/images/subscription/pro_plus_bg.svg',
                title: '\nParentBridge Pro(+)',
                titleColor: AppColors.textColor56,
                feePerMonth: 9.99,
                feePerYear: 109.89,
                featureImage: 'assets/images/subscription/subscription_feature2.svg',
                featureList: controller.proFeatures2,
                spaceBeforeButton: 48,
              ),
            ]
          ),
        ),
      ),
    );
  }
}

class ProSubscriptionCard extends StatelessWidget {
  final String bgImage;
  final String title;
  final Color titleColor;
  final double feePerMonth;
  final double feePerYear;
  final String featureImage;
  final List<String> featureList;
  final double spaceBeforeButton;

  const ProSubscriptionCard({
    required this.bgImage,
    required this.title,
    required this.titleColor,
    required this.feePerMonth,
    required this.feePerYear,
    required this.featureImage,
    required this.featureList,
    required this.spaceBeforeButton,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.r),
        child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              SvgPicture.asset(
                bgImage,
              ),

              Column(
                children: [
                  SizedBox(height: 80.h,),

                  Container(
                    padding: EdgeInsets.all(37.r),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.clrBlack.withAlpha(64),
                            blurRadius: 4.r,
                            offset: Offset(0.w, 4.h),
                          )
                        ]
                    ),
                    child: Column(
                      spacing: 16.h,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '$feePerMonth',
                                style: h0.copyWith(
                                  color: AppColors.textColor54,
                                  fontSize: 28.22.sp,
                                ),
                              ),
                              TextSpan(
                                text: '/month',
                                style: h0.copyWith(
                                  color: AppColors.textColor54,
                                  fontSize: 11.29.sp,
                                ),
                              ),
                            ],
                          ),
                        ),


                        SizedBox(
                          width: 124.w,
                          child: Text(
                            'Or purchase an annual subscription and save. Annual Subscription',
                            style: h1.copyWith(
                              color: AppColors.textColor52,
                              fontSize: 11.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '$feePerYear',
                                style: h0.copyWith(
                                  color: AppColors.textColor55,
                                  fontSize: 28.22.sp,
                                ),
                              ),
                              TextSpan(
                                text: '/year',
                                style: h0.copyWith(
                                  color: AppColors.textColor55,
                                  fontSize: 11.29.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Text(
                    title,
                    style: h1.copyWith(
                      color: titleColor,
                      fontSize: 30.sp,
                    ),
                  ),

                  SizedBox(height: 18.h,),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 23.0.w),
                    child: Column(
                      spacing: 24.h,
                      children: featureList.map((feature) {
                        return SubscriptionFeature(
                          image: featureImage,
                          text: feature,
                        );
                      }).toList(),

                    ),
                  ),

                  //SizedBox(height: 20.h,),

                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: CustomPBButton(
                      text: 'Buy Now',
                      color1: AppColors.buttonColor51,
                      color2: AppColors.buttonColor52,
                      onPressed: () => Get.to(HomeView()),
                    ),
                  ),
                  SizedBox(height: 30.h)
                ],
              )
            ]
        ),
      ),
    );
  }
}


class SubscriptionFeature extends StatelessWidget {
  final String image;
  final String text;

  const SubscriptionFeature({
    required this.image,
    required this.text,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10.w,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          image,
        ),

        Expanded(
          child: Text(
            text,
            style: h3.copyWith(
              color: AppColors.textColor52,
              fontSize: 14.sp,
            ),
          ),
        )
      ],
    );
  }
}
