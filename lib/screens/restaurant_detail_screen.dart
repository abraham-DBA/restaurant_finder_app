import 'package:flutter/material.dart';
import '../widgets/restaurant_detail_header.dart';
import '../widgets/dish_image_card.dart';
import '../widgets/description_section.dart';
import '../widgets/nutrition_info_section.dart';
import '../widgets/reviews_section.dart';
import '../widgets/related_dishes_section.dart';
import '../widgets/bottom_action_bar.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final Map<String, dynamic>? menuItem;

  const RestaurantDetailScreen({super.key, this.menuItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Restaurant Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: RestaurantDetailHeader(
                onBackPressed: () => Navigator.pop(context),
                onFavoritePressed: () {
                  // Handle favorite action
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Added to favorites!")),
                  );
                },
                dishName: _getDishName(),
                price: _getPrice(),
                cookTime: _getDuration(),
                deliveryInfo: _getDistance(),
                rating: _getRating(),
              ),
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                  bottom: 100,
                  left: 16,
                  right: 16,
                ), // Space for bottom bar and side padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Dish Image
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: DishImageCard(
                        imageUrl: _getDishImage(),
                        rating: _getRating(),
                        height: 240,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Description Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: DescriptionSection(
                        title: _getDescriptionTitle(),
                        description: _getDescription(),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Nutrition Info
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: NutritionInfoSection(
                        nutritionItems: _getNutritionData(),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Reviews Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ReviewsSection(reviews: _getReviews()),
                    ),

                    const SizedBox(height: 24),

                    // Related Dishes
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: RelatedDishesSection(dishes: _getRelatedDishes()),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom Action Bar
      bottomSheet: BottomActionBar(
        initialQuantity: 1,
        basePrice: _getBasePrice(),
        currency: "UGX",
        onAddToCart: () {
          // Handle add to cart
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Added to cart!")));
        },
      ),
    );
  }

  // Data provider methods
  String _getDishName() => menuItem?['name'] ?? "Grilled Chicken Salad";

  String _getPrice() => menuItem?['price'] ?? "UGX 50,000";

  double _getRating() => (menuItem?['rating'] ?? 4.8).toDouble();

  String _getDuration() => menuItem?['prepTime'] ?? "25-30 min";

  String _getDistance() => "2.5 km"; // Keep static as it's delivery info

  String _getDishImage() =>
      menuItem?['image'] ?? "assets/images/grilled_chicken_salad.jpg";

  String _getDescriptionTitle() => "About This Dish";

  String _getDescription() =>
      menuItem?['description'] ??
      "Fresh mixed greens topped with perfectly grilled chicken breast, cherry tomatoes, cucumber, red onions, and our signature herb dressing. A healthy and delicious choice packed with protein and nutrients.";

  int _getBasePrice() {
    if (menuItem?['price'] != null) {
      // Extract numeric value from price string like "UGX 50,000"
      String priceStr = menuItem!['price'].toString();
      String numericPrice = priceStr.replaceAll(RegExp(r'[^\d]'), '');
      return int.tryParse(numericPrice) ?? 50000;
    }
    return 50000;
  }

  List<NutritionData> _getNutritionData() => [
    NutritionData(
      label: "Calories",
      value: "420",
      color: const Color(0xFF4CAF50),
    ),
    NutritionData(
      label: "Protein",
      value: "35g",
      color: const Color(0xFF2196F3),
    ),
    NutritionData(label: "Carbs", value: "12g", color: const Color(0xFFFF9800)),
    NutritionData(label: "Fat", value: "18g", color: const Color(0xFFE91E63)),
  ];

  List<ReviewData> _getReviews() => [
    ReviewData(
      reviewerName: "Sarah Johnson",
      rating: 5,
      comment:
          "Absolutely delicious! The chicken was perfectly grilled and the salad was fresh. Will definitely order again.",
      timeAgo: "2 days ago",
    ),
    ReviewData(
      reviewerName: "Mike Chen",
      rating: 4,
      comment:
          "Great healthy option. Portion size is generous and the dressing is amazing.",
      timeAgo: "5 days ago",
    ),
    ReviewData(
      reviewerName: "Emma Wilson",
      rating: 5,
      comment:
          "My go-to healthy meal! Always consistent quality and quick delivery.",
      timeAgo: "1 week ago",
    ),
  ];

  List<RelatedDishData> _getRelatedDishes() => [
    RelatedDishData(
      name: "Caesar Salad",
      price: "UGX 45,000",
      imageUrl: "assets/images/caesar_salad.jpg",
    ),
    RelatedDishData(
      name: "Grilled Salmon",
      price: "UGX 75,000",
      imageUrl: "assets/images/grilled_salmon.jpg",
    ),
    RelatedDishData(
      name: "Quinoa Bowl",
      price: "UGX 40,000",
      imageUrl: "assets/images/quinoa_bowl.jpg",
    ),
    RelatedDishData(
      name: "Mediterranean Wrap",
      price: "UGX 35,000",
      imageUrl: "assets/images/mediterranean_wrap.jpg",
    ),
  ];
}
