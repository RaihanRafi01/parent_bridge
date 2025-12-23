class OnboardingDataModel {
  final String shareableCode;
  final String twilioPhoneNumber;
  final bool modePage;
  final bool bridgeModePage;
  final bool independentModePage;

  OnboardingDataModel({
    required this.shareableCode,
    required this.twilioPhoneNumber,
    required this.modePage,
    required this.bridgeModePage,
    required this.independentModePage,
  });

  factory OnboardingDataModel.fromJson(Map<String, dynamic> json) {
    return OnboardingDataModel(
      shareableCode: json['shareable_code'] ?? '',
      twilioPhoneNumber: json['twilio_phone_number'] ?? '',
      modePage: json['mode_page'] ?? false,
      bridgeModePage: json['bridge_mode_page'] ?? false,
      independentModePage: json['independent_mode_page'] ?? false,
    );
  }
}

class OnboardingResponseModel {
  final String message;
  final OnboardingDataModel data;

  OnboardingResponseModel({required this.message, required this.data});

  factory OnboardingResponseModel.fromJson(Map<String, dynamic> json) {
    return OnboardingResponseModel(
      message: json['message'] ?? '',
      data: OnboardingDataModel.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message};
  }
}
