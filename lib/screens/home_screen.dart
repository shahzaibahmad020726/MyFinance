import 'package:flutter/material.dart';
import 'package:my_finance/providers/transaction_provider.dart';
import 'package:my_finance/services/auth_service.dart';
import 'package:my_finance/widgets/transaction_item.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions = Provider.of<TransactionProvider>(context).transactions;

    return Scaffold(
      appBar: AppBar(
        title: Text("MyFinance"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await AuthService().signOut();
              Navigator.pushReplacementNamed(context, "/auth");
            },
          ),
        ],
      ),
      body:
          transactions.isEmpty
              ? Center(child: Text("No transactions yet"))
              : ListView.builder(
                itemCount: transactions.length,
                itemBuilder:
                    (context, index) =>
                        TransactionItem(transaction: transactions[index]),
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/add-transaction");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
