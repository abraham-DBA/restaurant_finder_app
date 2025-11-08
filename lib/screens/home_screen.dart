import 'package:flutter/material.dart';
import '../widgets/home_header.dart';
import '../widgets/hero_banner.dart';
import '../widgets/sections/categories_section.dart';
import '../widgets/sections/destinations_section.dart';
import '../widgets/sections/popular_menus_section.dart';
import '../widgets/sections/offers_section.dart';
import '../widgets/sections/restaurants_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Modern Header
                const HomeHeader(),
                const SizedBox(height: 24),

                // 🔹 Hero Banner with gradient
                const HeroBanner(),
                const SizedBox(height: 32),

                // 🔹 Categories with icons
                CategoriesSection(categories: _getCategories()),
                const SizedBox(height: 32),

                // 🔹 Popular Destinations
                DestinationsSection(destinations: _getDestinations()),
                const SizedBox(height: 32),

                // 🔹 Popular Menus
                PopularMenusSection(menus: _getPopularMenus()),
                const SizedBox(height: 32),

                // 🔹 Special Offers
                OffersSection(offers: _getOffers()),
                const SizedBox(height: 32),

                // 🔹 Restaurants Section
                RestaurantsSection(restaurants: _getRestaurants()),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<CategoryData> _getCategories() {
    return const [
      CategoryData(
        icon: Icons.local_pizza,
        title: "Pizza",
        color: Color(0xFFFF6B6B),
      ),
      CategoryData(
        icon: Icons.fastfood,
        title: "Burgers",
        color: Color(0xFF4ECDC4),
      ),
      CategoryData(icon: Icons.eco, title: "Salads", color: Color(0xFF45B7D1)),
      CategoryData(
        icon: Icons.ramen_dining,
        title: "Asian",
        color: Color(0xFF96CEB4),
      ),
      CategoryData(
        icon: Icons.rice_bowl,
        title: "Chinese",
        color: Color(0xFFFFEAA7),
      ),
      CategoryData(
        icon: Icons.set_meal,
        title: "Sushi",
        color: Color(0xFFDDA0DD),
      ),
    ];
  }

  List<DestinationData> _getDestinations() {
    return const [
      DestinationData(
        name: "Bugolobi",
        image: "🍔",
        imageUrl: "assets/images/menu1.jpg",
        rating: 4.5,
      ),
      DestinationData(
        name: "Nakawa",
        image: "🥗",
        imageUrl: "assets/images/menu2.jpg",
        rating: 4.2,
      ),
      DestinationData(
        name: "Kololo",
        image: "🍣",
        imageUrl: "assets/images/menu3.jpg",
        rating: 4.8,
      ),
      DestinationData(
        name: "Kiswa",
        image: "🍕",
        imageUrl: "assets/images/menu4.jpg",
        rating: 4.3,
      ),
    ];
  }

  List<OfferData> _getOffers() {
    return const [
      OfferData(
        title: "20% OFF",
        subtitle: "On all orders above \$20",
        color: Color(0xFFFF6B6B),
        icon: Icons.local_offer,
      ),
      OfferData(
        title: "Buy 1 Get 1",
        subtitle: "Free dessert with main course",
        color: Color(0xFF4ECDC4),
        icon: Icons.card_giftcard,
      ),
      OfferData(
        title: "Free Delivery",
        subtitle: "No delivery fee on orders \$15+",
        color: Color(0xFF9B59B6),
        icon: Icons.delivery_dining,
      ),
      OfferData(
        title: "30% OFF",
        subtitle: "First order discount for new users",
        color: Color(0xFFE67E22),
        icon: Icons.celebration,
      ),
      OfferData(
        title: "Flash Sale",
        subtitle: "50% off on selected items",
        color: Color(0xFFE74C3C),
        icon: Icons.flash_on,
      ),
      OfferData(
        title: "Happy Hour",
        subtitle: "2PM-5PM daily special deals",
        color: Color(0xFF27AE60),
        icon: Icons.access_time,
      ),
    ];
  }

  List<PopularMenuData> _getPopularMenus() {
    return const [
      PopularMenuData(
        name: "Truffle Mushroom Burger",
        description:
            "Juicy beef patty with truffle mushrooms, aged cheddar, and caramelized onions",
        price: "\$18.99",
        originalPrice: "\$24.99",
        imageUrl: "assets/images/menu1.jpg",
        rating: 4.8,
        reviews: 245,
        restaurantName: "The Gourmet Hub",
        isSpicy: false,
        isVegan: false,
      ),
      PopularMenuData(
        name: "Dragon Roll Sushi",
        description:
            "Fresh salmon, avocado, cucumber with spicy mayo and eel sauce",
        price: "\$22.50",
        originalPrice: "\$28.00",
        imageUrl: "assets/images/menu2.jpg",
        rating: 4.9,
        reviews: 189,
        restaurantName: "Sakura Sushi",
        isSpicy: true,
        isVegan: false,
      ),
      PopularMenuData(
        name: "Mediterranean Bowl",
        description:
            "Quinoa, roasted vegetables, hummus, feta cheese, and tahini dressing",
        price: "\$15.99",
        originalPrice: "\$19.99",
        imageUrl: "assets/images/menu3.jpg",
        rating: 4.6,
        reviews: 156,
        restaurantName: "Green Garden",
        isSpicy: false,
        isVegan: true,
      ),
      PopularMenuData(
        name: "Spicy Thai Curry",
        description:
            "Authentic red curry with coconut milk, vegetables, and jasmine rice",
        price: "\$16.50",
        originalPrice: "\$21.00",
        imageUrl: "assets/images/menu4.jpg",
        rating: 4.7,
        reviews: 201,
        restaurantName: "Bangkok Street",
        isSpicy: true,
        isVegan: true,
      ),
      PopularMenuData(
        name: "BBQ Pulled Pork",
        description:
            "Slow-cooked pulled pork with house BBQ sauce, coleslaw, and brioche bun",
        price: "\$17.99",
        originalPrice: "\$22.99",
        imageUrl: "assets/images/restaurant1.jpg",
        rating: 4.5,
        reviews: 167,
        restaurantName: "Smokehouse Grill",
        isSpicy: false,
        isVegan: false,
      ),
      PopularMenuData(
        name: "Margherita Pizza",
        description:
            "Wood-fired pizza with fresh mozzarella, basil, and San Marzano tomatoes",
        price: "\$14.99",
        originalPrice: "\$18.99",
        imageUrl: "assets/images/restaurant2.jpg",
        rating: 4.4,
        reviews: 298,
        restaurantName: "Pizza Paradiso",
        isSpicy: false,
        isVegan: false,
      ),
    ];
  }

  List<RestaurantData> _getRestaurants() {
    return const [
      RestaurantData(
        name: "The Gourmet Hub",
        type: "International",
        deliveryTime: "20-45 min",
        rating: 4.8,
        imageUrl: "assets/images/restaurant1.jpg",
      ),
      RestaurantData(
        name: "Urban Kitchen",
        type: "Asian Fusion",
        deliveryTime: "25-40 min",
        rating: 4.6,
        imageUrl: "assets/images/restaurant2.jpg",
      ),
      RestaurantData(
        name: "Bistro Central",
        type: "French",
        deliveryTime: "30-50 min",
        rating: 4.9,
        imageUrl: "assets/images/restaurant3.jpg",
      ),
      RestaurantData(
        name: "Pizza Paradiso",
        type: "Italian",
        deliveryTime: "20-30 min",
        rating: 4.5,
        imageUrl: "assets/images/restaurant5.jpg",
      ),
    ];
  }
}
