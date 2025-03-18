import 'package:flutter_test/flutter_test.dart';
import 'package:my_finance/models/transaction_model.dart';

void main() {
  test('Transaction Model Test', () {
    final transaction = TransactionModel(
      id: '1',
      title: 'Salary',
      amount: 1000,
      isIncome: true,
      category: 'Income',
      date: DateTime.now(),
    );

    expect(transaction.title, 'Salary');
    expect(transaction.amount, 1000);
  });
}
