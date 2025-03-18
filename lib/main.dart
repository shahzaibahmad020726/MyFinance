import 'package:flutter/material.dart';
import 'package:my_finance/core/constants.dart';
import 'package:my_finance/core/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: AppConstants.appName, theme: AppTheme.lightTheme);
  }
}
