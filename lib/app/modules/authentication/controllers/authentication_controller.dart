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


  RxBool isCourtMandated = false.obs;
  RxBool isVoluntaryUse = false.obs;

  RxBool isCourtMandated2 = false.obs;
  RxBool isVoluntaryUse2 = false.obs;


  void togglePasswordVisibility() => isPasswordVisible.value = !isPasswordVisible.value;
  void toggleConfirmPasswordVisibility() => isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  void toggleRememberMe() => rememberMe.value = !rememberMe.value;
  //void login() { Get.offAll(DashboardView()); }
  //void navigateToSignUp() { Get.to(SignupView()); }
  //void navigateToSignIn() { Get.to(LoginView());}
 // void navigateToForgetPassword() { Get.to(ForgetPasswordView());}
 // void navigateVerifyOtp() { Get.to(VerifyOtpView()); }
 // void navigateCreatePassword({required String otp}) { Get.to(CreatePasswordView()); }
 // void navigateToSuccess() { Get.to(SuccessView()); }
}
