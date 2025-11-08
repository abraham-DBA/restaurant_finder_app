import 'package:flutter/material.dart';
import '../category_item.dart';

class CategoriesSection extends StatelessWidget {
  final String title;
  final List<CategoryData> categories;

  const CategoriesSection({
    super.key,
    this.title = "Categories",
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return CategoryItem(
                icon: category.icon,
                title: category.title,
                color: category.color,
                onTap: category.onTap,
              );
            },
          ),
        ),
      ],
    );
  }
}

class CategoryData {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback? onTap;

  const CategoryData({
    required this.icon,
    required this.title,
    required this.color,
    this.onTap,
  });
}
