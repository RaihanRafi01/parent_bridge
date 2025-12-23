import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddExpenseController extends GetxController {
  TextEditingController expenseTitleController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  final Rx<String?> selectedChild = Rx<String?>(null);
  final List<String> childItems = [
    'Emma smith, 10 years',
    'Emma smith, 10 years',
    'Emma smith, 10 years',
  ];

  final Rx<String?> selectedPaymentMethod = Rx<String?>(null);
  final List<String> paymentMethodItems = [
    'All Method',
    'Credit Card',
    'Debit Card',
    'Cash',
    'Check',
    'Mobile Payment',
    'Bank Transfer',
  ];

  final Rx<String?> selectedCategory = Rx<String?>(null);
  final List<String> categoryItems = [
    'Medical',
    'School',
    'Activity',
    'Clothing',
    'Food',
    'Other',
  ];

  // total bill and the other person's name; adjust as you need
  final double total = 85.98; // 42.99 + 42.99 shown in the screenshot
  final String otherName = 'Michael';

  final RxDouble percent = 50.0.obs;

  void minus([double step = 1]) =>
      percent.value = (percent.value - step).clamp(0, 100);
  void plus([double step = 1]) =>
      percent.value = (percent.value + step).clamp(0, 100);

  double get yourAmount => total * (percent.value / 100);
  double get otherAmount => total - yourAmount;

  final count = 0.obs;

  void increment() => count.value++;
}
