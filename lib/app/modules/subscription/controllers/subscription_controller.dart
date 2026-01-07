import 'package:get/get.dart';

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

  // Loading and error states
  final isLoading = true.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Simulate network delay, then load sample data
    Future.delayed(const Duration(milliseconds: 800), () {
      _initializeSampleWalletTransactions();
      isLoading.value = false;
    });
  }

  void _initializeSampleWalletTransactions() {
    final today = DateTime(2026, 1, 7); // Matches "The current date is January 07, 2026"

    final todayKey =
        '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

    walletTransactions[todayKey] = [
      {
        'id': '1',
        'type': 'credit',
        'description': 'Wallet Top-up',
        'amount': 50.00,
        'date': today,
        'createdAt': today.copyWith(hour: 9, minute: 15),
      },
      {
        'id': '2',
        'type': 'debit',
        'description': 'Voice Call - 5 minutes',
        'amount': 2.50,
        'date': today,
        'createdAt': today.copyWith(hour: 11, minute: 30),
      },
      {
        'id': '3',
        'type': 'debit',
        'description': 'SMS Message',
        'amount': 0.50,
        'date': today,
        'createdAt': today.copyWith(hour: 14, minute: 45),
      },
    ];

    final tomorrow = today.add(const Duration(days: 1));
    final tomorrowKey =
        '${tomorrow.year}-${tomorrow.month.toString().padLeft(2, '0')}-${tomorrow.day.toString().padLeft(2, '0')}';

    walletTransactions[tomorrowKey] = [
      {
        'id': '4',
        'type': 'credit',
        'description': 'Wallet Top-up',
        'amount': 100.00,
        'date': tomorrow,
        'createdAt': tomorrow.copyWith(hour: 8, minute: 0),
      },
      {
        'id': '5',
        'type': 'debit',
        'description': 'Data Bundle Purchase',
        'amount': 15.00,
        'date': tomorrow,
        'createdAt': tomorrow.copyWith(hour: 10, minute: 20),
      },
    ];

    final dayAfter = today.add(const Duration(days: 2));
    final dayAfterKey =
        '${dayAfter.year}-${dayAfter.month.toString().padLeft(2, '0')}-${dayAfter.day.toString().padLeft(2, '0')}';

    walletTransactions[dayAfterKey] = [
      {
        'id': '6',
        'type': 'debit',
        'description': 'International Call',
        'amount': 8.00,
        'date': dayAfter,
        'createdAt': dayAfter.copyWith(hour: 16, minute: 10),
      },
      {
        'id': '7',
        'type': 'credit',
        'description': 'Referral Bonus',
        'amount': 10.00,
        'date': dayAfter,
        'createdAt': dayAfter.copyWith(hour: 18, minute: 0),
      },
    ];

    // Important: trigger reactivity
    walletTransactions.refresh();
  }


// Now use 'allTransactions' for balance, and 'sortedDates' for grouped history
}
