import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../services/category_service.dart';

class CategoryProvider with ChangeNotifier {
  List<CategoryModel> _categories = [];
  final CategoryService _categoryService = CategoryService();

  List<CategoryModel> get categories => _categories;

  // Load categories from Firestore
  Future<void> fetchCategories() async {
    _categories = await _categoryService.getCategories();
    notifyListeners();
  }

  // Add a category
  Future<void> addCategory(CategoryModel category) async {
    await _categoryService.addCategory(category);
    _categories.add(category);
    notifyListeners();
  }

  // Delete a category
  Future<void> deleteCategory(String id) async {
    await _categoryService.deleteCategory(id);
    _categories.removeWhere((cat) => cat.id == id);
    notifyListeners();
  }
}
