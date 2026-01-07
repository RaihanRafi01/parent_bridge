class Api {
  /// base url
  static const baseUrl = "http://10.10.13.73:7000";
  static const baseUrl2 = "http://10.10.13.73:7000/";
  static const baseUrlApi = "$baseUrl/api";
  static const baseUrlPicture = baseUrl;

  static String getBaseUrlWithoutProtocol() {
    return baseUrl.replaceFirst('https://', '');
  }

  static String wsBaseUrl() => 'ws://${getBaseUrlWithoutProtocol()}';

  ///auth
  static const signup = "$baseUrlApi/v1/auth/signup/";
  static const login = "$baseUrlApi/v1/auth/login/";
  static const activate = "$baseUrlApi/v1/auth/activate/";
  static const onboarding = "$baseUrlApi/v1/auth/onboarding/";
  static const createToken = "$baseUrlApi/v1/auth/token/refresh/";
  //   static const createOtp = '$baseUrlApi/auth/otp/create/';
  //   static const verifyOtp = '$baseUrlApi/auth/otp/verify/';
  //   static const String passwordResetRequest = '$baseUrlApi/auth/password-reset/request/';
  //   static const String passwordResetConfirm = '$baseUrlApi/auth/password-reset/confirm/';

  ///event
  static const createEvent = "$baseUrlApi/v1/event/add/";
  static const createHoliday = "$baseUrlApi/v1/event/holiday/add/";
  static const eventList = "$baseUrlApi/v1/event/list/";
  static const events = "$baseUrlApi/v1/event/";
  static const holidays = "$baseUrlApi/v1/event/holiday/";




  ///bridge
  static const bridgeInfo = "$baseUrlApi/v1/bridge/info/";

  //   /// Subscription
  //   static const String fetchSubscriptionData = '$baseUrlApi/payment/me/';
  //   static const String checkoutSession = '$baseUrlApi/payment/create-checkout-session/';
  //   static const String subscriptionPlans = '$baseUrlApi/payment/get_all/subscribtions-plan/';

  //   /// profile
  //   static const String profile = '$baseUrlApi/auth/profile/';

  // // // static getMessages(room_id) => '$baseUrlApi/chat/rooms/$room_id/messages/';

  //  /// form
  //   static const String narrationGenerate = '$baseUrlApi/narration/narration_genarate/';
  //   static const String submitForm = '$baseUrlApi/vaform/submit/';
  //   static const String vaFormGeneratedList = '$baseUrlApi/va/vaform/generated/list/';

  //   /// support
  //   static const String startChat = '$baseUrlApi/support/start/';
  //   static const String closeChat = '$baseUrlApi/support/admin/chat/close/';
  //   static const String checkExistingChat = '$baseUrlApi/support/user/get/support/chat-id/';
  //   static getMessagesList(room_id) => '$baseUrlApi/support/message/list/$room_id/';
}
