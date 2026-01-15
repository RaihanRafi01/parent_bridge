class TopUpPackage {
  final int id;
  final String amount;
  final String bonus;
  final String description;

  TopUpPackage({
    required this.id,
    required this.amount,
    required this.bonus,
    required this.description,
  });

  factory TopUpPackage.fromJson(Map<String, dynamic> json) {
    return TopUpPackage(
      id: json['id'] ?? 0,
      // API returns strings "50.00", we convert to double
      amount: json['amount'] ?? '0.0',
      bonus: json['bonus'] ?? '0.0',
      description: json['description'] ?? '',
    );
  }
}