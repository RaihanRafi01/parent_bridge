import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../appColors.dart';
import '../customFont.dart';

void kSnackBar({String? title,required String message, Color? bgColor}) {
  Get.showSnackbar(
    GetSnackBar(
      title: title,
      backgroundColor: bgColor ?? AppColors.appColor, // Use provided bgColor or fallback to AppColors.appColor
      //message: message,
      messageText: Text(message,style: h3.copyWith(color: Colors.white),),
      maxWidth: 1170,
      duration: const Duration(seconds: 3),
      snackStyle: SnackStyle.FLOATING,
      margin: const EdgeInsets.all(10),
      borderRadius: 5,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    ),
  );
}