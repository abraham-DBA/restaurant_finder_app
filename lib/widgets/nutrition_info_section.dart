import 'package:flutter/material.dart';

class NutritionData {
  final String label;
  final String value;
  final Color color;

  const NutritionData({
    required this.label,
    required this.value,
    required this.color,
  });
}

class NutritionInfoSection extends StatelessWidget {
  final String title;
  final List<NutritionData> nutritionItems;

  const NutritionInfoSection({
    super.key,
    this.title = "Nutrition Information",
    required this.nutritionItems,
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
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 15,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: nutritionItems
                .map(
                  (item) => NutritionItem(
                    label: item.label,
                    value: item.value,
                    color: item.color,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class NutritionItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const NutritionItem({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              value.split(' ')[0],
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: color,
                fontSize: 12,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
