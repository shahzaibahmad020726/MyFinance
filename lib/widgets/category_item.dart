import 'package:flutter/material.dart';
import 'package:my_finance/models/category_model.dart';
import 'package:my_finance/providers/category_provider.dart';
import 'package:provider/provider.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel category;

  const CategoryItem({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          category.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              Provider.of<CategoryProvider>(
                context,
                listen: false,
              ).deleteCategory(category.id);
            },
        ),
      ),
    );
  }
}
