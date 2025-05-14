import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_finance/core/theme.dart';
import 'package:my_finance/models/category_model.dart';
import 'package:my_finance/models/transaction_model.dart';
import 'package:my_finance/providers/category_provider.dart';
import 'package:my_finance/providers/transaction_provider.dart';
import 'package:my_finance/screens/auth_screen.dart';
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
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final newTransaction = TransactionModel(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      isIncome: _isIncome,
      category: _selectedCategory,
      date: date,
      userId: userId,
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
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: gClr,
            colorScheme: ColorScheme.light(primary: gClr),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            iconButtonTheme: IconButtonThemeData(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.transparent),
                iconColor: WidgetStatePropertyAll(gClr),
              ),
            ),
            textTheme: TextTheme(bodyLarge: g16, headlineLarge: g18),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w700),
              ),
            ),
          ),
          child: child!,
        );
      },
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
        title: Text("Add Transaction", style: g18),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Txtfield(
              obscureText: false,
              controller: _titleController,
              hinttext: "Title",
            ),
            Txtfield(
              obscureText: false,
              controller: _amountController,
              hinttext: "Amount",
              keyboardType: TextInputType.number,
            ),
            SwitchListTile(
              title: Text("Income?", style: g16),
              value: _isIncome,
              onChanged: (val) => setState(() => _isIncome = val),
              activeTrackColor: gClr,
              hoverColor: Colors.transparent,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                style: g16,
                controller: _dateController,
                decoration: InputDecoration(
                  hintText: "Date",
                  hintStyle: g16,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: const BorderSide(color: gClr, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: const BorderSide(color: gClr, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: const BorderSide(color: gClr, width: 2),
                  ),
                ),
                readOnly: true,
                onTap: () => _selectDate(context),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Category:", style: g16),
                DropdownButton<String>(
                  style: g16,
                  value: _selectedCategory,
                  focusColor: Colors.transparent,
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
                backgroundColor: WidgetStateProperty.all(gClr),
              ),
              child: Text("Save", style: w16l),
            ),
          ],
        ),
      ),
    );
  }
}
