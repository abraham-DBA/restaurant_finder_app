import 'package:flutter/material.dart';
import '../utils/image_utils.dart';

class RestaurantMenuItem extends StatelessWidget {
  final Map<String, dynamic> menuItem;
  final VoidCallback? onTap;

  const RestaurantMenuItem({super.key, required this.menuItem, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Food Image/Icon
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFFFFEAA7).withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: menuItem['image'] != null
                    ? Image(
                        image: ImageUtils.getImageProvider(menuItem['image']),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Center(
                          child: Text(
                            menuItem['emoji'] ?? '🍽️',
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                      )
                    : Center(
                        child: Text(
                          menuItem['emoji'] ?? '🍽️',
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 16),
            // Food Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    menuItem['name'] ?? 'Menu Item',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    menuItem['description'] ?? 'Delicious food item',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    menuItem['price'] ?? 'UGX 0',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF4ECDC4),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Add Button
            GestureDetector(
              onTap: onTap,
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
