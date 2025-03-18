import 'package:flutter/material.dart';
import 'package:my_finance/models/transaction_model.dart';

class TransactionItem extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionItem({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          transaction.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(transaction.category),
        trailing: Text(
          "${transaction.isIncome ? '+' : '-'}\$${transaction.amount.toStringAsFixed(2)}",
          style: TextStyle(
            color: transaction.isIncome ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
