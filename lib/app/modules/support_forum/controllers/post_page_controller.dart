import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parent_bridge/app/core/constants/api.dart';
import 'package:parent_bridge/app/core/services/base_client.dart';

class PostPageController extends GetxController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  var selectedCategory = Rxn<String>();
  var isLoading = false.obs;

  final List<String> categories = [
    'scheduling',
    'parenting',
    'communication',
    'success',
    'other',
  ];

  Future<void> createPost() async {
    if (titleController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter a title",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    if (selectedCategory.value == null) {
      Get.snackbar(
        "Error",
        "Please select a category",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    if (descriptionController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter a description",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;
      final body = {
        "subject": titleController.text,
        "message": descriptionController.text,
        "category": selectedCategory.value,
      };

      final response = await BaseClient.postRequest(
        api: Api.createPost,
        body: jsonEncode(body),
        headers: BaseClient.authHeaders(),
      );

      if (response.statusCode == 201) {
        Get.back(); // Go back to previous screen
        Get.snackbar(
          "Success",
          "Post created successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        final errorData = jsonDecode(response.body);
        Get.snackbar(
          "Error",
          errorData['detail'] ?? "Failed to create post",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("Error creating post: $e");
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

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
