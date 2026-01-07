class WalletInfo {
  final double balance;
  final double availableToSpend;
  final List<Transaction> transactions;

  WalletInfo({
    required this.balance,
    required this.availableToSpend,
    required this.transactions,
  });

  // Convert WalletInfo to JSON
  Map<String, dynamic> toJson() {
    return {
      'balance': balance,
      'available_to_spend': availableToSpend,
      'transactions': transactions.map((transaction) => transaction.toJson()).toList(),
    };
  }

  // Create WalletInfo from JSON
  factory WalletInfo.fromJson(Map<String, dynamic> json) {
    var transactionList = json['transactions'] as List;
    List<Transaction> transactions = transactionList.map((transactionJson) => Transaction.fromJson(transactionJson)).toList();

    return WalletInfo(
      balance: json['balance'] ?? 0.0,
      availableToSpend: json['available_to_spend'] ?? 0.0,
      transactions: transactions,
    );
  }
}

class Transaction {
  final String description;
  final String time;
  final double amount;
  final String type; // "credit" or "debit"

  Transaction({
    required this.description,
    required this.time,
    required this.amount,
    required this.type,
  });

  // Convert Transaction to JSON
  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'time': time,
      'amount': amount,
      'type': type,
    };
  }

  // Create Transaction from JSON
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      description: json['description'] ?? '',
      time: json['time'] ?? '',
      amount: json['amount'] ?? 0.0,
      type: json['type'] ?? 'credit', // Defaulting to 'credit' if type is missing
    );
  }
}
