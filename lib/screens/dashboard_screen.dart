import 'package:flutter/material.dart';
import 'package:my_finance/providers/transaction_provider.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions = Provider.of<TransactionProvider>(context).transactions;
    final income = transactions
        .where((t) => t.isIncome)
        .fold(0.0, (sum, item) => sum + item.amount);
    final expenses = transactions
        .where((t) => !t.isIncome)
        .fold(0.0, (sum, item) => sum + item.amount);
    final balance = income - expenses;

    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Total Income: \$${income.toStringAsFixed(2)}",
            style: TextStyle(color: Colors.green, fontSize: 18),
          ),
          Text(
            "Total Expenses: \$${expenses.toStringAsFixed(2)}",
            style: TextStyle(color: Colors.red, fontSize: 18),
          ),
          Text(
            "Net Balance: \$${balance.toStringAsFixed(2)}",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
