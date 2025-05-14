import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_finance/core/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_finance/models/transaction_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addTransaction(TransactionModel transaction) async {
    await _db
        .collection(AppConstants.transactionsCollection)
        .doc(transaction.id)
        .set(transaction.toJson());
  }

  Future<List<TransactionModel>> getTransactions() async {
    final userId = _auth.currentUser?.uid;

    if (userId == null) {
      return [];
    }

    QuerySnapshot snapshot =
        await _db
            .collection(AppConstants.transactionsCollection)
            .where('userId', isEqualTo: userId)
            .get();

    return snapshot.docs
        .map(
          (doc) =>
              TransactionModel.fromJson(doc.data() as Map<String, dynamic>),
        )
        .toList();
  }

  Future<void> deleteTransaction(String id) async {
    await _db.collection(AppConstants.transactionsCollection).doc(id).delete();
  }

  Future<void> saveTransactionsLocally(
    List<TransactionModel> transactions,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonTransactions =
        transactions.map((tx) => tx.toJson().toString()).toList();
    await prefs.setStringList("transactions", jsonTransactions);
  }
}
