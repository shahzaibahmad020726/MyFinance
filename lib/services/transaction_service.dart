import 'package:my_finance/core/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_finance/models/transaction_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Add transaction to Firestore
  Future<void> addTransaction(TransactionModel transaction) async {
    await _db
        .collection(AppConstants.transactionsCollection)
        .doc(transaction.id)
        .set(transaction.toJson());
  }

  // Fetch transactions from Firestore
  Future<List<TransactionModel>> getTransactions() async {
    QuerySnapshot snapshot =
        await _db.collection(AppConstants.transactionsCollection).get();
    return snapshot.docs
        .map(
          (doc) =>
              TransactionModel.fromJson(doc.data() as Map<String, dynamic>),
        )
        .toList();
  }

  // Delete transaction
  Future<void> deleteTransaction(String id) async {
    await _db.collection(AppConstants.transactionsCollection).doc(id).delete();
  }

  // Save transactions locally (for offline support)
  Future<void> saveTransactionsLocally(
    List<TransactionModel> transactions,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonTransactions =
        transactions.map((tx) => tx.toJson().toString()).toList();
    await prefs.setStringList("transactions", jsonTransactions);
  }
}
