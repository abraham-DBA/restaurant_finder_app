import 'package:flutter/material.dart';

class RestaurantNavigationTabs extends StatelessWidget {
  final int selectedTab;
  final Function(int)? onTabChanged;

  const RestaurantNavigationTabs({
    super.key,
    required this.selectedTab,
    this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildTab("Menus", 0),
          const SizedBox(width: 8),
          _buildTab("Reviews", 1),
          const SizedBox(width: 8),
          _buildTab("About", 2),
        ],
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    final isSelected = selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTabChanged?.call(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: isSelected
              ? BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                )
              : null,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? Colors.grey[800] : Colors.grey[600],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
