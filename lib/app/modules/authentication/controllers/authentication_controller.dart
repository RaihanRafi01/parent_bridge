import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final childNameController = TextEditingController();
  final childAgeController = TextEditingController();
  final sateController = TextEditingController();
  final exampleController = TextEditingController();

  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;
  final rememberMe = false.obs;

  RxBool addMoreDropdownActive = false.obs;
  RxBool courtMandatedActive = false.obs;
  RxBool roleActive = false.obs;

  RxBool isCourtMandated2 = false.obs;
  RxBool isVoluntaryUse2 = false.obs;

  RxBool role1 = false.obs;
  RxBool role2 = false.obs;

  void togglePasswordVisibility() => isPasswordVisible.value = !isPasswordVisible.value;
  void toggleConfirmPasswordVisibility() => isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  void toggleRememberMe() => rememberMe.value = !rememberMe.value;

  // Optional: Add methods to handle court-mandated and role toggles explicitly
  void setCourtMandated(bool value) {
    isCourtMandated2.value = value;
    isVoluntaryUse2.value = !value;
  }

  void setRoleMom(bool value) {
    role1.value = value;
    role2.value = !value;
  }

  void setRoleDad(bool value) {
    role1.value = !value;
    role2.value = value;
  }

  @override
  void onClose() {
    // Dispose controllers to prevent memory leaks
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    childNameController.dispose();
    childAgeController.dispose();
    sateController.dispose();
    exampleController.dispose();
    super.onClose();
  }
}