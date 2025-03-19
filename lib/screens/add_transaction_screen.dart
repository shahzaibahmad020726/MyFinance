import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_finance/models/category_model.dart';
import 'package:my_finance/models/transaction_model.dart';
import 'package:my_finance/providers/category_provider.dart';
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
  final _dateController = TextEditingController();
  bool _isIncome = true;
  String _selectedCategory = "General";

  void _saveTransaction() {
    final title = _titleController.text;
    final date = DateTime.tryParse(_dateController.text) ?? DateTime.now();
    final amount = double.tryParse(_amountController.text) ?? 0;

    if (title.isEmpty || amount <= 0) return;

    final newTransaction = TransactionModel(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      isIncome: _isIncome,
      category: _selectedCategory,
      date: date,
    );

    Provider.of<TransactionProvider>(
      context,
      listen: false,
    ).addTransaction(newTransaction);
    Navigator.pop(context);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<CategoryProvider>(context).categories;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Transaction",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        centerTitle: true,
      ),
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
            TextField(
              controller: _dateController,
              decoration: InputDecoration(labelText: "Date"),
              readOnly: true,
              onTap: () => _selectDate(context),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Category: "),
                DropdownButton<String>(
                  value: _selectedCategory,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue!;
                    });
                  },
                  items:
                      categories.map<DropdownMenuItem<String>>((
                        CategoryModel category,
                      ) {
                        return DropdownMenuItem<String>(
                          value: category.name,
                          child: Text(category.name),
                        );
                      }).toList(),
                ),
              ],
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: _saveTransaction,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.greenAccent),
              ),
              child: Text("Save", style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
