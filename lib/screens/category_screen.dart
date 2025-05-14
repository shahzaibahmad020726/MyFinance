import 'package:flutter/material.dart';
import 'package:my_finance/core/theme.dart';
import 'package:my_finance/models/category_model.dart';
import 'package:my_finance/providers/category_provider.dart';
import 'package:my_finance/screens/auth_screen.dart';
import 'package:my_finance/widgets/category_item.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final _categoryController = TextEditingController();

  void _addCategory() {
    final name = _categoryController.text;

    final newCategory = CategoryModel(
      id: DateTime.now().toString(),
      name: name,
    );
    Provider.of<CategoryProvider>(
      context,
      listen: false,
    ).addCategory(newCategory);

    _categoryController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<CategoryProvider>(context).categories;
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Categories", style: g18),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Txtfield(
              hinttext: "New Category",
              controller: _categoryController,
              obscureText: false,
            ),
          ),
          ElevatedButton(
            onPressed: _addCategory,
            style: ButtonStyle(backgroundColor: WidgetStateProperty.all(gClr)),
            child: Text("Add Category", style: w16),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder:
                  (context, index) => CategoryItem(category: categories[index]),
            ),
          ),
        ],
      ),
    );
  }
}
