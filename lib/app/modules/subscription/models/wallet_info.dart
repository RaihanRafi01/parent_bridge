class WalletInfo {
  final double balance;
  final List<Transaction> transactions;

  WalletInfo({
    required this.balance,
    required this.transactions,
  });

  factory WalletInfo.fromJson(Map<String, dynamic> json) {
    // The API structure has a "data" wrapper
    final data = json['data'] ?? {};

    var transactionList = (data['transactions'] as List?) ?? [];
    List<Transaction> transactions = transactionList
        .map((t) => Transaction.fromJson(t))
        .toList();

    return WalletInfo(
      // Parsing balance as double (handles int or double from API)
      balance: (data['balance'] ?? 0).toDouble(),
      transactions: transactions,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'balance': balance,
      'transactions': transactions.map((t) => t.toJson()).toList(),
    };
  }
}

class Transaction {
  final int id;
  final double amount;
  final String transactionType; // "credit" or "debit"
  final String description;
  final String createdAt;
  final String costType;

  Transaction({
    required this.id,
    required this.amount,
    required this.transactionType,
    required this.description,
    required this.createdAt,
    required this.costType,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] ?? 0,
      // API returns amount as a String "40.00", we convert to double
      amount: double.tryParse(json['amount']?.toString() ?? '0.0') ?? 0.0,
      transactionType: json['transaction_type'] ?? 'credit',
      description: json['description'] ?? '',
      createdAt: json['created_at'] ?? '',
      costType: json['cost_type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'transaction_type': transactionType,
      'description': description,
      'created_at': createdAt,
      'cost_type': costType,
    };
  }
}