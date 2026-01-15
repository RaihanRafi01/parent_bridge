class WalletRequestModel {
  final int amount;

  WalletRequestModel({
    required this.amount,
  });

  // Convert EventRequestModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
    };
  }

  // Create an EventRequestModel from JSON
  factory WalletRequestModel.fromJson(Map<int, dynamic> json) {
    return WalletRequestModel(
      amount: json['amount'] ?? 0,
    );
  }
}
