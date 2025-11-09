import 'package:flutter/material.dart';
import '../../models/restaurant.dart';
import '../../utils/menu_data_service.dart';
import '../restaurant_menu_item.dart';

class RestaurantMenuItemsSection extends StatelessWidget {
  final Restaurant? restaurant;
  final Function(Map<String, dynamic>)? onMenuItemTap;

  const RestaurantMenuItemsSection({
    super.key,
    this.restaurant,
    this.onMenuItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Popular Items",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: _getMenuItems()
                .map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: RestaurantMenuItem(
                      menuItem: item,
                      onTap: () => onMenuItemTap?.call(item),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getMenuItems() {
    if (restaurant != null) {
      // Get menu items from MenuDataService and filter by restaurant if needed
      final allMenuItems = MenuDataService.getMenuItems();
      // For now, return first 3 items. You could filter by restaurant later
      return allMenuItems.take(3).toList();
    }

    // Default menu items if no restaurant provided
    return [
      {
        'name': 'Rolex',
        'description': 'Chapati rolled with eggs, tomatoes, and onions',
        'price': 'UGX 50,000',
        'image': 'assets/images/menu1.jpg',
        'emoji': '🌯',
        'category': 'Mains',
        'rating': 4.5,
        'prepTime': '15-20 min',
      },
      {
        'name': 'Grilled Chicken',
        'description': 'Tender grilled chicken with herbs and spices',
        'price': 'UGX 65,000',
        'image': 'assets/images/menu2.jpg',
        'emoji': '🍗',
        'category': 'Mains',
        'rating': 4.7,
        'prepTime': '20-25 min',
      },
      {
        'name': 'Beef Stew',
        'description': 'Rich beef stew with vegetables and rice',
        'price': 'UGX 45,000',
        'image': 'assets/images/menu3.jpg',
        'emoji': '🍲',
        'category': 'Mains',
        'rating': 4.3,
        'prepTime': '25-30 min',
      },
    ];
  }
}
