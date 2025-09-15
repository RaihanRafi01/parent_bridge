import 'package:get/get.dart';
import 'package:parent_bridge/common/appColors.dart';

class SupportForumController extends GetxController {
  // list for dropdown menu .. 
  var selectedValue = RxnString();  // can start with null value ...
  final List<Map<String,dynamic>> items = [
    {'name':'Scheduling', 'color':AppColors.controler_list_color_00,'fcolor':AppColors.controler_list_color_01},
    {'name':'Parenting', 'color':AppColors.controler_list_color_10,'fcolor':AppColors.controler_list_color_11},
    {'name':'Communication', 'color':AppColors.controler_list_color_20,'fcolor':AppColors.controler_list_color_21},
    {'name':'Success story', 'color':AppColors.controler_list_color_30,'fcolor':AppColors.controler_list_color_31},
  ].obs;

  void setSelected(String value) {
    selectedValue.value = value;
    selectedCategory.value = value; // Update the selectedCategory
  }

  // This is for the select category part.
  var selectedCategory = Rxn<String>();

  var posts = [
    {
      'sche_title': 'Scheduling',
      'color': AppColors.anonymous_parent_01,
      'bg_color': AppColors.anonymous_parent_02,
      'body_title': 'How do you handle holiday scheduling conflicts?',
      'body_subtitle':'One of the most difficult aspects of co-parenting has been dealing with last-minute changes made by my co-parent.'
          ' While occasional flexibility ',
      'dialog_subtitle':'One of the most difficult aspects of co-parenting has been dealing with last-minute '
          'changes made by my co-parent. While occasional flexibility is understandable and sometimes necessary, '
          'the frequent and unpredictable nature of these changes creates ongoing challenges.'
          ' It disrupts not only my personal and professional schedule but, more importantly,'
          ' the emotional and mental stability of our children. Children thrive on routine, '
          'predictability, and consistency. When plans are constantly changed at the eleventh hour—without adequate notice or'
          ' discussion—it creates confusion, disappointment, and anxiety for them. They often look forward to certain activities or time with each parent,'
          ' and when those expectations aren’t met due to sudden changes, it can erode their sense of trust and emotional security'
     ' As a co-parent, I strongly believe that communication and mutual respect are the cornerstones of a'
      'successful co-parenting relationship. When one parent consistently alters arrangements without considering '
      'the impact on the other parent or the children, it sets a harmful precedent. It sends the message that one'
     ' parent’s time and emotional input are less valuable, which is neither fair nor sustainable. This kind of'
      'behavior forces the other parent to scramble, reschedule'
      'and manage the children’s reactions—all of which can be emotionally draining. In many cases, I’ve had'

    },
    {
      'sche_title': 'Parenting',
      'color': AppColors.controler_list_color_11,
      'bg_color': AppColors.anonymous_parent_04,
      'body_title': 'Dealing with different parenting styles',
      'body_subtitle': 'One ongoing challenge is that my co-parent frequently changes plans at the last minute,This is ready to go ',
    'dialog_subtitle':'One of the most difficult aspects of co-parenting has been dealing with last-minute '
    'changes made by my co-parent. While occasional flexibility is understandable and sometimes necessary, '
    'the frequent and unpredictable nature of these changes creates ongoing challenges.'
    ' It disrupts not only my personal and professional schedule but, more importantly,'
    ' the emotional and mental stability of our children. Children thrive on routine, '
    'predictability, and consistency. When plans are constantly changed at the eleventh hour—without adequate notice or'
    ' discussion—it creates confusion, disappointment, and anxiety for them. They often look forward to certain activities or time with each parent,'
    ' and when those expectations aren’t met due to sudden changes, it can erode their sense of trust and emotional security'
    ' As a co-parent, I strongly believe that communication and mutual respect are the cornerstones of a'
    'successful co-parenting relationship. When one parent consistently alters arrangements without considering '
    'the impact on the other parent or the children, it sets a harmful precedent. It sends the message that one'
    ' parent’s time and emotional input are less valuable, which is neither fair nor sustainable. This kind of'
    'behavior forces the other parent to scramble, reschedule'
    'and manage the children’s reactions—all of which can be emotionally draining. In many cases, I’ve had'
    },
    {
      'sche_title': 'Success story',
      'color': AppColors.anonymous_parent_05,
      'bg_color': AppColors.anonymous_parent_06,
      'body_title': 'Success story ,Communication improvement',
      'body_subtitle': 'One of our biggest successes as co-parents has been improving our communication.'
          ' In the beginning, we often misunderstood each other .',
      'dialog_subtitle':'One of the most difficult aspects of co-parenting has been dealing with last-minute '
          'changes made by my co-parent. While occasional flexibility is understandable and sometimes necessary, '
          'the frequent and unpredictable nature of these changes creates ongoing challenges.'
          ' It disrupts not only my personal and professional schedule but, more importantly,'
          ' the emotional and mental stability of our children. Children thrive on routine, '
          'predictability, and consistency. When plans are constantly changed at the eleventh hour—without adequate notice or'
          ' discussion—it creates confusion, disappointment, and anxiety for them. They often look forward to certain activities or time with each parent,'
          ' and when those expectations aren’t met due to sudden changes, it can erode their sense of trust and emotional security'
          ' As a co-parent, I strongly believe that communication and mutual respect are the cornerstones of a'
          'successful co-parenting relationship. When one parent consistently alters arrangements without considering '
          'the impact on the other parent or the children, it sets a harmful precedent. It sends the message that one'
          ' parent’s time and emotional input are less valuable, which is neither fair nor sustainable. This kind of'
          'behavior forces the other parent to scramble, reschedule'
          'and manage the children’s reactions—all of which can be emotionally draining. In many cases, I’ve had'
    },  {
      'sche_title': 'Communication',
      'color': AppColors.anonymous_parent_07,
      'bg_color': AppColors.anonymous_parent_08,
      'body_title': 'Success story ,Communication improvement',
      'body_subtitle': 'One of our biggest successes as co-parents has been improving our communication.'
          ' In the beginning, we often misunderstood each other .',
      'dialog_subtitle':'One of the most difficult aspects of co-parenting has been dealing with last-minute '
          'changes made by my co-parent. While occasional flexibility is understandable and sometimes necessary, '
          'the frequent and unpredictable nature of these changes creates ongoing challenges.'
          ' It disrupts not only my personal and professional schedule but, more importantly,'
          ' the emotional and mental stability of our children. Children thrive on routine, '
          'predictability, and consistency. When plans are constantly changed at the eleventh hour—without adequate notice or'
          ' discussion—it creates confusion, disappointment, and anxiety for them. They often look forward to certain activities or time with each parent,'
          ' and when those expectations aren’t met due to sudden changes, it can erode their sense of trust and emotional security'
          ' As a co-parent, I strongly believe that communication and mutual respect are the cornerstones of a'
          'successful co-parenting relationship. When one parent consistently alters arrangements without considering '
          'the impact on the other parent or the children, it sets a harmful precedent. It sends the message that one'
          ' parent’s time and emotional input are less valuable, which is neither fair nor sustainable. This kind of'
          'behavior forces the other parent to scramble, reschedule'
          'and manage the children’s reactions—all of which can be emotionally draining. In many cases, I’ve had'
    },
  ];

  //TODO: Implement SupportForumController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}