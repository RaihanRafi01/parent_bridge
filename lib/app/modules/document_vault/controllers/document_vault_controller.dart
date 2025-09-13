import 'dart:ui';

import 'package:get/get.dart';
import '../../../../common/appColors.dart';

class DocumentVaultController extends GetxController {
  // 🔹 For "Select Category"
  var selectedCategory = "Select category".obs;

  // 🔹 Example counter (optional, if you still need it)
  final count = 0.obs;

  void increment() => count.value++;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

// list for dropdown menu ..
var selectedCategory = RxnString();
