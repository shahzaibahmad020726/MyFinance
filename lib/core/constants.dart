class AppConstants {
  static const String appName = "MyFinance";

  // Firebase collections
  static const String transactionsCollection = "transactions";
  static const String categoriesCollection = "categories";
  static const String usersCollection = "users";

  // Default categories
  static const List<String> defaultCategories = [
    "Salary",
    "Groceries",
    "Rent",
    "Entertainment",
    "Transport",
  ];
}