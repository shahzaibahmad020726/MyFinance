import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:my_finance/screens/home_screen.dart';
import 'package:my_finance/providers/transaction_provider.dart';

void main() {
  testWidgets('HomeScreen displays transactions correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => TransactionProvider(),
        child: MaterialApp(home: HomeScreen()),
      ),
    );

    expect(find.text("MyFinance"), findsOneWidget);
    expect(find.text("No transactions yet"), findsOneWidget);
  });
}
