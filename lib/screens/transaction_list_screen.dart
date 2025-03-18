import 'package:flutter/material.dart';
import 'package:my_finance/providers/transaction_provider.dart';
import 'package:my_finance/widgets/transaction_item.dart';
import 'package:provider/provider.dart';

class TransactionListScreen extends StatelessWidget {
  const TransactionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions = Provider.of<TransactionProvider>(context).transactions;
    return Scaffold(
      appBar: AppBar(title: Text("Transaction History")),
      body:
          transactions.isEmpty
              ? Center(child: Text("No transactions found"))
              : ListView.builder(
                itemCount: transactions.length,
                itemBuilder:
                    (context, index) =>
                        TransactionItem(transaction: transactions[index]),
              ),
    );
  }
}
