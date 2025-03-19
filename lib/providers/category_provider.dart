import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../services/category_service.dart';

class CategoryProvider with ChangeNotifier {
  List<CategoryModel> listOfCategories = [
    CategoryModel(id: "1", name: "General"),
    CategoryModel(id: "2", name: "Food"),
    CategoryModel(id: "3", name: "Transport"),
    CategoryModel(id: "4", name: "Shopping"),
    CategoryModel(id: "5", name: "Health"),
  ];
  final CategoryService _categoryService = CategoryService();

  List<CategoryModel> get categories => listOfCategories;

  // Load categories from Firestore
  Future<void> fetchCategories() async {
    listOfCategories = await _categoryService.getCategories();
    notifyListeners();
  }

  // Add a category
  Future<void> addCategory(CategoryModel category) async {
    await _categoryService.addCategory(category);
    listOfCategories.add(category);
    notifyListeners();
  }

  // Delete a category
  Future<void> deleteCategory(String id) async {
    await _categoryService.deleteCategory(id);
    listOfCategories.removeWhere((cat) => cat.id == id);
    notifyListeners();
  }
}
