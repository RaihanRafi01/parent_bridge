import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parent_bridge/app/core/constants/api.dart';
import 'package:parent_bridge/app/core/services/base_client.dart';

class SettingsController extends GetxController {
  var messageNotifications = true.obs;
  var callNotifications = true.obs;
  var calendarNotifications = true.obs;
  var expenseRequests = false.obs;

  var isLoading = false.obs;
  var profileName = "".obs;
  var profileEmail = "".obs;
  var profileImage = "".obs;
  var profileChildren = <dynamic>[].obs;
  var isCourtMandated = false.obs;
  var userRole = "".obs;
  Rx<File?> selectedImage = Rx<File?>(null);

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final stateController = TextEditingController();
  final courtMandatedController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        selectedImage.value = File(image.path);
      }
    } catch (e) {
      print("Error picking image: $e");
      Get.snackbar(
        "Error",
        "Failed to pick image",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;

      // Get email from storage
      String? storedEmail = await BaseClient.getEmail();
      if (storedEmail != null) {
        profileEmail.value = storedEmail;
        emailController.text = storedEmail;
      }

      final response = await BaseClient.getRequest(
        api: Api.profile,
        headers: BaseClient.authHeaders(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        profileName.value = data['name'] ?? "";
        nameController.text = profileName.value;

        profileImage.value = data['image'] ?? "";

        String phone = data['phone'] ?? "";
        phoneController.text = phone;

        String state = data['state'] ?? "";
        stateController.text = state;

        isCourtMandated.value = data['court_mandated'] ?? false;
        courtMandatedController.text = isCourtMandated.value
            ? "Yes, court mandated"
            : "No";

        userRole.value = data['role'] ?? "";

        profileChildren.value = data['children'] ?? [];
      }
    } catch (e) {
      print("Error fetching profile: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfile() async {
    try {
      isLoading.value = true;

      if (selectedImage.value != null) {
        // Use multipart request if image is selected
        final fields = {
          "name": nameController.text,
          "phone": phoneController.text,
          "state": stateController.text,
          "court_mandated": isCourtMandated.value.toString(),
          "role": userRole.value,
        };

        final response = await BaseClient.multipartRequest(
          api: Api.profile,
          fields: fields,
          image: selectedImage.value,
          headers: BaseClient.authHeaders(),
        );

        if (response.statusCode == 200) {
          Get.snackbar(
            "Success",
            "Profile updated successfully",
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          selectedImage.value = null; // Reset selected image
          fetchProfile(); // Refresh data
        } else {
          Get.snackbar(
            "Error",
            "Failed to update profile",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        // Use standard PUT request if no image
        final body = {
          "name": nameController.text,
          "phone": phoneController.text,
          "state": stateController.text,
          "children": profileChildren,
          "court_mandated": isCourtMandated.value,
          "role": userRole.value,
        };

        final response = await BaseClient.putRequest(
          api: Api.profile,
          body: jsonEncode(body),
          headers: BaseClient.authHeaders(),
        );

        if (response.statusCode == 200) {
          Get.snackbar(
            "Success",
            "Profile updated successfully",
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          fetchProfile(); // Refresh data
        } else {
          Get.snackbar(
            "Error",
            "Failed to update profile",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      print("Error updating profile: $e");
      Get.snackbar(
        "Error",
        "An error occurred",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    try {
      isLoading.value = true;
      final body = {
        "old_password": oldPassword,
        "new_password": newPassword,
      };

      final response = await BaseClient.putRequest(
        api: Api.changePassword,
        body: jsonEncode(body),
        headers: BaseClient.authHeaders(),
      );

      if (response.statusCode == 200) {
        Get.back(); // Close the dialog
        Get.snackbar(
          "Success",
          "Password changed successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        final errorData = jsonDecode(response.body);
        String errorMessage = "Failed to change password";

        if (errorData['detail'] != null) {
          errorMessage = errorData['detail'];
        } else if (errorData['non_field_errors'] != null) {
          if (errorData['non_field_errors'] is List) {
            errorMessage = (errorData['non_field_errors'] as List).join(' ');
          } else {
            errorMessage = errorData['non_field_errors'].toString();
          }
        }

        Get.snackbar(
          "Error",
          errorMessage,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("Error changing password: $e");
      Get.snackbar(
        "Error",
        "An error occurred",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void toggleMessageNotifications(bool value) {
    messageNotifications.value = value;
  }

  void toggleCallNotifications(bool value) {
    callNotifications.value = value;
  }

  void toggleCalendarNotifications(bool value) {
    calendarNotifications.value = value;
  }

  void toggleExpenseRequests(bool value) {
    expenseRequests.value = value;
  }
}
