import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For ScreenUtil
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_bridge/app/modules/settings/views/settings_view.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 22.w), // responsive padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h), // top spacing
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back_outlined,
                      color: Colors.black,
                      size: 28.sp, // responsive icon size
                    ),
                  ),
                  Text(
                    'ParentBridge Privacy Policy',
                    style: GoogleFonts.lato(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1D3856),
                    ),
                  ),
                  SizedBox(width: 28.w), // right side spacing
                ],
              ),
              SizedBox(height: 24.h), // spacing before content
              Padding(
                padding: EdgeInsets.only(left: 9.w),
                child: Text(
                  'Effective 06/16/2023',
                  style: GoogleFonts.lato(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsets.only(left: 9.w),
                child: Text(
                  'ParentBridge values your privacy. This Privacy Policy explains how we collect, use, and protect your information when you use our services. By using ParentBridge, you agree to the practices described below.',
                  style: GoogleFonts.lato(
                    fontSize: 16.sp,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // Section 1
              _buildSectionTitle('1. Information We Collect'),
              SizedBox(height: 8.h),
              Text(
                'We may collect the following types of information:',
                style: GoogleFonts.lato(fontSize: 16.sp, color: Colors.black87),
              ),
              SizedBox(height: 8.h),
              _buildBulletPoint(context, 'Account Information: Name, Email, Phone, Login Credentials.'),
              _buildBulletPoint(context, 'Communication Data: Messages, documents, and shared information entered into the App.'),
              _buildBulletPoint(context, 'Call & Recording Data (if enabled): Audio files, transcripts, and related metadata.'),
              _buildBulletPoint(context, 'Device & Usage Data: IP address, device type, app usage logs, cookies, crash reports.'),
              _buildBulletPoint(context, 'Payment Information: Processed securely by third-party payment providers (we do not store credit card numbers).'),

              SizedBox(height: 16.h),

              // Section 2
              _buildSectionTitle('2. How We Use Your Information'),
              SizedBox(height: 8.h),
              _buildBulletPoint(context, 'Provide and improve the App’s features,'),
              _buildBulletPoint(context, 'Power AI message filtering, formatting, and communication tools,'),
              _buildBulletPoint(context, 'Deliver subscription services and customer support,'),
              _buildBulletPoint(context, 'Enhance security, prevent misuse, and enforce our Terms,'),
              _buildBulletPoint(context, 'Comply with applicable legal obligations.'),

              SizedBox(height: 16.h),

              // Section 3
              _buildSectionTitle('3. AI Processing'),
              SizedBox(height: 8.h),
              Text(
                'ParentBridge uses artificial intelligence to filter and reframe messages. This process may involve temporarily analyzing your communication content. AI processing is automated, and we do not manually review your private communications unless legally required or for technical troubleshooting.',
                style: GoogleFonts.lato(fontSize: 16.sp, color: Colors.black87),
              ),

              SizedBox(height: 16.h),

              // Section 4
              _buildSectionTitle('4. Recording Features'),
              SizedBox(height: 8.h),
              Text(
                'If you choose to enable call or voice recording:',
                style: GoogleFonts.lato(fontSize: 16.sp, color: Colors.black87),
              ),
              SizedBox(height: 8.h),
              _buildBulletPoint(context, 'Consent is required by law, and laws vary by jurisdiction. It is your responsibility to obtain consent from all parties before recording.'),
              _buildBulletPoint(context, 'ParentBridge does not guarantee that recordings or transcripts are legally admissible in court. Consult an attorney for guidance.'),
              _buildBulletPoint(context, 'You may disable recording features at any time.'),

              SizedBox(height: 16.h),

              // Section 5
              _buildSectionTitle('5. Data Sharing'),
              SizedBox(height: 8.h),
              Text(
                'We do not sell Personal Information. We may share only with:',
                style: GoogleFonts.lato(fontSize: 16.sp, color: Colors.black87),
              ),
              SizedBox(height: 8.h),
              _buildBulletPoint(context, 'Service Providers (e.g., hosting, payment, or AI processing partners).'),
              _buildBulletPoint(context, 'Legal Authorities (if required by law, court order, or to protect rights and safety).'),
              _buildBulletPoint(context, 'Business Transfers (if ParentBridge merges, acquires, or is acquired).'),

              SizedBox(height: 16.h),

              // Section 6
              _buildSectionTitle('6. Data Security'),
              SizedBox(height: 8.h),
              Text(
                'We implement encryption and security safeguards to protect your data. However, no system is 100% secure. You are encouraged to maintain secure passwords and protect your devices.',
                style: GoogleFonts.lato(fontSize: 16.sp, color: Colors.black87),
              ),

              SizedBox(height: 16.h),

              // Section 7
              _buildSectionTitle('7. Data Retention'),
              SizedBox(height: 8.h),
              Text(
                'We retain your data as long as your account is active or needed to provide services. You may request account deletion, after which we will delete or anonymize your personal data, unless required by law to retain it.',
                style: GoogleFonts.lato(fontSize: 16.sp, color: Colors.black87),
              ),

              SizedBox(height: 16.h),

              // Section 8
              _buildSectionTitle('8. Children\'s Privacy'),
              SizedBox(height: 8.h),
              Text(
                'ParentBridge is not intended for children under 13 (or under the minimum legal age in your jurisdiction). We do not knowingly collect personal information from children.',
                style: GoogleFonts.lato(fontSize: 16.sp, color: Colors.black87),
              ),

              SizedBox(height: 16.h),

              // Section 9
              _buildSectionTitle('9. Your Rights'),
              SizedBox(height: 8.h),
              Text(
                'Depending on your location, you may have the right to:',
                style: GoogleFonts.lato(fontSize: 16.sp, color: Colors.black87),
              ),
              SizedBox(height: 8.h),
              _buildBulletPoint(context, 'Access, update, or delete your data.'),
              _buildBulletPoint(context, 'Opt out of marketing communications.'),
              _buildBulletPoint(context, 'Request data portability.'),
              _buildBulletPoint(context, 'File complaints with a data protection authority.'),

              SizedBox(height: 16.h),

              // Section 10
              _buildSectionTitle('10. Updates to This Policy'),
              SizedBox(height: 8.h),
              Text(
                'We may update this Privacy Policy from time to time. Users will be notified of material changes, and continued use of the App indicates acceptance of the updated policy.',
                style: GoogleFonts.lato(fontSize: 16.sp, color: Colors.black87),
              ),

              SizedBox(height: 16.h),

              // Section 11
              _buildSectionTitle('11. Contact'),
              SizedBox(height: 8.h),
              Text(
                'If you have questions about this privacy policy, contact us at privacy@parentbridge.com',
                style: GoogleFonts.lato(fontSize: 16.sp, color: Colors.black87),
              ),

              SizedBox(height: 20.h), // bottom spacing
            ],
          ),
        ),
      ),
    );
  }

  // Reusable Section Title
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.lato(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  // Reusable Bullet Point
  Widget _buildBulletPoint(BuildContext context, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '• ',
          style: GoogleFonts.lato(color: Colors.black, fontSize: 16.sp),
        ),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.lato(fontSize: 16.sp, color: Colors.black87),
          ),
        ),
      ],
    );
  }
}
