import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/legal_records_controller.dart';

class LegalRecordsView extends GetView<LegalRecordsController> {
  const LegalRecordsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LegalRecordsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'LegalRecordsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
