import 'package:flutter/material.dart';
import '../popular_menu_item.dart';

class PopularMenuData {
  final String name;
  final String description;
  final String price;
  final String originalPrice;
  final String imageUrl;
  final double rating;
  final int reviews;
  final String restaurantName;
  final bool isVegan;
  final bool isSpicy;
  final VoidCallback? onTap;

  const PopularMenuData({
    required this.name,
    required this.description,
    required this.price,
    required this.originalPrice,
    required this.imageUrl,
    required this.rating,
    required this.reviews,
    required this.restaurantName,
    this.isVegan = false,
    this.isSpicy = false,
    this.onTap,
  });
}

class PopularMenusSection extends StatelessWidget {
  final String title;
  final List<PopularMenuData> menus;

  const PopularMenusSection({
    super.key,
    this.title = "Popular Menus",
    required this.menus,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.grey[800],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '🔥 Trending',
                style: TextStyle(
                  color: Colors.green[700],
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(right: 4),
            itemCount: menus.length,
            itemBuilder: (context, index) {
              final menu = menus[index];
              return Container(
                width: 200,
                margin: const EdgeInsets.only(right: 16),
                child: PopularMenuItem(
                  name: menu.name,
                  description: menu.description,
                  price: menu.price,
                  originalPrice: menu.originalPrice,
                  imageUrl: menu.imageUrl,
                  rating: menu.rating,
                  reviews: menu.reviews,
                  restaurantName: menu.restaurantName,
                  isVegan: menu.isVegan,
                  isSpicy: menu.isSpicy,
                  onTap: menu.onTap,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
