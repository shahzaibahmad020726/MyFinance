import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_finance/models/transaction_model.dart';
import 'package:my_finance/providers/transaction_provider.dart';
import 'package:provider/provider.dart';

class TransactionItem extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionItem({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat.yMMMd().format(transaction.date);
    return Card(
      child: ListTile(
        title: Row(
          spacing: 5,
          children: [
            Text(
              transaction.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            Text(
              "${transaction.isIncome ? '+' : '-'}\$${transaction.amount.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 14,
                color: transaction.isIncome ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        subtitle: Text("${transaction.category} • $formattedDate"),
        trailing: GestureDetector(
          onTap: () {
            Provider.of<TransactionProvider>(
              context,
              listen: false,
            ).deleteTransaction(transaction.id);
          },
          child: Icon(Icons.delete, size: 20, color: Colors.red),
        ),
      ),
    );
  }
}
