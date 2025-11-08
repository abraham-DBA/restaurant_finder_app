import 'package:flutter/material.dart';

// Data model for carousel items
class HeroCarouselItem {
  final String title;
  final String subtitle;
  final String? originalPrice;
  final String? discountPrice;
  final String? discountPercent;
  final String image;
  final String badgeText;
  final IconData badgeIcon;
  final List<Color> gradientColors;
  final VoidCallback? onTap;
  final HeroItemType type;

  const HeroCarouselItem({
    required this.title,
    required this.subtitle,
    this.originalPrice,
    this.discountPrice,
    this.discountPercent,
    required this.image,
    required this.badgeText,
    required this.badgeIcon,
    required this.gradientColors,
    this.onTap,
    required this.type,
  });
}

enum HeroItemType { product, restaurant }

class HeroBanner extends StatefulWidget {
  final List<HeroCarouselItem>? items;

  const HeroBanner({super.key, this.items});

  @override
  State<HeroBanner> createState() => _HeroBannerState();
}

class _HeroBannerState extends State<HeroBanner> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // Auto-scroll timer
    Future.delayed(const Duration(seconds: 3), _autoScroll);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _autoScroll() {
    if (mounted) {
      final items = widget.items ?? _getDefaultItems();
      final nextPage = (_currentPage + 1) % items.length;

      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      Future.delayed(const Duration(seconds: 4), _autoScroll);
    }
  }

  List<HeroCarouselItem> _getDefaultItems() {
    return [
      // Featured Products
      HeroCarouselItem(
        title: "Signature Burger Deluxe",
        subtitle:
            "Premium beef patty with truffle sauce, aged cheese, and fresh vegetables",
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
      ),

      // Featured Restaurant
      HeroCarouselItem(
        title: "The Gourmet Hub",
        subtitle:
            "Award-winning international cuisine • 4.8★ rating • 20-45 min delivery",
        image: "assets/images/restaurant2.jpg",
        badgeText: "Top Rated",
        badgeIcon: Icons.restaurant,
        gradientColors: [
          const Color(0xFF9CA3AF),
          const Color(0xFF6B7280),
          const Color(0xFF4B5563),
        ],
        type: HeroItemType.restaurant,
      ),

      // Another Product
      HeroCarouselItem(
        title: "Truffle Pasta Supreme",
        subtitle:
            "Handmade pasta with black truffle, parmesan, and wild mushrooms",
        originalPrice: "\$32.99",
        discountPrice: "\$24.99",
        discountPercent: "24% OFF",
        image: "assets/images/restaurant3.jpg",
        badgeText: "Limited Time",
        badgeIcon: Icons.flash_on,
        gradientColors: [
          const Color(0xFF71717A),
          const Color(0xFF52525B),
          const Color(0xFF3F3F46),
        ],
        type: HeroItemType.product,
      ),

      // Another Restaurant
      HeroCarouselItem(
        title: "Bella Vista Italiano",
        subtitle:
            "Authentic Italian dining experience • 4.6★ rating • Free delivery",
        image: "assets/images/restaurant4.jpg",
        badgeText: "Free Delivery",
        badgeIcon: Icons.delivery_dining,
        gradientColors: [
          const Color(0xFF94A3B8),
          const Color(0xFF64748B),
          const Color(0xFF475569),
        ],
        type: HeroItemType.restaurant,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.items ?? _getDefaultItems();

    return Column(
      children: [
        SizedBox(
          height: 210,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return _buildCarouselItem(item);
            },
          ),
        ),

        // Page indicators
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            items.length,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentPage == index ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: _currentPage == index
                    ? Colors.grey[600]
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCarouselItem(HeroCarouselItem item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: item.gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: item.onTap,
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Background geometric patterns
              Positioned(
                right: -40,
                top: -40,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                right: 20,
                bottom: -20,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),

              // Main content
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    // Left side - Info
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.3),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  item.badgeIcon,
                                  color: Colors.white,
                                  size: 14,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  item.badgeText,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Title
                          Text(
                            item.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              height: 1.1,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),

                          // Subtitle/Description
                          Text(
                            item.subtitle,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              height: 1.2,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 12),

                          // Price row (only for products)
                          if (item.type == HeroItemType.product &&
                              item.discountPrice != null)
                            Row(
                              children: [
                                // Discount badge
                                if (item.discountPercent != null)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.red.withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      item.discountPercent!,
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                if (item.discountPercent != null)
                                  const SizedBox(width: 12),

                                // Prices
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.discountPrice!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    if (item.originalPrice != null)
                                      Text(
                                        item.originalPrice!,
                                        style: TextStyle(
                                          color: Colors.white.withValues(
                                            alpha: 0.6,
                                          ),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),

                    // Right side - Image
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: 0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Stack(
                            children: [
                              // Image
                              Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey[800],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Image.asset(
                                  item.image,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: item.gradientColors
                                              .take(2)
                                              .toList(),
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(
                                        item.type == HeroItemType.restaurant
                                            ? Icons.restaurant
                                            : Icons.fastfood,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    );
                                  },
                                ),
                              ),

                              // Overlay gradient
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withValues(alpha: 0.2),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),

                              // Action button
                              Positioned(
                                bottom: 12,
                                right: 12,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withValues(
                                          alpha: 0.3,
                                        ),
                                        blurRadius: 6,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        item.type == HeroItemType.restaurant
                                            ? Icons.location_on
                                            : Icons.add_shopping_cart,
                                        color: item.gradientColors[0],
                                        size: 14,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        item.type == HeroItemType.restaurant
                                            ? 'Visit'
                                            : 'Order',
                                        style: TextStyle(
                                          color: item.gradientColors[0],
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
