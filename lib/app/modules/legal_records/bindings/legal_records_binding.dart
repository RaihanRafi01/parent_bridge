import 'package:get/get.dart';

import '../controllers/legal_records_controller.dart';

class LegalRecordsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LegalRecordsController>(
      () => LegalRecordsController(),
    );
  }
}
