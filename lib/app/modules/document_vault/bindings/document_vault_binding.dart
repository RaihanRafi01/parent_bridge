import 'package:get/get.dart';

import '../controllers/document_vault_controller.dart';

class DocumentVaultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DocumentVaultController>(
      () => DocumentVaultController(),
    );
  }
}
