import 'package:get/get.dart';

import 'package:parent_bridge/app/modules/expense_tracker/controllers/add_expense_controller.dart';

import '../controllers/expense_tracker_controller.dart';

class ExpenseTrackerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddExpenseController>(() => AddExpenseController());
    Get.lazyPut<ExpenseTrackerController>(
      () => ExpenseTrackerController(),
      fenix: true,
    );
  }
}
