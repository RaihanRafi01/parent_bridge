import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpProcessController extends GetxController {
  RxBool isBridgeMode = true.obs;
  RxBool isSendInvite = true.obs;

  TextEditingController coParentsNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController stateController = TextEditingController();

  final count = 0.obs;
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

  void increment() => count.value++;
}
