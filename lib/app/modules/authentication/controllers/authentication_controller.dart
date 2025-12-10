import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parent_bridge/app/core/constants/api.dart';
import 'package:parent_bridge/app/core/services/base_client.dart';
import 'package:parent_bridge/app/modules/authentication/models/login_request_model.dart';
import 'package:parent_bridge/app/modules/authentication/models/login_response_model.dart';
import 'package:parent_bridge/app/modules/authentication/models/signup_request_model.dart';
import 'package:parent_bridge/app/modules/authentication/models/signup_response_model.dart';
import 'package:parent_bridge/app/modules/authentication/models/otp_verification_request_model.dart';
import 'package:parent_bridge/app/modules/authentication/models/otp_verification_response_model.dart';
import 'package:parent_bridge/app/modules/authentication/models/onboarding_request_model.dart';
import 'package:parent_bridge/app/modules/authentication/models/onboarding_response_model.dart';
import 'package:parent_bridge/app/modules/authentication/views/otp_verifications_view.dart';
import 'package:parent_bridge/app/modules/sign_up_process/views/independent_mode_view.dart';
import 'package:parent_bridge/app/modules/sign_up_process/views/bridge_mode_view.dart';
import 'package:parent_bridge/app/modules/home/views/home_view.dart';
import 'package:parent_bridge/common/widgets/custom_snackbar.dart';
import '../../../../common/appColors.dart';
import '../views/choose_mode.dart';

class AuthenticationController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final childNameController = TextEditingController();
  final childAgeController = TextEditingController();
  final sateController = TextEditingController();
  final exampleController = TextEditingController();

  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;
  final rememberMe = false.obs;

  RxBool addMoreDropdownActive = false.obs;
  RxBool courtMandatedActive = false.obs;
  RxBool roleActive = false.obs;

  RxBool isCourtMandated2 = false.obs;
  RxBool isVoluntaryUse2 = false.obs;

  RxBool role1 = false.obs;
  RxBool role2 = false.obs;

  // Children list
  RxList<ChildModel> childrenList = <ChildModel>[].obs;

  void togglePasswordVisibility() =>
      isPasswordVisible.value = !isPasswordVisible.value;
  void toggleConfirmPasswordVisibility() =>
      isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  void toggleRememberMe() => rememberMe.value = !rememberMe.value;

  // Optional: Add methods to handle court-mandated and role toggles explicitly
  void setCourtMandated(bool value) {
    isCourtMandated2.value = value;
    isVoluntaryUse2.value = !value;
  }

  void setRoleMom(bool value) {
    role1.value = value;
    role2.value = !value;
  }

  void setRoleDad(bool value) {
    role1.value = !value;
    role2.value = value;
  }

  // Add child to the list
  void addChild() {
    if (childNameController.text.trim().isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please enter child's name",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }

    if (childAgeController.text.trim().isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please select child's date of birth",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }

    // Add child to list
    childrenList.add(
      ChildModel(
        name: childNameController.text.trim(),
        dateOfBirth: childAgeController.text.trim(),
      ),
    );

    // Clear the input fields
    childNameController.clear();
    childAgeController.clear();

    // Show success message
    kSnackBar(
      title: "Success",
      message: "Child added successfully",
      bgColor: AppColors.appColor,
    );
  }

  // Remove child from the list
  void removeChild(int index) {
    if (index >= 0 && index < childrenList.length) {
      childrenList.removeAt(index);
      kSnackBar(
        title: "Removed",
        message: "Child removed from list",
        bgColor: AppColors.appColor,
      );
    }
  }

  // Date picker for child's date of birth
  Future<void> pickChildDateOfBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365)),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
      helpText: "Select child's date of birth",
    );

    if (picked != null) {
      // Format date as YYYY-MM-DD
      final formattedDate =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      childAgeController.text = formattedDate;
    }
  }

  // Loading state for login and signup
  final isLoading = false.obs;
  final isSignUpLoading = false.obs;
  final isOtpVerifying = false.obs;
  final isOnboardingLoading = false.obs;

  // Store signup data for OTP verification
  String signUpEmail = '';
  bool signUpRememberMe = false;

  // Store onboarding data
  OnboardingResponseModel? onboardingResponse;
  String selectedMode = 'independent'; // 'independent' or 'bridge'
  String partnerCode = ''; // Store partner code for joining existing account

  // Login method
  Future<void> login() async {
    // Validate input
    if (emailController.text.trim().isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please enter your email address",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }

    if (passwordController.text.trim().isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please enter your password",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }

    // Basic email validation
    if (!GetUtils.isEmail(emailController.text.trim())) {
      kSnackBar(
        title: "Validation Error",
        message: "Please enter a valid email address",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }

    try {
      isLoading.value = true;

      // Create login request model
      final loginRequest = LoginRequestModel(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Make API call
      final response = await BaseClient.postRequest(
        api: Api.login,
        body: jsonEncode(loginRequest.toJson()),
        headers: BaseClient.basicHeaders,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parse response
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final loginResponse = LoginResponseModel.fromJson(responseData);

        // Store tokens and user role only if remember me is enabled
        if (rememberMe.value) {
          await BaseClient.storeTokens(
            accessToken: loginResponse.accessToken,
            refreshToken: loginResponse.refreshToken,
          );
          await BaseClient.storeRole(role: loginResponse.role);
        } else {
          // Clear any existing tokens if remember me is disabled
          await BaseClient.clearTokens();
        }

        // Show success message
        kSnackBar(
          title: "Success",
          message: loginResponse.message.isNotEmpty
              ? loginResponse.message
              : "Successfully logged in",
          bgColor: AppColors.appColor,
        );

        // Navigate to home
        Get.offAll(() => const HomeView());
      } else {
        // Handle error response
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        String errorMessage = "Login failed. Please try again.";

        // Check for non_field_errors (Django REST Framework format)
        if (errorData.containsKey('non_field_errors')) {
          final errors = errorData['non_field_errors'];
          if (errors is List && errors.isNotEmpty) {
            errorMessage = errors[0].toString();
          }
        } else if (errorData.containsKey('message')) {
          errorMessage = errorData['message'];
        } else if (errorData.containsKey('detail')) {
          errorMessage = errorData['detail'];
        } else if (errorData.containsKey('error')) {
          errorMessage = errorData['error'];
        }

        kSnackBar(
          title: "Login Failed",
          message: errorMessage,
          bgColor: AppColors.snackBarWarning,
        );
      }
    } catch (e) {
      // Handle exceptions
      kSnackBar(
        title: "Error",
        message: "An error occurred during login. Please try again.",
        bgColor: AppColors.snackBarWarning,
      );
      debugPrint("Login error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Sign Up method
  Future<void> signUp() async {
    // Validate input
    if (emailController.text.trim().isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please enter your email address",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }

    // Basic email validation
    if (!GetUtils.isEmail(emailController.text.trim())) {
      kSnackBar(
        title: "Validation Error",
        message: "Please enter a valid email address",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }

    if (passwordController.text.trim().isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please enter your password",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }

    if (confirmPasswordController.text.trim().isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please confirm your password",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }

    // Check if passwords match
    if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      kSnackBar(
        title: "Validation Error",
        message: "Passwords do not match",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }

    // Password strength validation (minimum 6 characters)
    if (passwordController.text.trim().length < 6) {
      kSnackBar(
        title: "Validation Error",
        message: "Password must be at least 6 characters long",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }

    try {
      isSignUpLoading.value = true;

      // Create signup request model
      final signUpRequest = SignUpRequestModel(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Make API call
      final response = await BaseClient.postRequest(
        api: Api.signup,
        body: jsonEncode(signUpRequest.toJson()),
        headers: BaseClient.basicHeaders,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parse response
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final signUpResponse = SignUpResponseModel.fromJson(responseData);

        // Store signup data for OTP verification
        signUpEmail = emailController.text.trim();
        signUpRememberMe = rememberMe.value;

        // Show success message
        kSnackBar(
          title: "Success",
          message: signUpResponse.message.isNotEmpty
              ? signUpResponse.message
              : "Account created successfully",
          bgColor: AppColors.appColor,
        );

        // Navigate to OTP verification
        Get.to(() => OtpVerificationsView(isAuth: true));
        // if (!message.contains('already exists') &&
        //     !message.contains('inactive') &&
        //     !message.contains('new otp has been sent')) {
        //   // Navigate to OTP verification for new user registration
        //   Get.to(() => OtpVerificationsView(isAuth: true));
        // }
      } else {
        // Handle error response
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        String errorMessage = "Sign up failed. Please try again.";

        // Check for non_field_errors (Django REST Framework format)
        if (errorData.containsKey('non_field_errors')) {
          final errors = errorData['non_field_errors'];
          if (errors is List && errors.isNotEmpty) {
            errorMessage = errors[0].toString();
          }
        } else if (errorData.containsKey('email')) {
          final errors = errorData['email'];
          if (errors is List && errors.isNotEmpty) {
            errorMessage = errors[0].toString();
          }
        } else if (errorData.containsKey('password')) {
          final errors = errorData['password'];
          if (errors is List && errors.isNotEmpty) {
            errorMessage = errors[0].toString();
          }
        } else if (errorData.containsKey('message')) {
          errorMessage = errorData['message'];
        } else if (errorData.containsKey('detail')) {
          errorMessage = errorData['detail'];
        } else if (errorData.containsKey('error')) {
          errorMessage = errorData['error'];
        }

        kSnackBar(
          title: "Sign Up Failed",
          message: errorMessage,
          bgColor: AppColors.snackBarWarning,
        );
      }
    } catch (e) {
      // Handle exceptions
      kSnackBar(
        title: "Error",
        message: "An error occurred during sign up. Please try again.",
        bgColor: AppColors.snackBarWarning,
      );
      debugPrint("Sign up error: $e");
    } finally {
      isSignUpLoading.value = false;
    }
  }

  // OTP Verification method
  Future<void> verifyOTP(String otp) async {
    // Validate OTP
    if (otp.trim().isEmpty || otp.trim().length != 4) {
      kSnackBar(
        title: "Validation Error",
        message: "Please enter a valid 4-digit OTP",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }

    // Validate email (should be stored from signup)
    if (signUpEmail.isEmpty) {
      kSnackBar(
        title: "Error",
        message: "Email not found. Please sign up again.",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }

    try {
      isOtpVerifying.value = true;

      // Create OTP verification request model
      final otpRequest = OtpVerificationRequestModel(
        email: signUpEmail,
        otp: otp.trim(),
      );

      // Make API call
      final response = await BaseClient.postRequest(
        api: Api.activate,
        body: jsonEncode(otpRequest.toJson()),
        headers: BaseClient.basicHeaders,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parse response
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final otpResponse = OtpVerificationResponseModel.fromJson(responseData);

        // ALWAYS store tokens after OTP verification since user is now authenticated
        await BaseClient.storeTokens(
          accessToken: otpResponse.accessToken,
          refreshToken: otpResponse.refreshToken,
        );
        await BaseClient.storeRole(role: otpResponse.role);

        // Show success message
        kSnackBar(
          title: "Success",
          message: otpResponse.message.isNotEmpty
              ? otpResponse.message
              : "Account activated successfully",
          bgColor: AppColors.appColor,
        );

        // Clear signup data
        signUpEmail = '';
        signUpRememberMe = false;

        // Navigate to BasicInformationView to collect user info
        Get.offAll(() => const ChooseMode());
      } else {
        // Handle error response
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        String errorMessage = "OTP verification failed. Please try again.";

        // Check for non_field_errors (Django REST Framework format)
        if (errorData.containsKey('non_field_errors')) {
          final errors = errorData['non_field_errors'];
          if (errors is List && errors.isNotEmpty) {
            errorMessage = errors[0].toString();
          }
        } else if (errorData.containsKey('otp')) {
          final errors = errorData['otp'];
          if (errors is List && errors.isNotEmpty) {
            errorMessage = errors[0].toString();
          }
        } else if (errorData.containsKey('email')) {
          final errors = errorData['email'];
          if (errors is List && errors.isNotEmpty) {
            errorMessage = errors[0].toString();
          }
        } else if (errorData.containsKey('message')) {
          errorMessage = errorData['message'];
        } else if (errorData.containsKey('detail')) {
          errorMessage = errorData['detail'];
        } else if (errorData.containsKey('error')) {
          errorMessage = errorData['error'];
        }

        kSnackBar(
          title: "Verification Failed",
          message: errorMessage,
          bgColor: AppColors.snackBarWarning,
        );
      }
    } catch (e) {
      // Handle exceptions
      kSnackBar(
        title: "Error",
        message: "An error occurred during OTP verification. Please try again.",
        bgColor: AppColors.snackBarWarning,
      );
      debugPrint("OTP verification error: $e");
    } finally {
      isOtpVerifying.value = false;
    }
  }

  // Onboarding method
  Future<void> submitOnboarding() async {
    // Validate input
    if (nameController.text.trim().isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please enter your name",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }

    if (phoneController.text.trim().isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please enter your phone number",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }

    if (sateController.text.trim().isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please enter your state",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }

    // Validate that at least one child is added
    if (childrenList.isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please add at least one child",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }

    // Validate role selection
    if (!role1.value && !role2.value) {
      kSnackBar(
        title: "Validation Error",
        message: "Please select your role (Mom/Dad)",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }

    try {
      isOnboardingLoading.value = true;

      // Debug: Check if token exists before making API call
      final accessToken = await BaseClient.getAccessToken();
      debugPrint('🔑 Onboarding - Access Token: $accessToken');

      if (accessToken == null || accessToken.isEmpty) {
        kSnackBar(
          title: "Authentication Error",
          message: "Session expired. Please login again.",
          bgColor: AppColors.snackBarWarning,
        );
        isOnboardingLoading.value = false;
        return;
      }

      // Use the children list
      List<ChildModel> children = childrenList;

      // Determine role
      String role = role1.value ? 'mother' : 'father';

      // Create onboarding request model
      final onboardingRequest = OnboardingRequestModel(
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
        state: sateController.text.trim(),
        children: children,
        courtMandated: isCourtMandated2.value,
        role: role,
        mode: selectedMode,
        partnerCode: partnerCode.isNotEmpty ? partnerCode : null,
      );

      // Make API call
      final response = await BaseClient.postRequest(
        api: Api.onboarding,
        body: jsonEncode(onboardingRequest.toJson()),
        headers: BaseClient.authHeaders(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parse response
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final onboardingResponseData = OnboardingResponseModel.fromJson(
          responseData,
        );

        // Store onboarding response
        onboardingResponse = onboardingResponseData;

        // Show success message
        kSnackBar(
          title: "Success",
          message: onboardingResponseData.message.isNotEmpty
              ? onboardingResponseData.message
              : "Onboarding completed successfully",
          bgColor: AppColors.appColor,
        );

        // Clear all text fields and children list after successful onboarding
        nameController.clear();
        phoneController.clear();
        childNameController.clear();
        childAgeController.clear();
        sateController.clear();
        childrenList.clear();

        // Navigate based on mode
        if (selectedMode == 'independent') {
          Get.to(() => const IndependentModeView());
        } else {
          // Navigate to bridge mode view
          Get.to(() => const BridgeModeView());
        }
      } else {
        // Handle error response
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        String errorMessage = "Onboarding failed. Please try again.";

        // Check for various error formats
        if (errorData.containsKey('non_field_errors')) {
          final errors = errorData['non_field_errors'];
          if (errors is List && errors.isNotEmpty) {
            errorMessage = errors[0].toString();
          }
        } else if (errorData.containsKey('message')) {
          errorMessage = errorData['message'];
        } else if (errorData.containsKey('detail')) {
          errorMessage = errorData['detail'];
        } else if (errorData.containsKey('error')) {
          errorMessage = errorData['error'];
        }

        kSnackBar(
          title: "Onboarding Failed",
          message: errorMessage,
          bgColor: AppColors.snackBarWarning,
        );
      }
    } catch (e) {
      // Handle exceptions
      kSnackBar(
        title: "Error",
        message: "An error occurred during onboarding. Please try again.",
        bgColor: AppColors.snackBarWarning,
      );
      debugPrint("Onboarding error: $e");
    } finally {
      isOnboardingLoading.value = false;
    }
  }

  // Join Partner Onboarding method (without children)
  Future<void> submitJoinPartnerOnboarding() async {
    // Validate input
    if (nameController.text.trim().isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please enter your name",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }

    if (phoneController.text.trim().isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please enter your phone number",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }

    if (sateController.text.trim().isEmpty) {
      kSnackBar(
        title: "Validation Error",
        message: "Please enter your state",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }

    // Validate role selection
    if (!role1.value && !role2.value) {
      kSnackBar(
        title: "Validation Error",
        message: "Please select your role (Mom/Dad)",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }

    // Validate partner code
    if (partnerCode.isEmpty) {
      kSnackBar(
        title: "Error",
        message: "Partner code not found. Please try again.",
        bgColor: AppColors.snackBarWarning,
      );
      return;
    }

    try {
      isOnboardingLoading.value = true;

      // Debug: Check if token exists before making API call
      final accessToken = await BaseClient.getAccessToken();
      debugPrint('🔑 Join Partner Onboarding - Access Token: $accessToken');

      if (accessToken == null || accessToken.isEmpty) {
        kSnackBar(
          title: "Authentication Error",
          message: "Session expired. Please login again.",
          bgColor: AppColors.snackBarWarning,
        );
        isOnboardingLoading.value = false;
        return;
      }

      // Determine role
      String role = role1.value ? 'mother' : 'father';

      // Create request body without children
      final requestBody = {
        'name': nameController.text.trim(),
        'phone': phoneController.text.trim(),
        'state': sateController.text.trim(),
        'court_mandated': isCourtMandated2.value,
        'role': role,
        'partner_code': partnerCode,
      };

      // Make API call
      final response = await BaseClient.postRequest(
        api: Api.onboarding,
        body: jsonEncode(requestBody),
        headers: BaseClient.authHeaders(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parse response
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // Show success message
        kSnackBar(
          title: "Success",
          message:
              responseData['message'] ??
              "Successfully joined partner's account",
          bgColor: AppColors.appColor,
        );

        // Clear all text fields after successful onboarding
        nameController.clear();
        phoneController.clear();
        sateController.clear();
        partnerCode = '';

        // Navigate to home
        Get.offAll(() => const HomeView());
      } else {
        // Handle error response
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        String errorMessage =
            "Failed to join partner's account. Please try again.";

        // Check for various error formats
        if (errorData.containsKey('non_field_errors')) {
          final errors = errorData['non_field_errors'];
          if (errors is List && errors.isNotEmpty) {
            errorMessage = errors[0].toString();
          }
        } else if (errorData.containsKey('message')) {
          errorMessage = errorData['message'];
        } else if (errorData.containsKey('detail')) {
          errorMessage = errorData['detail'];
        } else if (errorData.containsKey('error')) {
          errorMessage = errorData['error'];
        } else if (errorData.containsKey('partner_code')) {
          final errors = errorData['partner_code'];
          if (errors is List && errors.isNotEmpty) {
            errorMessage = errors[0].toString();
          }
        }

        kSnackBar(
          title: "Error",
          message: errorMessage,
          bgColor: AppColors.snackBarWarning,
        );
      }
    } catch (e) {
      // Handle exceptions
      kSnackBar(
        title: "Error",
        message: "An error occurred. Please try again.",
        bgColor: AppColors.snackBarWarning,
      );
      debugPrint("Join Partner Onboarding error: $e");
    } finally {
      isOnboardingLoading.value = false;
    }
  }

  @override
  void onClose() {
    // Dispose controllers to prevent memory leaks
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    childNameController.dispose();
    childAgeController.dispose();
    sateController.dispose();
    exampleController.dispose();
    super.onClose();
  }
}
