import 'package:flutter/material.dart';

class OrderTabSection extends StatelessWidget {
  final int selectedTab;
  final Function(int) onTabChanged;

  const OrderTabSection({
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
          // Ongoing Orders Tab
          Expanded(
            child: _buildTabButton(
              title: "Ongoing Orders",
              isSelected: selectedTab == 0,
              onTap: () => onTabChanged(0),
              icon: Icons.schedule_rounded,
            ),
          ),
          const SizedBox(width: 8),
          // Past Orders Tab
          Expanded(
            child: _buildTabButton(
              title: "Past Orders",
              isSelected: selectedTab == 1,
              onTap: () => onTabChanged(1),
              icon: Icons.history_rounded,
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
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? const Color(0xFF6366F1) : Colors.grey[600],
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.grey[800] : Colors.grey[600],
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
