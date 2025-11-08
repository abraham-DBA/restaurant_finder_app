import 'package:flutter/material.dart';
import '../restaurant_item.dart';

class RestaurantsSection extends StatelessWidget {
  final String title;
  final String viewMoreText;
  final List<RestaurantData> restaurants;
  final VoidCallback? onViewMoreTap;

  const RestaurantsSection({
    super.key,
    this.title = "Featured Restaurants",
    this.viewMoreText = "View more",
    required this.restaurants,
    this.onViewMoreTap,
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
            GestureDetector(
              onTap: onViewMoreTap,
              child: Text(
                viewMoreText,
                style: TextStyle(
                  color: Colors.blue[600],
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              final restaurant = restaurants[index];
              return RestaurantItem(
                name: restaurant.name,
                type: restaurant.type,
                deliveryTime: restaurant.deliveryTime,
                rating: restaurant.rating,
                imageUrl: restaurant.imageUrl,
                onTap: restaurant.onTap,
              );
            },
          ),
        ),
      ],
    );
  }
}

class RestaurantData {
  final String name;
  final String type;
  final String deliveryTime;
  final double rating;
  final String? imageUrl;
  final VoidCallback? onTap;

  const RestaurantData({
    required this.name,
    required this.type,
    required this.deliveryTime,
    required this.rating,
    this.imageUrl,
    this.onTap,
  });
}
