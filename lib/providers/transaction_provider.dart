import 'package:flutter/material.dart';
import '../models/transaction_model.dart';
import '../services/transaction_service.dart';

class TransactionProvider with ChangeNotifier {
  List<TransactionModel> _transactions = [];
  final TransactionService _transactionService = TransactionService();

  List<TransactionModel> get transactions => _transactions;

  // Load transactions from Firestore
  Future<void> fetchTransactions() async {
    _transactions = await _transactionService.getTransactions();
    notifyListeners();
  }

  // Add a transaction
  Future<void> addTransaction(TransactionModel transaction) async {
    await _transactionService.addTransaction(transaction);
    _transactions.add(transaction);
    notifyListeners();
  }

  // Delete a transaction
  Future<void> deleteTransaction(String id) async {
    await _transactionService.deleteTransaction(id);
    _transactions.removeWhere((tx) => tx.id == id);
    notifyListeners();
  }
}
