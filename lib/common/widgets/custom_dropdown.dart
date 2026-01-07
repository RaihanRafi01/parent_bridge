import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../app_colors.dart';
import '../custom_font.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String labelText;
  final List<T> items;
  final Rx<T?> value; // Reactive value for GetX
  final Function(T?)? onChanged;
  final double radius;
  final Color? fillColor; // New parameter for fill color
  final Color menuBgClr; // Background color for dropdown menu
  final bool readOnly;
  final String? uniqueTag; // Optional unique tag for controller
  final double width;
  final Color labelTxtClr;

  const CustomDropdown({
    super.key,
    required this.labelText,
    required this.items,
    required this.value, // Require Rx<T?> for reactive value
    this.onChanged,
    this.radius = 50.0, // Match CustomTextField's border radius
    this.fillColor, // Use fillColor instead of bgClr/focusedBgClr
    this.menuBgClr = AppColors.textInputFillColor, // Default menu color
    this.readOnly = false,
    this.uniqueTag, // Add uniqueTag as an optional parameter
    this.width = 382.7314147949219,
    this.labelTxtClr = AppColors.textColorHint,
  });

  @override
  Widget build(BuildContext context) {
    // Generate a unique tag for the controller
    final String controllerTag = uniqueTag ?? '$labelText-${key.hashCode}';
    // Create a unique controller instance for each dropdown
    final DropdownController<T> controller = Get.put(
      DropdownController<T>(value),
      tag: controllerTag,
    );

    return Obx(() => Container(
      width: width.w,
      padding: EdgeInsets.symmetric(vertical: 12).r, // Match CustomTextField padding
      decoration: BoxDecoration(
        color: Colors.transparent, // Match CustomTextField
        borderRadius: BorderRadius.circular(radius.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.boxShadowColor.withAlpha(36), // Match CustomTextField shadow
            blurRadius: 12.6.r,
            offset: Offset(0.w, 8.h),
          ),
        ],
      ),
      child: InkWell(
        onTap: readOnly
            ? null
            : () {
          // Request focus and show the popup menu
          controller.setFocused(true);
          if (items.isNotEmpty) {
            _showPopupMenu(context, controller);
          }
        },
        focusNode: controller.focusNode,
        child: InputDecorator(
          decoration: InputDecoration(
            hintText: labelText,
            hintStyle: h4.copyWith(
              color: labelTxtClr,
              fontSize: 14.sp, // Match CustomTextField hint font size
            ),
            contentPadding: EdgeInsets.only(
              left: 16.18.w,
              right: 16.18.w,
              top: 17.h,
              bottom: 17.h,
            ), // Match CustomTextField padding
            filled: true,
            fillColor: fillColor ?? AppColors.clrWhite, // Use provided fillColor or default
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius.r),
              borderSide: BorderSide(
                color: AppColors.borderColor, // Match CustomTextField border
                width: 1.w,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius.r),
              borderSide: BorderSide(
                color: AppColors.borderColor,
                width: 1.w,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius.r),
              borderSide: BorderSide(
                color: AppColors.borderColor,
                width: 1.w,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  value.value?.toString() ??
                      labelText,
                  style: h4.copyWith(
                    color: value.value != null
                        ? labelTxtClr
                        : labelTxtClr,
                    fontSize: 14.sp, // Match CustomTextField font size
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SvgPicture.asset(
                'assets/images/calendar/dropdown_icon.svg', // Use an SVG for consistency
              ),
            ],
          ),
        ),
      ),
    ));
  }

  void _showPopupMenu(BuildContext context, DropdownController<T> controller) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    showMenu<T>(
      context: context,
      position: position,
      items: items.map((T item) {
        return PopupMenuItem<T>(
          value: item,
          child: Container(
            width: double.infinity, // Ensure item takes full width
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Text(
              item.toString(),
              style: h4.copyWith(
                color: AppColors.textColorHint,
                fontSize: 14.sp, // Match CustomTextField font size
              ),
            ),
          ),
        );
      }).toList(),
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius.r), // Match border radius
        side: BorderSide(
          color: AppColors.borderColor, // Match border color
          width: 1.w,
        ),
      ),
      color: menuBgClr, // Retain custom menu background color
      constraints: BoxConstraints(
        maxHeight: 200.h, // Limit menu height
        minWidth: button.size.width, // Match dropdown field width
        maxWidth: button.size.width, // Match dropdown field width
      ),
    ).then((T? newValue) {
      if (newValue != null) {
        value.value = newValue; // Update reactive value
        controller.hasSelection.value = true; // Mark as selected
        if (onChanged != null) {
          onChanged!(newValue); // Call provided callback
        }
      }
      // Unfocus after selection or menu dismissal
      controller.setFocused(false);
    });
  }
}

class DropdownController<T> extends GetxController {
  final FocusNode focusNode = FocusNode();
  final RxBool isFocused = false.obs;
  final RxBool hasSelection = false.obs;
  final Rx<T?> value;

  DropdownController(this.value);

  @override
  void onInit() {
    super.onInit();
    // Initialize hasSelection based on initial value
    hasSelection.value = value.value != null;
    // Update hasSelection when value changes
    ever(value, (_) => hasSelection.value = value.value != null);
    focusNode.addListener(() {
      isFocused.value = focusNode.hasFocus;
    });
  }

  void setFocused(bool focused) {
    isFocused.value = focused;
    if (focused) {
      focusNode.requestFocus();
    } else {
      focusNode.unfocus();
    }
  }

  @override
  void onClose() {
    focusNode.dispose();
    super.onClose();
  }
}