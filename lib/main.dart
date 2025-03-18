import 'package:flutter/material.dart';
import 'package:my_finance/core/constants.dart';
import 'package:my_finance/core/theme.dart';
import 'package:my_finance/providers/category_provider.dart';
import 'package:my_finance/providers/transaction_provider.dart';
import 'package:my_finance/screens/add_transaction_screen.dart';
import 'package:my_finance/screens/auth_screen.dart';
import 'package:my_finance/screens/category_screen.dart';
import 'package:my_finance/screens/dashboard_screen.dart';
import 'package:my_finance/screens/home_screen.dart';
import 'package:my_finance/services/notification_service.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TransactionProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
      ],
      child: MaterialApp(
        title: AppConstants.appName,
        theme: AppTheme.lightTheme,
        initialRoute: "/auth",
        routes: {
          "/auth": (context) => AuthScreen(),
          "/home": (context) => HomeScreen(),
          "/add-transaction": (context) => AddTransactionScreen(),
          "/categories": (context) => CategoryScreen(),
          "/dashboard": (context) => DashboardScreen(),
        },
      ),
    );
  }
}
