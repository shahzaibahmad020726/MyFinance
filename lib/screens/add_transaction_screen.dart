import 'package:flutter/material.dart';
import 'package:my_finance/models/transaction_model.dart';
import 'package:my_finance/providers/transaction_provider.dart';
import 'package:provider/provider.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  bool _isIncome = true;

  void _saveTransaction() {
    final title = _titleController.text;
    final amount = double.tryParse(_amountController.text) ?? 0;

    if (title.isEmpty || amount <= 0) return;

    final newTransaction = TransactionModel(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      isIncome: _isIncome,
      category: "General",
      date: DateTime.now(),
    );

    Provider.of<TransactionProvider>(
      context,
      listen: false,
    ).addTransaction(newTransaction);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Transaction")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: "Amount"),
              keyboardType: TextInputType.number,
            ),
            SwitchListTile(
              title: Text("Income?"),
              value: _isIncome,
              onChanged: (val) => setState(() => _isIncome = val),
            ),
            ElevatedButton(onPressed: _saveTransaction, child: Text("Save")),
          ],
        ),
      ),
    );
  }
}
