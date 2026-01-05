import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parent_bridge/app/core/constants/api.dart';
import 'package:parent_bridge/app/core/services/base_client.dart';
import 'package:parent_bridge/app/modules/authentication/views/password_reset_successful_view.dart';
import 'package:parent_bridge/common/appColors.dart';
import 'package:parent_bridge/common/widgets/custom_snackbar.dart';

class NewPasswordController extends GetxController {
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;
  final isLoading = false.obs;

  void togglePasswordVisibility() =>
      isPasswordVisible.value = !isPasswordVisible.value;
  void toggleConfirmPasswordVisibility() =>
      isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;

  Future<void> resetPassword() async {
    final password = newPasswordController.text.trim();
    final confirmPassword = confirmNewPasswordController.text.trim();

    if (password.isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please enter a new password",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }

    if (password != confirmPassword) {
      kSnackBar(
        title: "Validation Error",
        message: "Passwords do not match",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }

    try {
      isLoading.value = true;

      final response = await BaseClient.postRequest(
        api: Api.passwordReset,
        body: jsonEncode({"new_password": password}),
        headers: BaseClient.authHeaders(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        kSnackBar(
          title: "Success",
          message: responseData['message'] ?? "Password reset successfully",
          bgColor: AppColors.appColor,
        );

        Get.offAll(() => const PasswordResetSuccessfulView());
      } else {
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        String errorMessage = "Failed to reset password. Please try again.";

        if (errorData.containsKey('non_field_errors')) {
          final errors = errorData['non_field_errors'];
          if (errors is List && errors.isNotEmpty) {
            errorMessage = errors[0].toString();
          } else {
            errorMessage = errors.toString();
          }
        } else if (errorData.containsKey('message')) {
          errorMessage = errorData['message'];
        } else if (errorData.containsKey('detail')) {
          errorMessage = errorData['detail'];
        }

        kSnackBar(
          title: "Error",
          message: errorMessage,
          bgColor: AppColors.snackBarWarning,
        );
      }
    } catch (e) {
      kSnackBar(
        title: "Error",
        message: "An error occurred. Please try again.",
        bgColor: AppColors.snackBarWarning,
      );
      debugPrint("Reset password error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  final count = 0.obs;

  void increment() => count.value++;
}
