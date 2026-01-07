// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:parent_bridge/common/app_colors.dart';
//
// import '../common/custom_anonymous_parent.dart';
// import '../show_dialog/show_dialog_page.dart';
//
// class anonymous_parent_section extends StatelessWidget {
//   const anonymous_parent_section({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             /// anonymous parent part ...
//             custom_anonymous_parent(
//               sche_title: 'Scheduling',
//               color: AppColors.anonymous_parent_01,
//               bg_color: AppColors.anonymous_parent_02,
//
//               body_title: 'How do you handle holiday scheduling conflicts?',
//               body_subtitle:
//                   'My co-parent frequently changes plans at the last minute, which creates a lot of stress and confusion, especially for the children. see more .',
//               threeDot_ontap: () {},
//               dialog_ontap: () {
//                 // this is for show diolog message ..
//                 Get.dialog(
//                   show_dialog(
//                     color:AppColors.anonymous_parent_01,
//                     body_title: 'How do you handle holiday scheduling conflicts?',
//                     dialog_subtitle:
//                         'One of the most difficult aspects of co-parenting has been dealing with last-minute changes made by my co-parent.'
//                         ' While occasional flexibility is understandable and sometimes necessary,'
//                         ' the frequent and unpredictable nature of these changes creates ongoing challenges.'
//                         ' It disrupts not only my personal and professional schedule but, more importantly,'
//                         ' the emotional and mental stability of our children. Children thrive on routine,'
//                         ' predictability, and consistency. '
//                         'When plans are constantly changed at the eleventh hour—without adequate notice or discussion—it creates confusion, '
//                         'disappointment, and anxiety for them. They often look forward to certain activities or time with each parent,'
//                         'and when those expectations aren’t met due to sudden changes, it can erode their sense of trust and emotional securit '
//                         'As a co-parent, I strongly believe that communication and mutual respect are the cornerstones of a successful co-parenting relationship. '
//                         'When one parent consistently alters arrangements without considering the impact on the other parent or the children,'
//                         ' it sets a harmful precedent. It sends the message that one parent’s time and emotional input are less valuable, '
//                         'which is neither fair nor sustainable. This kind of behavior forces the other parent to scramble, reschedule,'
//                         ' and manage the children’s reactions—all of which can be emotionally draining. In many cases, I’ve had',
//                   ),
//                   barrierColor: AppColors.anonymous_parent_03.withOpacity(.6),
//                 );
//               },
//             ),
//
//             SizedBox(height: 20),
//             custom_anonymous_parent(
//               sche_title: 'Parenting',
//               color: AppColors.controler_list_color_11,
//               bg_color: AppColors.anonymous_parent_04,
//
//               body_title: 'Dealing with different parenting styles',
//               body_subtitle:
//                   'One ongoing challenge is that my co-parent frequently changes plans at the last minute, '
//                   'which creates instability for both me and the child.'
//                   ' Clear and consistent scheduling is important, especially for co-parents .',
//               threeDot_ontap: () {},
//               dialog_ontap: () {},
//             ),
//             SizedBox(height: 20),
//             custom_anonymous_parent(
//               sche_title: 'Scheduling',
//               color: AppColors.anonymous_parent_05,
//               bg_color: AppColors.anonymous_parent_06,
//               body_title: 'Success story ,Communication improvement',
//               body_subtitle:
//                   'One of our biggest successes as co-parents has been improving our communication. In the beginning, we often misunderstood each other .',
//               threeDot_ontap: () {},
//               dialog_ontap: () {},
//             ),
//             SizedBox(height: 20),
//             custom_anonymous_parent(
//               sche_title: 'Scheduling',
//               color: AppColors.anonymous_parent_07,
//               bg_color: AppColors.anonymous_parent_08,
//               body_title: 'The Foundation of Successful Co-Parenting',
//               body_subtitle:
//                   'One of our biggest successes as co-parents has been improving our communication. In the beginning, we often misunderstood each other . .',
//               threeDot_ontap: () {},
//               dialog_ontap: () {},
//             ),
//             SizedBox(height: 130.h),
//           ],
//         ),
//       ),
//     );
//   }
// }
