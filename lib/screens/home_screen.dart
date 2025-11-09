import 'package:flutter/material.dart';
import '../widgets/home_header.dart';
import '../widgets/hero_banner.dart';
import '../widgets/sections/categories_section.dart';
import '../widgets/sections/destinations_section.dart';
import '../widgets/sections/popular_menus_section.dart';
import '../widgets/sections/offers_section.dart';
import '../widgets/sections/restaurants_section.dart';
import '../screens/restaurants_screen.dart';
import '../screens/menu_screen.dart';
import '../screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showAppBar = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset > 100 && !_showAppBar) {
      setState(() => _showAppBar = true);
    } else if (_scrollController.offset <= 100 && _showAppBar) {
      setState(() => _showAppBar = false);
    }
  }

  void _navigateToRestaurants() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RestaurantsScreen()),
    );
  }

  void _navigateToMenu() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MenuScreen()),
    );
  }

  void _navigateToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfileScreen()),
    );
  }

  void _onCategoryTap(CategoryData category) {
    // Navigate to restaurants with category filter
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RestaurantsScreen()),
    );

    // Show category selected message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${category.title} category selected'),
        duration: const Duration(seconds: 2),
        backgroundColor: category.color,
      ),
    );
  }

  void _onOfferTap(OfferData offer) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(offer.icon, color: offer.color, size: 24),
              const SizedBox(width: 8),
              Text(
                offer.title,
                style: TextStyle(
                  color: offer.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(offer.subtitle),
              const SizedBox(height: 16),
              const Text(
                'Terms & Conditions:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                '• Valid for limited time only\n'
                '• Cannot be combined with other offers\n'
                '• Delivery charges may apply\n'
                '• Terms subject to change',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Maybe Later'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToRestaurants();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: offer.color,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Use Offer'),
            ),
          ],
        );
      },
    );
  }

  void _onMenuItemTap(PopularMenuData menuItem) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildMenuItemDetails(menuItem),
    );
  }

  Widget _buildQuickMenu() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),

          const Text(
            'Quick Actions',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Quick action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _quickActionButton(
                icon: Icons.search,
                label: 'Search',
                color: Colors.blue,
                onTap: _navigateToRestaurants,
              ),
              _quickActionButton(
                icon: Icons.restaurant_menu,
                label: 'Menu',
                color: Colors.green,
                onTap: _navigateToMenu,
              ),
              _quickActionButton(
                icon: Icons.person,
                label: 'Profile',
                color: Colors.purple,
                onTap: _navigateToProfile,
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _quickActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  List<HeroCarouselItem> _getInteractiveHeroBannerItems() {
    return [
      HeroCarouselItem(
        title: "Signature Burger Deluxe",
        subtitle: "Premium beef patty with truffle sauce",
        originalPrice: "\$24.99",
        discountPrice: "\$17.99",
        discountPercent: "28% OFF",
        image: "assets/images/restaurant1.jpg",
        badgeText: "Chef's Special",
        badgeIcon: Icons.star,
        gradientColors: [
          const Color(0xFF6B7280),
          const Color(0xFF4B5563),
          const Color(0xFF374151),
        ],
        type: HeroItemType.product,
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Burger added to cart!'),
              backgroundColor: Colors.green,
            ),
          );
        },
      ),
      HeroCarouselItem(
        title: "The Gourmet Hub",
        subtitle: "Award-winning international cuisine • 4.8★ rating",
        image: "assets/images/restaurant2.jpg",
        badgeText: "Top Rated",
        badgeIcon: Icons.restaurant,
        gradientColors: [
          const Color(0xFF9CA3AF),
          const Color(0xFF6B7280),
          const Color(0xFF4B5563),
        ],
        type: HeroItemType.restaurant,
        onTap: () => _navigateToMenu(),
      ),
      HeroCarouselItem(
        title: "Pizza Special",
        subtitle: "Authentic Italian pizza with fresh ingredients",
        originalPrice: "\$18.99",
        discountPrice: "\$12.99",
        discountPercent: "30% OFF",
        image: "assets/images/restaurant3.jpg",
        badgeText: "Limited Time",
        badgeIcon: Icons.flash_on,
        gradientColors: [
          const Color(0xFF71717A),
          const Color(0xFF52525B),
          const Color(0xFF3F3F46),
        ],
        type: HeroItemType.product,
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Pizza added to cart!'),
              backgroundColor: Colors.green,
            ),
          );
        },
      ),
    ];
  }

  Widget _buildMenuItemDetails(PopularMenuData menuItem) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Image
          Container(
            height: 200,
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(menuItem.imageUrl),
                fit: BoxFit.cover,
                onError: (exception, stackTrace) {},
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.3),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          menuItem.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          if (menuItem.isSpicy)
                            const Icon(
                              Icons.local_fire_department,
                              color: Colors.red,
                              size: 20,
                            ),
                          if (menuItem.isVegan)
                            const Icon(
                              Icons.eco,
                              color: Colors.green,
                              size: 20,
                            ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),
                  Text(
                    menuItem.restaurantName,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text('${menuItem.rating}'),
                      const SizedBox(width: 8),
                      Text(
                        '(${menuItem.reviews} reviews)',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  Text(
                    menuItem.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),

                  const Spacer(),

                  // Price and Add to cart
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            menuItem.price,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange,
                            ),
                          ),
                          Text(
                            menuItem.originalPrice,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${menuItem.name} added to cart'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                        icon: const Icon(Icons.add_shopping_cart),
                        label: const Text('Add to Cart'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _showAppBar
          ? AppBar(
              title: const Text('Restaurant Finder'),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0,
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => _navigateToRestaurants(),
                ),
                IconButton(
                  icon: const Icon(Icons.person),
                  onPressed: () => _navigateToProfile(),
                ),
              ],
            )
          : null,
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Modern Header
                HomeHeader(
                  onMenuTap: () {
                    // Show app drawer or menu
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => _buildQuickMenu(),
                    );
                  },
                  onProfileTap: _navigateToProfile,
                ),
                const SizedBox(height: 24),

                // 🔹 Hero Banner with gradient
                HeroBanner(items: _getInteractiveHeroBannerItems()),
                const SizedBox(height: 32),

                // 🔹 Categories with icons
                CategoriesSection(categories: _getCategories()),
                const SizedBox(height: 32),

                // 🔹 Popular Destinations
                DestinationsSection(
                  destinations: _getDestinations(),
                  onSeeAllTap: _navigateToRestaurants,
                ),
                const SizedBox(height: 32),

                // 🔹 Popular Menus
                PopularMenusSection(menus: _getPopularMenus()),
                const SizedBox(height: 32),

                // 🔹 Special Offers
                OffersSection(offers: _getOffers()),
                const SizedBox(height: 32),

                // 🔹 Restaurants Section
                RestaurantsSection(
                  restaurants: _getRestaurants(),
                  onViewMoreTap: _navigateToRestaurants,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.keyboard_arrow_up, color: Colors.white),
      ),
    );
  }

  List<CategoryData> _getCategories() {
    return [
      CategoryData(
        icon: Icons.local_pizza,
        title: "Pizza",
        color: const Color(0xFFFF6B6B),
        onTap: () => _onCategoryTap(
          const CategoryData(
            icon: Icons.local_pizza,
            title: "Pizza",
            color: Color(0xFFFF6B6B),
          ),
        ),
      ),
      CategoryData(
        icon: Icons.fastfood,
        title: "Burgers",
        color: const Color(0xFF4ECDC4),
        onTap: () => _onCategoryTap(
          const CategoryData(
            icon: Icons.fastfood,
            title: "Burgers",
            color: Color(0xFF4ECDC4),
          ),
        ),
      ),
      CategoryData(
        icon: Icons.eco,
        title: "Salads",
        color: const Color(0xFF45B7D1),
        onTap: () => _onCategoryTap(
          const CategoryData(
            icon: Icons.eco,
            title: "Salads",
            color: Color(0xFF45B7D1),
          ),
        ),
      ),
      CategoryData(
        icon: Icons.ramen_dining,
        title: "Asian",
        color: const Color(0xFF96CEB4),
        onTap: () => _onCategoryTap(
          const CategoryData(
            icon: Icons.ramen_dining,
            title: "Asian",
            color: Color(0xFF96CEB4),
          ),
        ),
      ),
      CategoryData(
        icon: Icons.rice_bowl,
        title: "Chinese",
        color: const Color(0xFFFFEAA7),
        onTap: () => _onCategoryTap(
          const CategoryData(
            icon: Icons.rice_bowl,
            title: "Chinese",
            color: Color(0xFFFFEAA7),
          ),
        ),
      ),
      CategoryData(
        icon: Icons.set_meal,
        title: "Sushi",
        color: const Color(0xFFDDA0DD),
        onTap: () => _onCategoryTap(
          const CategoryData(
            icon: Icons.set_meal,
            title: "Sushi",
            color: Color(0xFFDDA0DD),
          ),
        ),
      ),
    ];
  }

  List<DestinationData> _getDestinations() {
    return [
      DestinationData(
        name: "Bugolobi",
        image: "🍔",
        imageUrl: "assets/images/menu1.jpg",
        rating: 4.5,
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Exploring Bugolobi restaurants...'),
              duration: Duration(seconds: 2),
            ),
          );
          _navigateToRestaurants();
        },
      ),
      DestinationData(
        name: "Nakawa",
        image: "🥗",
        imageUrl: "assets/images/menu2.jpg",
        rating: 4.2,
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Exploring Nakawa restaurants...'),
              duration: Duration(seconds: 2),
            ),
          );
          _navigateToRestaurants();
        },
      ),
      DestinationData(
        name: "Kololo",
        image: "🍣",
        imageUrl: "assets/images/menu3.jpg",
        rating: 4.8,
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Exploring Kololo restaurants...'),
              duration: Duration(seconds: 2),
            ),
          );
          _navigateToRestaurants();
        },
      ),
      DestinationData(
        name: "Kiswa",
        image: "🍕",
        imageUrl: "assets/images/menu4.jpg",
        rating: 4.3,
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Exploring Kiswa restaurants...'),
              duration: Duration(seconds: 2),
            ),
          );
          _navigateToRestaurants();
        },
      ),
    ];
  }

  List<OfferData> _getOffers() {
    return [
      OfferData(
        title: "20% OFF",
        subtitle: "On all orders above \$20",
        color: const Color(0xFFFF6B6B),
        icon: Icons.local_offer,
        onTap: () => _onOfferTap(
          const OfferData(
            title: "20% OFF",
            subtitle: "On all orders above \$20",
            color: Color(0xFFFF6B6B),
            icon: Icons.local_offer,
          ),
        ),
      ),
      OfferData(
        title: "Buy 1 Get 1",
        subtitle: "Free dessert with main course",
        color: const Color(0xFF4ECDC4),
        icon: Icons.card_giftcard,
        onTap: () => _onOfferTap(
          const OfferData(
            title: "Buy 1 Get 1",
            subtitle: "Free dessert with main course",
            color: Color(0xFF4ECDC4),
            icon: Icons.card_giftcard,
          ),
        ),
      ),
      OfferData(
        title: "Free Delivery",
        subtitle: "No delivery fee on orders \$15+",
        color: const Color(0xFF9B59B6),
        icon: Icons.delivery_dining,
        onTap: () => _onOfferTap(
          const OfferData(
            title: "Free Delivery",
            subtitle: "No delivery fee on orders \$15+",
            color: Color(0xFF9B59B6),
            icon: Icons.delivery_dining,
          ),
        ),
      ),
      OfferData(
        title: "30% OFF",
        subtitle: "First order discount for new users",
        color: const Color(0xFFE67E22),
        icon: Icons.celebration,
        onTap: () => _onOfferTap(
          const OfferData(
            title: "30% OFF",
            subtitle: "First order discount for new users",
            color: Color(0xFFE67E22),
            icon: Icons.celebration,
          ),
        ),
      ),
      OfferData(
        title: "Flash Sale",
        subtitle: "50% off on selected items",
        color: const Color(0xFFE74C3C),
        icon: Icons.flash_on,
        onTap: () => _onOfferTap(
          const OfferData(
            title: "Flash Sale",
            subtitle: "50% off on selected items",
            color: Color(0xFFE74C3C),
            icon: Icons.flash_on,
          ),
        ),
      ),
      OfferData(
        title: "Happy Hour",
        subtitle: "2PM-5PM daily special deals",
        color: const Color(0xFF27AE60),
        icon: Icons.access_time,
        onTap: () => _onOfferTap(
          const OfferData(
            title: "Happy Hour",
            subtitle: "2PM-5PM daily special deals",
            color: Color(0xFF27AE60),
            icon: Icons.access_time,
          ),
        ),
      ),
    ];
  }

  List<PopularMenuData> _getPopularMenus() {
    return [
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
        onTap: () => _onMenuItemTap(
          const PopularMenuData(
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
        ),
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
        onTap: () => _onMenuItemTap(
          const PopularMenuData(
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
        ),
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
        onTap: () => _onMenuItemTap(
          const PopularMenuData(
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
        ),
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
        onTap: () => _onMenuItemTap(
          const PopularMenuData(
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
        ),
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
        onTap: () => _onMenuItemTap(
          const PopularMenuData(
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
        ),
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
        onTap: () => _onMenuItemTap(
          const PopularMenuData(
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
        ),
      ),
    ];
  }

  List<RestaurantData> _getRestaurants() {
    return [
      RestaurantData(
        name: "The Gourmet Hub",
        type: "International",
        deliveryTime: "20-45 min",
        rating: 4.8,
        imageUrl: "assets/images/restaurant1.jpg",
        onTap: () => _navigateToMenu(),
      ),
      RestaurantData(
        name: "Urban Kitchen",
        type: "Asian Fusion",
        deliveryTime: "25-40 min",
        rating: 4.6,
        imageUrl: "assets/images/restaurant2.jpg",
        onTap: () => _navigateToMenu(),
      ),
      RestaurantData(
        name: "Bistro Central",
        type: "French",
        deliveryTime: "30-50 min",
        rating: 4.9,
        imageUrl: "assets/images/restaurant3.jpg",
        onTap: () => _navigateToMenu(),
      ),
      RestaurantData(
        name: "Pizza Paradiso",
        type: "Italian",
        deliveryTime: "20-30 min",
        rating: 4.5,
        imageUrl: "assets/images/restaurant5.jpg",
        onTap: () => _navigateToMenu(),
      ),
    ];
  }
}
