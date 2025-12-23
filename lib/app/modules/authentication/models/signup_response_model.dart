class SignUpResponseModel {
  final String message;

  SignUpResponseModel({required this.message});

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) {
    return SignUpResponseModel(message: json['message'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'message': message};
  }
}
