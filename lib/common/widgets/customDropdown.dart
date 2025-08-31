import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../appColors.dart';
import '../customFont.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String labelText;
  final List<T> items;
  final Rx<T?> value; // Reactive value for GetX
  final Function(T?)? onChanged;
  final double radius;
  final Color bgClr;
  final Color focusedBgClr;
  final Color menuBgClr; // Background color for dropdown menu
  final bool readOnly;
  final String? uniqueTag; // Optional unique tag for controller
  final bool useBaseBgColor; // Parameter to force bgClr as fill color

  const CustomDropdown({
    super.key,
    required this.labelText,
    required this.items,
    required this.value, // Require Rx<T?> for reactive value
    this.onChanged,
    this.radius = 13.09,
    this.bgClr = AppColors.clrWhite,
    this.focusedBgClr = AppColors.textInputFocus,
    this.menuBgClr = AppColors.clrSky2, // Default menu color
    this.readOnly = false,
    this.uniqueTag, // Add uniqueTag as an optional parameter
    this.useBaseBgColor = false, // Default to false
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
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.textInputBorder2,
        borderRadius: BorderRadius.circular(6.r),
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
            hintText: labelText.toUpperCase(),
            hintStyle: h4.copyWith(
              color: AppColors.textColorHint,
              fontSize: 15.sp,
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 8.h,
              horizontal: 10.w,
            ),
            filled: true,
            fillColor: useBaseBgColor
                ? bgClr
                : (controller.isFocused.value || controller.hasSelection.value
                ? focusedBgClr
                : bgClr),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius.r),
              borderSide: BorderSide(
                color: AppColors.textInputBorder,
                width: 1.w,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius.r),
              borderSide: BorderSide(
                color: AppColors.textInputBorder,
                width: 1.w,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius.r),
              borderSide: BorderSide(
                color: AppColors.textInputBorder,
                width: 1.w,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  value.value?.toString().toUpperCase() ??
                      labelText.toUpperCase(),
                  style: h4.copyWith(
                    color: useBaseBgColor
                        ? Colors.white
                        : (value.value != null
                        ? AppColors.textColorHint
                        : AppColors.textColorHint.withOpacity(0.5)),
                    fontSize: 15.sp,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: useBaseBgColor ? Colors.white : Colors.black,
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
              item.toString().toUpperCase(),
              style: h4.copyWith(
                color: AppColors.textColorHint,
                fontSize: 15.sp,
              ),
            ),
          ),
        );
      }).toList(),
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius.r), // Apply border radius to menu
        side: BorderSide(
          color: AppColors.textInputBorder,
          width: 1.w,
        ), // Match border style
      ),
      color: menuBgClr, // Use custom menu background color
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