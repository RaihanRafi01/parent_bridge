import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpVerificationsController extends GetxController {
  static const int _otpLength = 4;

  final verificationCodeControllers = List.generate(
    _otpLength,
    (_) => TextEditingController(),
    growable: false,
  );

  final count = 0.obs;

  void increment() => count.value++;
}
