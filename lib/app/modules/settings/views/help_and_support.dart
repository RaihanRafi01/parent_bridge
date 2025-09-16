import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/help_support_controller.dart';

class HelpAndSupport extends StatelessWidget {
  HelpAndSupport({super.key});
  final HelpSupportController controller = Get.put(HelpSupportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Wrapped main Column with SingleChildScrollView
      // so that scrolling works when content overflows
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w), // responsive padding
          child: Column(
            children: [
              SizedBox(height: 50.h),
              // Custom App Bar
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
                    'Help & Support',
                    style: GoogleFonts.lato(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1D3856),
                    ),
                  ),
                  SizedBox(width: 28.w), // keep space on the right
                ],
              ),
              SizedBox(height: 30.h),

              _buildToggleButtons(context),

              SizedBox(height: 30.h),

              SizedBox(
                height: 0.6.sh, // responsive height (60% of screen height)
                child: Obx(() {
                  return controller.selectedTab.value == 0
                      ? const FaqSection()
                      : const ContactUsSection();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButtons(BuildContext context) {
    return Obx(
          () => Container(
        height: 50.h,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFEDEDED)),
          borderRadius: BorderRadius.circular(25.r),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.withOpacity(0.07),
              spreadRadius: 10,
              blurRadius: 10,
            ),
          ],
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              // half of total width (minus padding 40)
              left: controller.selectedTab.value == 0
                  ? 0
                  : (MediaQuery.of(context).size.width - 40.w) / 2,
              child: Container(
                width: (MediaQuery.of(context).size.width - 40.w) / 2,
                height: 50.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFB7E7FC),
                  borderRadius: BorderRadius.circular(25.r),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => controller.changeTab(0),
                    child: Center(
                      child: Text(
                        'FAQ Questions',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          color: const Color(0xFF1D3856),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => controller.changeTab(1),
                    child: Center(
                      child: Text(
                        'Contact Us',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          color: const Color(0xFF1D3856),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// FAQ Section
class FaqSection extends StatelessWidget {
  const FaqSection({super.key});
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> faqs = [
      {
        'question': 'Is this app free?',
        'answer':
        'CoParent AI is free during our beta period. After launch, we\'ll offer both free and premium tiers to ensure accessibility for all families.',
      },
      {'question': 'Is it legally safe?', 'answer': 'Yes, it is legally safe.'},
      {
        'question': 'Can both parents use the same account?',
        'answer': 'We recommend separate accounts for better personalization.',
      },
      {
        'question': 'How does the AI tone detection work?',
        'answer':
        'Our AI analyzes text patterns to detect the emotional tone of messages.',
      },
      {
        'question': 'When will the app be available?',
        'answer': 'The app will be available very soon. Stay tuned!',
      },
      {
        'question': 'What if my co-parent refuses to use the app?',
        'answer':
        'The app can still be used independently, including messaging features. In independent mode, a new number will be assigned to the co-parent using the app.',
      },
    ];
    return ListView.builder(
      itemCount: faqs.length,
      itemBuilder: (context, index) => _buildExpansionTile(
        question: faqs[index]['question']!,
        answer: faqs[index]['answer']!,
      ),
    );
  }

  Widget _buildExpansionTile({
    required String question,
    required String answer,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F8FF),
        border: Border.all(color: const Color(0xFFEDEDED)),
        borderRadius: BorderRadius.circular(50.r),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFFEDEDED), spreadRadius: 2, blurRadius: 15),
        ],
      ),
      child: Theme(
        data: ThemeData(dividerColor: Colors.transparent),
        child: ExpansionTile(
          iconColor: Colors.lightBlue,
          collapsedIconColor: Colors.black54,
          title: Text(
            question,
            style: TextStyle(
              color: const Color(0xFF1D3856),
              fontWeight: FontWeight.w500,
              fontSize: 18.sp,
            ),
          ),
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
              child: Text(
                answer,
                style: TextStyle(
                  color: const Color(0xFF363636),
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Contact Us Section
class ContactUsSection extends StatelessWidget {
  const ContactUsSection({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.r), // fully rounded
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFE0D7F1).withOpacity(0.6),
                  blurRadius: 15.r,
                  spreadRadius: 1.r,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon:
                Icon(Icons.email_outlined, color: Colors.grey[500]),
                hintText: 'abc@email.com',
                hintStyle: TextStyle(color: const Color(0xFF747688), fontSize: 14.sp),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.r), // fully rounded
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFE0D7F1).withOpacity(0.6),
                  blurRadius: 15.r,
                  spreadRadius: 1.r,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Explain the problem',
                hintStyle: TextStyle(color: const Color(0xFF747688), fontSize: 14.sp),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(height: 30.h),
          Container(
            width: double.infinity,
            height: 55.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.r),
              gradient: LinearGradient(
                colors: [Colors.blue.shade300, Colors.purple.shade300],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Center(
              child: Text(
                'Send',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
