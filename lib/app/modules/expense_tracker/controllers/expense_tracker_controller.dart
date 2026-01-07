import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parent_bridge/app/core/constants/api.dart';
import 'package:parent_bridge/app/core/services/base_client.dart';

class ExpenseTrackerController extends GetxController {
  TextEditingController searchController = TextEditingController();

  RxBool isExpenseEmpty = true.obs;
  var isLoadingSummary = false.obs;
  var isLoadingExpenses = false.obs;

  // Summary data
  var totalExpense = 0.0.obs;
  var pendingExpense = 0.0.obs;
  var yourExpense = 0.0.obs;
  var partnerExpense = 0.0.obs;
  var currentMonth = ''.obs;
  var currentYear = ''.obs;

  // Expense list
  var expenses = <dynamic>[].obs;
  var searchQuery = ''.obs;

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

  @override
  void onInit() {
    super.onInit();
    final now = DateTime.now();
    currentMonth.value = now.month.toString().padLeft(2, '0');
    currentYear.value = now.year.toString();

    // Listen to search input changes
    searchController.addListener(() {
      searchQuery.value = searchController.text;
    });

    // Debounce search input
    debounce(searchQuery, (String? val) {}, time: Duration(milliseconds: 300));

    // Fetch data immediately when controller is created
    refreshData();
  }

  void refreshData() {
    fetchExpenseSummary();
    fetchExpenseList();
  }

  void setSearchQuery(String q) {
    searchQuery.value = q;
  }

  Future<void> fetchExpenseSummary() async {
    try {
      isLoadingSummary.value = true;
      debugPrint(
        "DEBUG: fetchExpenseSummary() -> month: ${currentMonth.value}, year: ${currentYear.value}",
      );

      final response = await BaseClient.getRequest(
        api:
            '${Api.expenseSummary}?month=${currentMonth.value}&year=${currentYear.value}',
        headers: BaseClient.authHeaders(),
      );

      debugPrint(
        "DEBUG: fetchExpenseSummary() response -> status=${response.statusCode}, body=${response.body}",
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final summaryData = data['data'] ?? {};
        totalExpense.value = (summaryData['total_expense'] ?? 0).toDouble();
        pendingExpense.value = (summaryData['pending_expense'] ?? 0).toDouble();
        yourExpense.value = (summaryData['your_expense'] ?? 0).toDouble();
        partnerExpense.value = (summaryData['partner_total_expense'] ?? 0)
            .toDouble();
      } else {
        debugPrint(
          "DEBUG: fetchExpenseSummary() non-200 status: ${response.statusCode}",
        );
      }
    } catch (e, st) {
      debugPrint("Error fetching expense summary: $e");
      debugPrintStack(stackTrace: st);
    } finally {
      isLoadingSummary.value = false;
    }
  }

  Future<void> fetchExpenseList() async {
    try {
      isLoadingExpenses.value = true;
      debugPrint("DEBUG: fetchExpenseList() -> api: ${Api.expenseList}");

      final response = await BaseClient.getRequest(
        api: Api.expenseList,
        headers: BaseClient.authHeaders(),
      );

      debugPrint(
        "DEBUG: fetchExpenseList() response -> status=${response.statusCode}, body=${response.body}",
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final expenseData = data['data'] ?? {};
        expenses.value = expenseData['expenses'] ?? [];
        isExpenseEmpty.value = expenses.isEmpty;
      } else {
        debugPrint(
          "DEBUG: fetchExpenseList() non-200 status: ${response.statusCode}",
        );
      }
    } catch (e, st) {
      debugPrint("Error fetching expense list: $e");
      debugPrintStack(stackTrace: st);
    } finally {
      isLoadingExpenses.value = false;
    }
  }

  List<dynamic> get filteredExpenses {
    var filtered = expenses.toList();

    // Filter by status
    if (selectedStatus.value != null && selectedStatus.value!.isNotEmpty) {
      final statusMap = {
        'Pending': 'unpaid',
        'Approved': 'approved',
        'Paid': 'paid',
        'Rejected': 'rejected',
      };
      final apiStatus = statusMap[selectedStatus.value];
      if (apiStatus != null) {
        filtered = filtered.where((e) => e['status'] == apiStatus).toList();
      }
    }

    // Filter by category
    if (selectedCategory.value != null && selectedCategory.value!.isNotEmpty) {
      filtered = filtered
          .where(
            (e) =>
                (e['category'] ?? '').toString().toLowerCase() ==
                selectedCategory.value!.toLowerCase(),
          )
          .toList();
    }

    // Filter by search query
    final q = searchQuery.value.trim().toLowerCase();
    if (q.isNotEmpty) {
      filtered = filtered.where((e) {
        final title = (e['title'] ?? '').toString().toLowerCase();
        final desc = (e['description'] ?? '').toString().toLowerCase();
        final category = (e['category'] ?? '').toString().toLowerCase();
        return title.contains(q) || desc.contains(q) || category.contains(q);
      }).toList();
    }

    return filtered;
  }

  void increment() => count.value++;
}
