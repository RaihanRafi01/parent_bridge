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
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
