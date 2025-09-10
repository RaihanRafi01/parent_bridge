import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddExpenseController extends GetxController {
  TextEditingController expenseTitleController = TextEditingController();

  // total bill and the other person's name; adjust as you need
  final double total = 85.98; // 42.99 + 42.99 shown in the screenshot
  final String otherName = 'Michael';

  final RxDouble percent = 50.0.obs;

  void minus([double step = 1]) => percent.value = (percent.value - step).clamp(0, 100);
  void plus([double step = 1]) => percent.value = (percent.value + step).clamp(0, 100);

  double get yourAmount => total * (percent.value / 100);
  double get otherAmount => total - yourAmount;

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
