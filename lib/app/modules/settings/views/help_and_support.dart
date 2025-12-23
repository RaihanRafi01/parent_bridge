import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parent_bridge/common/appColors.dart';
import '../../../../common/customFont.dart';
import '../controllers/help_support_controller.dart';

class HelpAndSupport extends StatelessWidget {
  HelpAndSupport({super.key});
  final HelpSupportController controller = Get.put(HelpSupportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_outlined,
            color: AppColors.clrBlack,
            size: 28.sp,
          ),
        ),
        title: Text(
          'Help & Support',
          style: h2.copyWith(
            // FontWeight.w600
            fontSize: 24.sp,
            color: AppColors.txtclr5,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 40.h),
            _buildToggleButtons(context),
            SizedBox(height: 40.h),
            Expanded(
              child: Obx(() {
                return controller.selectedTab.value == 0
                    ? const FaqSection()
                    : const ContactUsSection();
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButtons(BuildContext context) {
    return Obx(
      () => Container(
        height: 50.h,
        decoration: BoxDecoration(
          color: AppColors.clrWhite,
          border: Border.all(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(25.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.boxShadow.withOpacity(0.14),
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
              left: controller.selectedTab.value == 0
                  ? 0
                  : (MediaQuery.of(context).size.width - 40.w) / 2,
              child: Container(
                width: (MediaQuery.of(context).size.width - 40.w) / 2,
                height: 50.h,
                decoration: BoxDecoration(
                  color: AppColors.customblueclr,
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
                        style: h4.copyWith(
                          // FontWeight.w400
                          fontSize: 16.sp,
                          color: AppColors.txtclr5,
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
                        style: h4.copyWith(
                          // FontWeight.w400
                          fontSize: 16.sp,
                          color: AppColors.txtclr5,
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
      {
        'question': 'This is a test question 3',
        'answer': 'This is a test answer to make the content longer.',
      },
      {
        'question': 'This is a test question 4',
        'answer': 'This is a test answer to make the content longer.',
      },
    ];

    return ListView.builder(
      itemCount: faqs.length,
      itemBuilder: (context, index) => CustomExpansionTile(
        question: faqs[index]['question']!,
        answer: faqs[index]['answer']!,
      ),
    );
  }
}

class CustomExpansionTile extends StatefulWidget {
  final String question;
  final String answer;

  const CustomExpansionTile({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      decoration: BoxDecoration(
        color: AppColors.boxclr1,
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(50.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.borderColor,
            spreadRadius: 2,
            blurRadius: 15,
          ),
        ],
      ),
      child: Theme(
        data: ThemeData(dividerColor: Colors.transparent),
        child: ExpansionTile(
          onExpansionChanged: (bool expanded) {
            setState(() {
              _isExpanded = expanded;
            });
          },
          trailing: AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            firstChild: Icon(
              Icons.south_east,
              size: 20.sp,
              color: Colors.black54,
            ),
            secondChild: Icon(
              Icons.north_east,
              size: 20.sp,
              color: Colors.lightBlue,
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
          ),
          title: Text(
            widget.question,
            style: h3.copyWith(
              // FontWeight.w500
              color: AppColors.txtclr5,
              fontSize: 18.sp,
            ),
          ),
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.answer,
                  style: h4.copyWith(
                    // FontWeight.w400
                    color: AppColors.txtclr8,
                    height: 1.5,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactUsSection extends StatelessWidget {
  const ContactUsSection({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.clrWhite,
              borderRadius: BorderRadius.circular(30.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.boxShadow.withOpacity(0.14),
                  blurRadius: 15.r,
                  spreadRadius: 1.r,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: AppColors.iconclr,
                ),
                hintText: 'abc@email.com',
                hintStyle: h4.copyWith(
                  // FontWeight.w400
                  color: AppColors.textColorHint,
                  fontSize: 14.sp,
                ),
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
              borderRadius: BorderRadius.circular(30.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.boxShadow.withOpacity(0.14),
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
                hintStyle: h4.copyWith(
                  // FontWeight.w400
                  color: AppColors.textColorHint,
                  fontSize: 14.sp,
                ),
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
                colors: [AppColors.buttonColor, AppColors.buttonColor2],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Center(
              child: Text(
                'Send',
                style: h1.copyWith(
                  // FontWeight.bold is w700, so h1
                  color: AppColors.clrWhite,
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
