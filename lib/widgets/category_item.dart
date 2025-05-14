import 'package:flutter/material.dart';
import 'package:my_finance/core/theme.dart';
import 'package:my_finance/models/category_model.dart';
import 'package:my_finance/providers/category_provider.dart';
import 'package:provider/provider.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel category;

  const CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: gClr,
      child: ListTile(
        title: Text(category.name, style: w16),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: errorClr),
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
