import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/widgets/custom_snackbar.dart';
import '../../../core/constants/api.dart';
import '../../../core/services/base_client.dart';
import '../models/stripe_checkout_response_model.dart';
import '../models/top_up_package.dart';
import '../models/wallet_info.dart';
import '../views/web_view_screen.dart';

class SubscriptionController extends GetxController {
  List<String> proFeatures = [
    'Unlimited messages and message filtering',
    'Independent use – one parent can use even if the other does not',
    'Access to both filtered & unfiltered message views',
    'AI tone support to avoid unnecessary conflict',
    'Exportable PDF message transcripts (filtered & original)',
    'Flag and key hostile messages',
    'Threat & Safety Alert System',
    'Shared Calendar & multiple child profiles',
  ];

  List<String> proFeatures2 = [
    'Everything in ParentBridge Pro, plus…',
    'Ability to call Co-parent and record calls',
    'The option to download recorded calls.',
    'Document Vault Uploads (unlimited)',
    'Secure PDF downloads of parenting plans, messages, and logs',
    'Expense tracking',
    'Access to Community Support Forum',
    'Early Access to new features',
  ];

  final count = 0.obs;

  void increment() => count.value++;

  var callNotifications = true.obs;
  var calendarNotifications = true.obs;
  var expenseRequests = false.obs;

  // The wallet data: grouped by date string (YYYY-MM-DD)
  final walletTransactions = <String, List<Map<String, dynamic>>>{}.obs;
  final balance = 0.0.obs;
  // Loading and error states
  final isLoading = true.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Simulate network delay, then load sample data
    // Future.delayed(const Duration(milliseconds: 800), () {
    //   _initializeSampleWalletTransactions();
    //   isLoading.value = false;
    // });
    fetchWallet();
    fetchTopUpPackages();
  }

  // void _initializeSampleWalletTransactions() {
  //   final today = DateTime(
  //     2026,
  //     1,
  //     7,
  //   ); // Matches "The current date is January 07, 2026"
  //
  //   final todayKey =
  //       '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';
  //
  //   walletTransactions[todayKey] = [
  //     {
  //       'id': '1',
  //       'type': 'credit',
  //       'description': 'Wallet Top-up',
  //       'amount': 50.00,
  //       'date': today,
  //       'createdAt': today.copyWith(hour: 9, minute: 15),
  //     },
  //     {
  //       'id': '2',
  //       'type': 'debit',
  //       'description': 'Voice Call - 5 minutes',
  //       'amount': 2.50,
  //       'date': today,
  //       'createdAt': today.copyWith(hour: 11, minute: 30),
  //     },
  //     {
  //       'id': '3',
  //       'type': 'debit',
  //       'description': 'SMS Message',
  //       'amount': 0.50,
  //       'date': today,
  //       'createdAt': today.copyWith(hour: 14, minute: 45),
  //     },
  //   ];
  //
  //   final tomorrow = today.add(const Duration(days: 1));
  //   final tomorrowKey =
  //       '${tomorrow.year}-${tomorrow.month.toString().padLeft(2, '0')}-${tomorrow.day.toString().padLeft(2, '0')}';
  //
  //   walletTransactions[tomorrowKey] = [
  //     {
  //       'id': '4',
  //       'type': 'credit',
  //       'description': 'Wallet Top-up',
  //       'amount': 100.00,
  //       'date': tomorrow,
  //       'createdAt': tomorrow.copyWith(hour: 8, minute: 0),
  //     },
  //     {
  //       'id': '5',
  //       'type': 'debit',
  //       'description': 'Data Bundle Purchase',
  //       'amount': 15.00,
  //       'date': tomorrow,
  //       'createdAt': tomorrow.copyWith(hour: 10, minute: 20),
  //     },
  //   ];
  //
  //   final dayAfter = today.add(const Duration(days: 2));
  //   final dayAfterKey =
  //       '${dayAfter.year}-${dayAfter.month.toString().padLeft(2, '0')}-${dayAfter.day.toString().padLeft(2, '0')}';
  //
  //   walletTransactions[dayAfterKey] = [
  //     {
  //       'id': '6',
  //       'type': 'debit',
  //       'description': 'International Call',
  //       'amount': 8.00,
  //       'date': dayAfter,
  //       'createdAt': dayAfter.copyWith(hour: 16, minute: 10),
  //     },
  //     {
  //       'id': '7',
  //       'type': 'credit',
  //       'description': 'Referral Bonus',
  //       'amount': 10.00,
  //       'date': dayAfter,
  //       'createdAt': dayAfter.copyWith(hour: 18, minute: 0),
  //     },
  //   ];
  //
  //   // Important: trigger reactivity
  //   walletTransactions.refresh();
  // }

  final topUpPackages = <Map<String, dynamic>>[].obs;

  Future<void> fetchWallet() async {
    try {
      isLoading.value = true;

      final response = await BaseClient.getRequest(
        api: Api.walletHistory,
        headers: BaseClient.authHeaders(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // 1. Use the model to parse the raw data
        final walletInfo = WalletInfo.fromJson(responseData);

        // 2. Update the balance
        balance.value = walletInfo.balance;

        // 3. Clear existing transactions and group new ones by date
        Map<String, List<Map<String, dynamic>>> groupedData = {};

        for (var t in walletInfo.transactions) {
          // Parse the date string "2026-01-15T..."
          DateTime date = DateTime.parse(t.createdAt).toLocal();
          // Create a key like "2026-01-15"
          String dateKey = DateFormat('yyyy-MM-dd').format(date);

          // Convert the Transaction model back to the Map format the UI expects
          final transactionMap = {
            'id': t.id,
            'amount': t.amount,
            'type': t.transactionType, // Maps "credit"/"debit"
            'description': t.description,
            'createdAt': date, // DateTime object for the UI
            'costType': t.costType,
          };

          if (groupedData.containsKey(dateKey)) {
            groupedData[dateKey]!.add(transactionMap);
          } else {
            groupedData[dateKey] = [transactionMap];
          }
        }

        // 4. Assign to observable and refresh
        walletTransactions.assignAll(groupedData);
        walletTransactions.refresh();
      } else {
        _showError("Failed to fetch wallet data");
      }
    } catch (e) {
      debugPrint("Wallet fetch error: $e");
      _showError("An error occurred while connecting to the server.");
    } finally {
      isLoading.value = false;
    }
  }

  void _showError(String message) {
    kSnackBar(
      title: "Error",
      message: message,
      bgColor: AppColors.snackBarWarning,
    );
  }

  Future<void> createSubscription(int amount) async {
    isLoading.value = true;
    try {
      final walletRequest = {"amount": amount};

      final response = await BaseClient.postRequest(
        api: Api.wallet,
        headers: BaseClient.authHeaders(),
        body: jsonEncode(walletRequest),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final stripeResponse = StripeCheckoutResponse.fromJson(responseData);

        if (stripeResponse.checkoutUrl.isNotEmpty) {
          // AWAIT the navigation so we know when the user is back
          await Get.to(() => WebViewScreen(url: stripeResponse.checkoutUrl));

          // Once the user returns from WebView, refresh the data to update balance & list
          await fetchWallet();

          kSnackBar(
            title: "Wallet Updated",
            message: "Your transaction has been processed.",
            bgColor: AppColors.appColor,
          );
        } else {
          _handleError("Checkout URL not found.");
        }
      } else {
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        _handleError(
          errorData['message'] ?? "Failed to create checkout session.",
        );
      }
    } catch (e) {
      _handleError("An unexpected error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Helper to keep code clean
  void _handleError(String message) {
    kSnackBar(
      title: 'Error',
      message: message,
      bgColor: AppColors.snackBarWarning,
    );
  }

  Future<void> fetchTopUpPackages() async {
    try {
      isLoading.value = true;

      final response = await BaseClient.getRequest(
        api: Api.topUpPackages, // Ensure this endpoint is defined
        headers: BaseClient.authHeaders(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // Access the 'data' list from the JSON
        final List<dynamic> packageData = responseData['data'] ?? [];

        // Map the API data into the format your UI expects
        final List<Map<String, dynamic>> mappedPackages = packageData.map((
          item,
        ) {
          final pkg = TopUpPackage.fromJson(item);
          return {
            'package': pkg.amount, // Changed to double for easier UI math
            'bonus': double.parse(pkg.bonus) > 0
                ? pkg.bonus
                : null, // Handle null bonus for UI
            'id': pkg.id,
            'description': pkg.description,
          };
        }).toList();

        // Update the observable list
        topUpPackages.assignAll(mappedPackages);
      } else {
        _showError("Failed to load packages");
      }
    } catch (e) {
      debugPrint("Package fetch error: $e");
      _showError("Connection error while fetching packages");
    } finally {
      isLoading.value = false;
    }
  }
}
