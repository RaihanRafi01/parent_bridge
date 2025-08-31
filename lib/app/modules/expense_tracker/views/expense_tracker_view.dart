import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/expense_tracker_controller.dart';

class ExpenseTrackerView extends GetView<ExpenseTrackerController> {
  const ExpenseTrackerView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ExpenseTrackerView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ExpenseTrackerView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
