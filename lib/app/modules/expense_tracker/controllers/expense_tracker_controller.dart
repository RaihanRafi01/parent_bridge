import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpenseTrackerController extends GetxController {
  TextEditingController searchController = TextEditingController();

  RxBool isExpenseEmpty = true.obs;

  TextEditingController amountController = TextEditingController();
  TextEditingController paymentMethodController = TextEditingController();

  final Rx<String?> selectedPaymentMethod = Rx<String?>(null);
  final Rx<String?> selectedPaymentMethod2 = Rx<String?>(null);
  final List<String> paymentMethodItems = [
    'All Method',
    'Credit Card',
    'Debit Card',
    'Cash',
    'Check',
    'Mobile Payment',
    'Bank Transfer',
  ];

  final Rx<String?> selectedStatus = Rx<String?>(null);
  final List<String> statusItems = ['Pending', 'Approved', 'Paid', 'Rejected'];

  final Rx<String?> selectedCategory = Rx<String?>(null);
  final List<String> categoryItems = [
    'Medical',
    'School',
    'Activity',
    'Clothing',
    'Food',
    'Other',
  ];

  final count = 0.obs;

  void increment() => count.value++;
}
