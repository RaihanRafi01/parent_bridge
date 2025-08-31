import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../appColors.dart';
import '../customFont.dart';

class CustomTextField extends StatefulWidget {
  final double? hintFontSize;
  final String labelText;
  final String? prefixSvgPath;
  final String? suffixSvgPath;
  final String? suffixText;
  final Color? suffixTextColor;
  final double? fieldHeight;
  final Color? textColor;
  final VoidCallback? onSuffixTap;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isNoIcon;
  final int maxLine;
  final double radius;
  final Color bgClr;
  final Color focusedBgClr;
  final bool readOnly;
  final TextAlign textAlign;
  final int? maxLength;
  final int? charLimit;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final bool isPhoneNumber;
  final String initialCountryCode;
  final ValueChanged<String>? onPhoneNumberChanged;
  final bool isNumberField;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final bool isDatePicker;

  const CustomTextField({
    super.key,
    required this.labelText,
    this.hintFontSize = 15,
    this.prefixSvgPath,
    this.suffixSvgPath,
    this.suffixText,
    this.suffixTextColor,
    this.fieldHeight,
    this.textColor,
    this.onSuffixTap,
    this.obscureText = false,
    this.isNoIcon = false,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.maxLine = 1,
    this.radius = 13.09,
    this.bgClr = AppColors.clrWhite,
    this.focusedBgClr = AppColors.textInputFocus,
    this.readOnly = false,
    this.textAlign = TextAlign.start,
    this.maxLength,
    this.charLimit,
    this.onChanged,
    this.focusNode,
    this.isPhoneNumber = false,
    this.initialCountryCode = 'BD',
    this.onPhoneNumberChanged,
    this.isNumberField = false,
    this.onIncrement,
    this.onDecrement,
    this.isDatePicker = false,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;
  String _dialCode = '+880';
  bool _didEmitInit = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() => setState(() {}));
    if (widget.initialCountryCode.trim().startsWith('+')) {
      _dialCode = widget.initialCountryCode.trim();
    }
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _emitPhoneChanged(String raw) {
    if (!widget.isPhoneNumber) return;
    final digits = raw.replaceAll(RegExp(r'\D'), '');
    final full = '$_dialCode$digits';
    widget.onPhoneNumberChanged?.call(full);
  }

  void _incrementNumber() {
    final currentValue = int.tryParse(widget.controller.text) ?? 0;
    widget.controller.text = (currentValue + 1).toString();
    widget.onChanged?.call(widget.controller.text);
    widget.onIncrement?.call();
  }

  void _decrementNumber() {
    final currentValue = int.tryParse(widget.controller.text) ?? 0;
    if (currentValue > 0) {
      widget.controller.text = (currentValue - 1).toString();
      widget.onChanged?.call(widget.controller.text);
      widget.onDecrement?.call();
    }
  }

  void _showDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      final formattedDate = DateFormat('MM/dd/yyyy').format(picked);
      widget.controller.text = formattedDate;
      widget.onChanged?.call(formattedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPhone = widget.isPhoneNumber;
    final isNumber = widget.isNumberField;
    final isDate = widget.isDatePicker;

    // Calculate content padding to respect fieldHeight
    final double verticalPadding = widget.fieldHeight != null
        ? (widget.fieldHeight! - (widget.maxLine > 1 ? 24.h : 16.h)) / 2
        : (widget.maxLine > 1 ? 12.h : 8.h);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: widget.fieldHeight?.h, // Apply fieldHeight to outer container
      decoration: BoxDecoration(
        color: AppColors.appColor, // Reverted to original appColor
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: TextField(
        maxLines: widget.maxLine,
        controller: widget.controller,
        obscureText: widget.obscureText,
        keyboardType: isPhone || isNumber
            ? TextInputType.number
            : isDate
            ? TextInputType.datetime
            : widget.keyboardType,
        readOnly: widget.readOnly,
        focusNode: _focusNode,
        textAlign: widget.textAlign,
        style: h4.copyWith(
          color: widget.textColor ?? AppColors.textColor,
          fontSize: 14.sp,
        ),
        maxLength: isPhone || isNumber
            ? (widget.maxLength ?? widget.charLimit ?? 15)
            : isDate
            ? 10 // MM/DD/YYYY length
            : (widget.maxLength ?? widget.charLimit),
        inputFormatters: [
          if (isPhone || isNumber) ...[
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(
              widget.charLimit ?? widget.maxLength ?? 15,
            ),
          ] else if (isDate) ...[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
            LengthLimitingTextInputFormatter(10), // MM/DD/YYYY
            _DateInputFormatter(),
          ] else if (widget.charLimit != null) ...[
            LengthLimitingTextInputFormatter(widget.charLimit),
          ],
        ],
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: widget.labelText.toUpperCase(),
          hintStyle: h4.copyWith(
            color: AppColors.textColorHint,
            fontSize: widget.hintFontSize?.sp,
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: verticalPadding,
            // Adjusted padding to respect fieldHeight
            horizontal: 20.w,
          ),
          constraints: widget.fieldHeight != null
              ? BoxConstraints(
                  minHeight: widget.fieldHeight!.h,
                  maxHeight: widget.fieldHeight!.h,
                )
              : null,
          // Apply constraints to ensure TextField respects fieldHeight
          prefixIcon: (widget.isNoIcon || widget.prefixSvgPath == null
              ? null
              : Padding(
                  padding: const EdgeInsets.only(left: 20, right: 5),
                  child: SvgPicture.asset(
                    widget.prefixSvgPath!,
                    color: widget.textColor, // Apply textColor to prefix icon
                  ),
                )),
          prefixIconConstraints: isPhone
              ? BoxConstraints(minWidth: 80.w, maxWidth: 120.w)
              : null,
          suffixIcon: isDate
              ? GestureDetector(
                  onTap: _showDatePicker,
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Icon(
                      Icons.calendar_today,
                      size: 20,
                      color: widget.textColor,
                    ),
                  ),
                )
              : isNumber
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: _incrementNumber,
                      child: Padding(
                        padding: EdgeInsets.only(right: 10.w, top: 5.h),
                        child: Icon(
                          Icons.keyboard_arrow_up,
                          size: 20,
                          color: widget.textColor,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _decrementNumber,
                      child: Padding(
                        padding: EdgeInsets.only(right: 10.w, bottom: 5.h),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          size: 20,
                          color: widget.textColor,
                        ),
                      ),
                    ),
                  ],
                )
              : widget.suffixSvgPath != null
              ? GestureDetector(
                  onTap: widget.onSuffixTap,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20, left: 5).r,
                    child: SvgPicture.asset(widget.suffixSvgPath!),
                  ),
                )
              : null,
          suffix: widget.suffixText != null
              ? Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Text(
                    widget.suffixText!,
                    style: h4.copyWith(
                      fontSize: 14.sp,
                      color:
                          widget.suffixTextColor ??
                          widget.textColor ??
                          AppColors.textColor,
                    ),
                  ),
                )
              : null,
          filled: true,
          fillColor: _focusNode.hasFocus ? widget.focusedBgClr : widget.bgClr,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius.r),
            borderSide: BorderSide(
              color: AppColors.textInputBorder,
              width: 1.w,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius.r),
            borderSide: BorderSide(
              color: AppColors.textInputBorder,
              width: 1.w,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius.r),
            borderSide: BorderSide(
              color: AppColors.textInputBorder,
              width: 1.w,
            ),
          ),
          counterText: '',
        ),
      ),
    );
  }
}

class _DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;

    if (text.isEmpty) {
      return newValue;
    }

    // Allow only digits and slashes
    final cleanText = text.replaceAll(RegExp(r'[^0-9/]'), '');

    // Format as MM/DD/YYYY
    String formattedText = '';
    int cursorPosition = newValue.selection.baseOffset;

    // Split the clean text into digits
    final digits = cleanText.replaceAll('/', '').split('');
    int digitIndex = 0;

    // Build the formatted string
    for (int i = 0; i < 10 && digitIndex < digits.length; i++) {
      if (i == 2 || i == 5) {
        formattedText += '/';
        if (cursorPosition > i) cursorPosition++;
      } else {
        formattedText += digits[digitIndex];
        digitIndex++;
      }
    }

    // Basic validation for valid date components
    if (formattedText.length >= 2) {
      final month = int.tryParse(formattedText.substring(0, 2)) ?? 0;
      if (month < 1 || month > 12) {
        return oldValue; // Reject invalid month
      }
    }
    if (formattedText.length >= 5) {
      final day = int.tryParse(formattedText.substring(3, 5)) ?? 0;
      if (day < 1 || day > 31) {
        return oldValue; // Reject invalid day
      }
    }
    if (formattedText.length == 10) {
      final year = int.tryParse(formattedText.substring(6, 10)) ?? 0;
      if (year < 0000 || year > 9999) {
        return oldValue; // Reject invalid year
      }
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(
        offset: cursorPosition.clamp(0, formattedText.length),
      ),
    );
  }
}
