class SignUpRequestModel {
  final String email;
  final String password;

  SignUpRequestModel({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}
