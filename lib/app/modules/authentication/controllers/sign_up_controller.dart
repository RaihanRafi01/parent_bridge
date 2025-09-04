import 'package:get/get.dart';

class SignUpController extends GetxController {
  RxBool addMoreDropdownActive = false.obs;
  RxBool courtMandatedActive = false.obs;

  RxBool isCourtMandated = false.obs;
  RxBool isVoluntaryUse = false.obs;

  RxBool isCourtMandated2 = false.obs;
  RxBool isVoluntaryUse2 = false.obs;

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
