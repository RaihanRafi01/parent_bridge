import 'package:get/get.dart';
import '../modules/authentication/bindings/authentication_binding.dart';
import '../modules/authentication/views/authentication_view.dart';
import '../modules/calendar/bindings/calendar_binding.dart';
import '../modules/calendar/views/calendar_view.dart';
import '../modules/call/bindings/call_binding.dart';
import '../modules/call/views/call_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/document_vault/bindings/document_vault_binding.dart';
import '../modules/document_vault/views/document_vault_view.dart';
import '../modules/expense_tracker/bindings/expense_tracker_binding.dart';
import '../modules/expense_tracker/views/expense_tracker_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/legal_records/bindings/legal_records_binding.dart';
import '../modules/legal_records/views/legal_records_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/support_forum/bindings/support_forum_binding.dart';
import '../modules/support_forum/views/support_forum_view.dart';
import '../modules/sign_up_process/bindings/sign_up_process_binding.dart';
import '../modules/sign_up_process/views/sign_up_process_view.dart';
import '../modules/subscription/bindings/subscription_binding.dart';
import '../modules/subscription/views/subscription_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.home;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    // GetPage(
    //   name: _Paths.DOCUMENT_VAULT,
    //   page: () => const DocumentAdd(),
    //   binding: DocumentVaultBinding(),
    // ),
    GetPage(
      name: _Paths.authentication,
      page: () => const AuthenticationView(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      name: _Paths.onboarding,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.chat,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.call,
      page: () => const CallView(),
      binding: CallBinding(),
    ),
    GetPage(
      name: _Paths.calendar,
      page: () => const CalendarView(),
      binding: CalendarBinding(),
    ),
    GetPage(
      name: _Paths.expenseTracker,
      page: () => const ExpenseTrackerView(),
      binding: ExpenseTrackerBinding(),
    ),
    GetPage(
      name: _Paths.documentVault,
      page: () => const DocumentVaultView(),
      binding: DocumentVaultBinding(),
    ),
    GetPage(
      name: _Paths.supportForum,
      page: () => const SupportForumView(),
      binding: SupportForumBinding(),
    ),
    GetPage(
      name: _Paths.legalRecords,
      page: () => const LegalRecordsView(),
      binding: LegalRecordsBinding(),
    ),
    GetPage(
      name: _Paths.settings,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.signUpProcess,
      page: () => const SignUpProcessView(),
      binding: SignUpProcessBinding(),
    ),
    GetPage(
      name: _Paths.subscription,
      page: () => const SubscriptionView(),
      binding: SubscriptionBinding(),
    ),
  ];
}
