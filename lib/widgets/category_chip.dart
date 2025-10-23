import 'package:flutter/material.dart';
import '../models/category.dart';

class CategoryChip extends StatelessWidget {
  final Category category;

  const CategoryChip({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: FilterChip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(category.icon, size: 16),
            const SizedBox(width: 6),
            Text(category.name),
          ],
        ),
        selected: category.isSelected,
        selectedColor: Colors.black,
        checkmarkColor: Colors.white,
        labelStyle: TextStyle(
          color: category.isSelected ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: Colors.white,
        shape: StadiumBorder(
          side: BorderSide(
            color: category.isSelected ? Colors.black : Colors.grey[300]!,
            width: 1,
          ),
        ),
        onSelected: (_) {
          // Handle category selection
        },
      ),
    );
  }
}
