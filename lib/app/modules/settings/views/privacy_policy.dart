import 'package:flutter/material.dart';
import 'package:parent_bridge/common/app_colors.dart';

import '../../../../common/custom_font.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation:  0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            color:AppColors.clrBlack,
            size: 28.sp,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'ParentBridge Privacy Policy',
          style: h2.copyWith(
            fontSize: 24.sp,
            color:AppColors.txtclr5,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        titleSpacing: 0, // Reduces default spacing
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.only(left: 9.w),
              child: Text(
                'Effective 06/16/2023',
                style: h2.copyWith( // Using h2 for bold text
                  fontSize: 16.sp,
                  color: AppColors.txtclr5,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.only(left: 9.w),
              child: Text(
                'ParentBridge values your privacy. This Privacy Policy explains how we collect, use, and protect your information when you use our services. By using ParentBridge, you agree to the practices described below.',
                style: h4.copyWith( // Using h4 for regular text
                  fontSize: 12.sp,
                  color: AppColors.txtclr6,
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // Section 1
            _buildSectionTitle('1. Information We Collect'),
            SizedBox(height: 8.h),
            Text(
              'We may collect the following types of information:',
              style: h4.copyWith(fontSize: 14.sp,  color: AppColors.txtclr5,),
            ),
            SizedBox(height: 8.h),
            _buildBulletPoint('Account Information: Name, Email, Phone, Login Credentials.'),
            _buildBulletPoint('Communication Data: Messages, documents, and shared information entered into the App.'),
            _buildBulletPoint('Call & Recording Data (if enabled): Audio files, transcripts, and related metadata.'),
            _buildBulletPoint('Device & Usage Data: IP address, device type, app usage logs, cookies, crash reports.'),
            _buildBulletPoint('Payment Information: Processed securely by third-party payment providers (we do not store credit card numbers).'),

            SizedBox(height: 16.h),

            // Section 2
            _buildSectionTitle('2. How We Use Your Information'),
            SizedBox(height: 8.h),
            Text(
              'We use your data to:',
              style: h4.copyWith(fontSize: 14.sp,  color: AppColors.txtclr5,),
            ),
            SizedBox(height: 8.h),
            _buildBulletPoint('Provide and improve the App’s features,'),
            _buildBulletPoint('Power AI message filtering, formatting, and communication tools,'),
            _buildBulletPoint('Deliver subscription services and customer support,'),
            _buildBulletPoint('Enhance security, prevent misuse, and enforce our Terms,'),
            _buildBulletPoint('Comply with applicable legal obligations.'),

            SizedBox(height: 16.h),

            // Section 3
            _buildSectionTitle('3. AI Processing'),
            SizedBox(height: 8.h),
            Text(
              'ParentBridge uses artificial intelligence to filter and reframe messages. This process may involve temporarily analyzing your communication content. AI processing is automated, and we do not manually review your private communications unless legally required or for technical troubleshooting.',
              style: h4.copyWith(fontSize: 10.sp,    color: AppColors.txtclr6,),
            ),

            SizedBox(height: 16.h),

            // Section 4
            _buildSectionTitle('4. Recording Features'),
            SizedBox(height: 8.h),
            Text(
              'If you choose to enable call or voice recording:',
              style: h4.copyWith(fontSize: 14.sp,    color: AppColors.txtclr6,),
            ),
            SizedBox(height: 8.h),
            _buildBulletPoint('Consent is required by law, and laws vary by jurisdiction. It is your responsibility to obtain consent from all parties before recording.'),
            _buildBulletPoint('ParentBridge does not guarantee that recordings or transcripts are legally admissible in court. Consult an attorney for guidance.'),
            _buildBulletPoint('You may disable recording features at any time.'),

            SizedBox(height: 16.h),

            // Section 5
            _buildSectionTitle('5. Data Sharing'),
            SizedBox(height: 8.h),
            Text(
              'We do not sell Personal Information. We may share only with:',
              style: h4.copyWith(fontSize: 14.sp,    color: AppColors.txtclr5,),
            ),
            SizedBox(height: 8.h),
            _buildBulletPoint('Service Providers (e.g., hosting, payment, or AI processing partners).'),
            _buildBulletPoint('Legal Authorities (if required by law, court order, or to protect rights and safety).'),
            _buildBulletPoint('Business Transfers (if ParentBridge merges, acquires, or is acquired).'),

            SizedBox(height: 16.h),

            // Section 6
            _buildSectionTitle('6. Data Security'),
            SizedBox(height: 8.h),
            Text(
              'We implement encryption and security safeguards to protect your data. However, no system is 100% secure. You are encouraged to maintain secure passwords and protect your devices.',
              style: h4.copyWith(fontSize: 10.sp,    color: AppColors.txtclr6,),
            ),

            SizedBox(height: 16.h),

            // Section 7
            _buildSectionTitle('7. Data Retention'),
            SizedBox(height: 8.h),
            Text(
              'We retain your data as long as your account is active or needed to provide services. You may request account deletion, after which we will delete or anonymize your personal data, unless required by law to retain it.',
              style: h4.copyWith(fontSize: 10.sp,   color: AppColors.txtclr6,),
            ),

            SizedBox(height: 16.h),

            // Section 8
            _buildSectionTitle('8. Children\'s Privacy'),
            SizedBox(height: 8.h),
            Text(
              'ParentBridge is not intended for children under 13 (or under the minimum legal age in your jurisdiction). We do not knowingly collect personal information from children.',
              style: h4.copyWith(fontSize: 10.sp,    color: AppColors.txtclr6,),
            ),

            SizedBox(height: 16.h),

            // Section 9
            _buildSectionTitle('9. Your Rights'),
            SizedBox(height: 8.h),
            Text(
              'Depending on your location, you may have the right to:',
              style: h4.copyWith(fontSize: 14.sp,    color: AppColors.txtclr5,),
            ),
            SizedBox(height: 8.h),
            _buildBulletPoint('Access, update, or delete your data.'),
            _buildBulletPoint('Opt out of marketing communications.'),
            _buildBulletPoint('Request data portability.'),
            _buildBulletPoint('File complaints with a data protection authority.'),
            RichText(
              text: TextSpan(
                style: h4.copyWith(fontSize: 13.sp, color: AppColors.txtclr6),
                children: [
                  const TextSpan(
                    text: 'Requests may be made via ',
                  ),
                  TextSpan(
                    text: 'myparentbridge@gmail.com',
                    style: h4.copyWith(
                      fontSize: 13.sp,
                      color: AppColors.txtclr7,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),


            SizedBox(height: 16.h),

            // Section 10
            _buildSectionTitle('10. Updates to This Policy'),
            SizedBox(height: 8.h),
            Text(
              'We may update this Privacy Policy from time to time. Users will be notified of material changes, and continued use of the App indicates acceptance of the updated policy.',
              style: h4.copyWith(fontSize: 16.sp,    color: AppColors.txtclr6,),
            ),

            SizedBox(height: 16.h),

            // Section 11
            _buildSectionTitle('11. Contact'),
            SizedBox(height: 8.h),
            RichText(
              text: TextSpan(
                style: h4.copyWith(fontSize: 13.sp, color: AppColors.txtclr6),
                children: [
                  const TextSpan(
                    text:
                    'If you have questions about this privacy policy, please contact us : ',
                  ),
                  TextSpan(
                    text: 'myparentbridge@gmail.com',
                    style: h4.copyWith(
                      fontSize: 13.sp,
                      color: AppColors.txtclr7, // 👉 এখানে আলাদা কালার দাও
                      fontWeight: FontWeight.bold,   // চাইলে আলাদা স্টাইলও দিতে পারো
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }

  // Reusable Section Title
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: h2.copyWith( // Using h2 for bold text
        fontSize: 16.sp,
          color: AppColors.txtclr5,
      ),
    );
  }

  // Reusable Bullet Point
  Widget _buildBulletPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '• ',
          style: h4.copyWith(   color: AppColors.txtclr5, fontSize: 13.sp),
        ),
        Expanded(
          child: Text(
            text,
            style: h4.copyWith(fontSize: 13.sp,    color: AppColors.txtclr6,),
          ),
        ),

      ],
    );
  }
}