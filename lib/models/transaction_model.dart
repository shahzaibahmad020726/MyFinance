class TransactionModel {
  final String id;
  final String title;
  final double amount;
  final bool isIncome;
  final String category;
  final DateTime date;
  final String? userId;

  TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.isIncome,
    required this.category,
    required this.date,
    required this.userId,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'amount': amount,
    'isIncome': isIncome,
    'category': category,
    'date': date.toIso8601String(),
    'userId': userId,
  };

  static TransactionModel fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json['id'],
        title: json['title'],
        amount: json['amount'],
        isIncome: json['isIncome'],
        category: json['category'],
        date: DateTime.parse(json['date']),
        userId: json['userId'],
      );
}
