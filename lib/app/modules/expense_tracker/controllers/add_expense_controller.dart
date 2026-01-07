import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parent_bridge/app/core/constants/api.dart';
import 'package:parent_bridge/app/core/services/base_client.dart';
import 'package:parent_bridge/app/modules/expense_tracker/controllers/expense_tracker_controller.dart';

class AddExpenseController extends GetxController {
  TextEditingController expenseTitleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController paidDateController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  var isLoading = false.obs;
  Rx<DateTime?> paidDate = Rx<DateTime?>(null);
  Rx<DateTime?> dueDate = Rx<DateTime?>(null);

  final Rx<String?> selectedChild = Rx<String?>(null);
  var children = <dynamic>[].obs;
  final RxList<String> childItems = <String>[].obs;

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

  @override
  void onInit() {
    super.onInit();
    fetchChildren();

    amountController.addListener(() {
      amountText.value = amountController.text;
    });
  }

  var amountText = '0.0'.obs;

  Future<void> fetchChildren() async {
    try {
      final response = await BaseClient.getRequest(
        api: Api.childrenList,
        headers: BaseClient.authHeaders(),
      );

      debugPrint(
        'DEBUG: fetchChildren() response -> status=${response.statusCode}, body=${response.body}',
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        children.value = data['data'] ?? [];
        childItems.value = children.map((c) => c['name'].toString()).toList();

        if (childItems.isNotEmpty) {
          // selectedChild.value = childItems[0];
        }
      }
    } catch (e) {
      debugPrint('Error fetching children: $e');
    }
  }

  Future<void> selectDate(BuildContext context, bool isPaidDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      if (isPaidDate) {
        paidDate.value = picked;
        paidDateController.text =
            '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      } else {
        dueDate.value = picked;
        dueDateController.text =
            '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      }
    }
  }

  Future<void> createExpense() async {
    try {
      isLoading.value = true;

      // Validate required fields
      if (amountController.text.isEmpty) {
        Get.snackbar(
          'Error',
          'Please enter an amount',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      int? childId;
      if (selectedChild.value != null) {
        final child = children.firstWhereOrNull(
          (c) => c['name'] == selectedChild.value,
        );
        if (child != null) {
          childId = child['id'];
        }
      }

      final body = {
        'child': childId,
        'title': expenseTitleController.text.isNotEmpty
            ? expenseTitleController.text
            : null,
        'paid_date': paidDateController.text.isNotEmpty
            ? paidDateController.text
            : null,
        'due_date': dueDateController.text.isNotEmpty
            ? dueDateController.text
            : null,
        'amount': amountController.text,
        'category': selectedCategory.value ?? '',
        'father_percentage': percent.value.toStringAsFixed(2),
        'mother_percentage': (100 - percent.value).toStringAsFixed(2),
        'description': descriptionController.text.isNotEmpty
            ? descriptionController.text
            : null,
      };

      debugPrint('DEBUG: createExpense() -> body: $body');

      final response = await BaseClient.postRequest(
        api: Api.expenseCreate,
        body: jsonEncode(body),
        headers: BaseClient.authHeaders(),
      );

      debugPrint(
        'DEBUG: createExpense() response -> status=${response.statusCode}, body=${response.body}',
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        Get.snackbar(
          'Success',
          data['message'] ?? 'Expense created successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Refresh the expense tracker list
        final expenseController = Get.find<ExpenseTrackerController>();
        expenseController.refreshData();

        Get.back();
      } else {
        final errorData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          errorData['message'] ?? 'Failed to create expense',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e, st) {
      debugPrint('Error creating expense: $e');
      debugPrintStack(stackTrace: st);
      Get.snackbar(
        'Error',
        'An error occurred while creating expense',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
