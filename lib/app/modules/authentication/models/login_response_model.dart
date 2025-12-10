class LoginResponseModel {
  final String email;
  final String role;
  final String accessToken;
  final String refreshToken;
  final String message;

  LoginResponseModel({
    required this.email,
    required this.role,
    required this.accessToken,
    required this.refreshToken,
    required this.message,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      accessToken: json['access_token'] ?? '',
      refreshToken: json['refresh_token'] ?? '',
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'role': role,
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'message': message,
    };
  }
}
