import 'package:my_finance/core/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_finance/models/category_model.dart';

class CategoryService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Add category
  Future<void> addCategory(CategoryModel category) async {
    await _db
        .collection(AppConstants.categoriesCollection)
        .doc(category.id)
        .set(category.toJson());
  }

  // Fetch categories
  Future<List<CategoryModel>> getCategories() async {
    QuerySnapshot snapshot =
        await _db.collection(AppConstants.categoriesCollection).get();
    return snapshot.docs
        .map(
          (doc) => CategoryModel.fromJson(doc.data() as Map<String, dynamic>),
        )
        .toList();
  }

  // Delete category
  Future<void> deleteCategory(String id) async {
    await _db.collection(AppConstants.categoriesCollection).doc(id).delete();
  }
}
