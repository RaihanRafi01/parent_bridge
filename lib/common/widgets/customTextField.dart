import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

import '../appColors.dart';
import '../customFont.dart';

// GetX Controller for managing password visibility, date, time, and number field
class CustomTextFieldController extends GetxController {
  final RxBool obscureText = true.obs;
  final RxString selectedDate = ''.obs;
  final RxString selectedTime = ''.obs;

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }

  void setSelectedDate(DateTime? date) {
    if (date != null) {
      selectedDate.value = DateFormat('yyyy-MM-dd').format(date);
    }
  }

  void setSelectedTime(TimeOfDay? time) {
    if (time != null) {
      selectedTime.value = DateFormat('HH:mm').format(
        DateTime(2023, 1, 1, time.hour, time.minute),
      );
    }
  }

  void incrementNumber(TextEditingController controller) {
    final currentValue = int.tryParse(controller.text) ?? 0;
    controller.text = (currentValue + 1).toString();
  }

  void decrementNumber(TextEditingController controller) {
    final currentValue = int.tryParse(controller.text) ?? 0;
    if (currentValue > 0) {
      controller.text = (currentValue - 1).toString();
    }
  }
}

class CustomTextField extends StatelessWidget {
  final String prefixIcon;
  final String suffixIcon;
  final String hintText;
  final bool isPassword;
  final bool obscureText;
  final bool isDatePicker;
  final bool isTimePicker;
  final bool isNumberField; // New parameter for number field
  final int maxLines;
  final TextEditingController controller;
  final CustomTextFieldController? textFieldController;
  final VoidCallback? onSuffixTap;
  final VoidCallback? onIncrement; // Callback for increment
  final VoidCallback? onDecrement; // Callback for decrement
  final Color? fillColor;
  final double width;

  const CustomTextField({
    required this.hintText,
    required this.controller,
    this.prefixIcon = '',
    this.suffixIcon = '',
    this.isPassword = false,
    this.obscureText = false,
    this.isDatePicker = false,
    this.isTimePicker = false,
    this.isNumberField = false, // Default to false
    this.maxLines = 1,
    this.textFieldController,
    this.onSuffixTap,
    this.onIncrement,
    this.onDecrement,
    this.fillColor,
    this.width = 382.7314147949219,
    super.key,
  });

  // Method to show date picker
  Future<void> _showDatePicker(BuildContext context, CustomTextFieldController ctrl) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      ctrl.setSelectedDate(picked);
      controller.text = ctrl.selectedDate.value;
    }
  }

  // Method to show time picker
  Future<void> _showTimePicker(BuildContext context, CustomTextFieldController ctrl) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      ctrl.setSelectedTime(picked);
      controller.text = ctrl.selectedTime.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final CustomTextFieldController ctrl = textFieldController ?? Get.put(CustomTextFieldController());

    if (isPassword) {
      ctrl.obscureText.value = obscureText;
    }

    return Container(
      width: width.w,
      padding: EdgeInsets.symmetric(vertical: 12).r,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(50.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.boxShadowColor.withAlpha(36),
            blurRadius: 12.6.r,
            offset: Offset(0.w, 8.h),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? ctrl.obscureText.value : false,
        readOnly: isDatePicker || isTimePicker,
        keyboardType: isNumberField ? TextInputType.number : TextInputType.text,
        maxLines: (isDatePicker || isTimePicker || isNumberField) ? 1 : maxLines, // Enforce single line for pickers and number field
        inputFormatters: isNumberField
            ? [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(10), // Reasonable limit for number field
        ]
            : [],
        onTap: () {
          if (isDatePicker) {
            _showDatePicker(context, ctrl);
          } else if (isTimePicker) {
            _showTimePicker(context, ctrl);
          }
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            left: 16.18.w,
            right: 16.18.w,
            top: 17.h,
            bottom: 17.h,
          ),
          filled: true,
          fillColor: fillColor ?? AppColors.clrWhite,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.borderColor),
            borderRadius: BorderRadius.circular(50.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.borderColor),
            borderRadius: BorderRadius.circular(50.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.borderColor),
            borderRadius: BorderRadius.circular(50.r),
          ),
          prefixIcon: prefixIcon.isNotEmpty
              ? Padding(
            padding: EdgeInsets.all(15.w),
            child: SvgPicture.asset(prefixIcon, fit: BoxFit.contain),
          )
              : null,
          suffixIcon: isPassword
              ? Padding(
            padding: EdgeInsets.all(15.w),
            child: GestureDetector(
              onTap: () {
                ctrl.toggleObscureText();
                onSuffixTap?.call();
              },
              child: SvgPicture.asset(
                ctrl.obscureText.value ? suffixIcon : 'assets/images/auth/eye_open_icon.svg',
                fit: BoxFit.contain,
                color: AppColors.textColorHint,
              ),
            ),
          )
              : isNumberField
              ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  ctrl.incrementNumber(controller);
                  onIncrement?.call();
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 10.w, top: 5.h),
                  child: Icon(Icons.keyboard_arrow_up, size: 20, color: AppColors.textColorHint),
                ),
              ),
              GestureDetector(
                onTap: () {
                  ctrl.decrementNumber(controller);
                  onDecrement?.call();
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 10.w, bottom: 5.h),
                  child: Icon(Icons.keyboard_arrow_down, size: 20, color: AppColors.textColorHint),
                ),
              ),
            ],
          )
              : suffixIcon.isNotEmpty
              ? Padding(
            padding: EdgeInsets.all(15.w),
            child: GestureDetector(
              onTap: onSuffixTap,
              child: SvgPicture.asset(
                suffixIcon,
                fit: BoxFit.contain,
                color: AppColors.textColorHint,
              ),
            ),
          )
              : null,
          hintText: hintText,
          hintStyle: h4.copyWith(color: AppColors.textColorHint, fontSize: 14.sp),
        ),
      ),
    );
  }
}