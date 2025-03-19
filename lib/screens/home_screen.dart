import 'package:flutter/material.dart';
import 'package:my_finance/providers/transaction_provider.dart';
import 'package:my_finance/widgets/dashboard_widget.dart';
import 'package:my_finance/services/auth_service.dart';
import 'package:my_finance/widgets/transaction_item.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TransactionProvider>(
      context,
      listen: false,
    ).fetchTransactions();
  }

  Future<void> _refreshTransactions() async {
    await Provider.of<TransactionProvider>(
      context,
      listen: false,
    ).fetchTransactions();
  }

  @override
  Widget build(BuildContext context) {
    final transactions = Provider.of<TransactionProvider>(context).transactions;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MyFinance",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.category, color: Colors.green, size: 20),
            onPressed: () async {
              Navigator.pushNamed(context, "/categories");
            },
          ),
          IconButton(
            icon: Icon(Icons.logout_outlined, color: Colors.green, size: 20),
            onPressed: () async {
              await AuthService().signOut();
              Navigator.pushReplacementNamed(context, "/auth");
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16),
        child: Column(
          spacing: 12,
          children: [
            DashboardWidget(),
            Expanded(
              child:
                  transactions.isEmpty
                      ? Center(child: Text("No transactions yet"))
                      : ListView.builder(
                        itemCount: transactions.length,
                        itemBuilder:
                            (context, index) => TransactionItem(
                              transaction: transactions[index],
                            ),
                      ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        onPressed: () {
          Navigator.pushNamed(context, "/add-transaction");
          _refreshTransactions();
        },
        child: Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
