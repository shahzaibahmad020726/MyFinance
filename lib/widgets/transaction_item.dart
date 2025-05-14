import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_finance/core/theme.dart';
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
      color: gClr.withAlpha(200),
      child: ListTile(
        title: Row(
          spacing: 10,
          children: [
            Text(transaction.title, style: w14l),
            Text(
              "${transaction.isIncome ? '+' : '-'}\$${transaction.amount.toStringAsFixed(2)}",
              style: GoogleFonts.poppins(
                fontSize: 16,
                color:
                    transaction.isIncome
                        ? Colors.greenAccent
                        : Colors.redAccent,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        subtitle: Text("${transaction.category} • $formattedDate", style: w14l),
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
