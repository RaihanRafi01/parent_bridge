import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/document_vault_controller.dart';

class DocumentVaultView extends GetView<DocumentVaultController> {
  const DocumentVaultView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DocumentVaultView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DocumentVaultView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
