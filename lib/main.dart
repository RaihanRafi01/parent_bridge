import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart'; // Added for SystemChrome
import 'app/core/dependency_injection.dart';
import 'app/routes/app_pages.dart';
import 'common/appColors.dart';

void main() {
  // Lock orientation to portrait mode
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    setupDependencies();
    runApp(
      ScreenUtilInit(
        designSize: const Size(440, 974), // Set your design size (e.g., based on your design mockup)
        minTextAdapt: true, // Allows text to scale adaptively
        splitScreenMode: true, // Supports split-screen mode
        builder: (context, child) {
          return GetMaterialApp(
            title: "Application",
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
            defaultTransition: Transition.rightToLeft, // Set default transition
            transitionDuration: Duration(milliseconds: 300),
            theme: ThemeData(
              // Define the primary app color
              primaryColor: AppColors.appColor, // Main app color (used for buttons, etc.)
              // Define the background color for the entire app
              scaffoldBackgroundColor: AppColors.clrWhite, // Light grey background for scaffolds
              // Define cursor color for text fields
              textSelectionTheme: const TextSelectionThemeData(
                cursorColor: AppColors.appColor, // Cursor color for text input fields
                selectionColor: AppColors.textInputBorder, // Optional: Selection color
                selectionHandleColor: AppColors.appColor, // Optional: Selection handle color
              ),
              // Optional: Define app bar color
              appBarTheme: const AppBarTheme(
                backgroundColor: AppColors.appColor, // AppBar background color
                foregroundColor: AppColors.clrWhite, // AppBar text/icon color
              ),
              // Optional: Define overall color scheme
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.blue,
                backgroundColor: AppColors.clrWhite, // Background color for other widgets
              ).copyWith(
                secondary: Colors.blueAccent, // Accent color (optional)
              ),
            ),
          );
        },
      ),
    );
  });
}