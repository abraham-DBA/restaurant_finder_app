import 'package:flutter/material.dart';

class BookingTabSection extends StatelessWidget {
  final int selectedTab;
  final Function(int) onTabChanged;

  const BookingTabSection({
    super.key,
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Upcoming Tab
          Expanded(
            child: _buildTabButton(
              title: "Upcoming",
              isSelected: selectedTab == 0,
              onTap: () => onTabChanged(0),
            ),
          ),
          const SizedBox(width: 8),
          // Past Bookings Tab
          Expanded(
            child: _buildTabButton(
              title: "Past Bookings",
              isSelected: selectedTab == 1,
              onTap: () => onTabChanged(1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.grey[800] : Colors.grey[600],
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
