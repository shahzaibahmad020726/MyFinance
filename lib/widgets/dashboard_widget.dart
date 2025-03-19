import 'package:flutter/material.dart';
import 'package:my_finance/providers/transaction_provider.dart';
import 'package:provider/provider.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({super.key});

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

    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    income.toStringAsFixed(2),
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  Text(
                    "Total Income",
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    expenses.toStringAsFixed(2),
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  Text(
                    "Total Expenses",
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    balance.toStringAsFixed(2),
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  Text(
                    "Net Balance",
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
