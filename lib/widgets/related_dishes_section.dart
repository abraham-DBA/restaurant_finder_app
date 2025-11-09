import 'package:flutter/material.dart';

class RelatedDishData {
  final String name;
  final String price;
  final String? imageUrl;
  final String fallbackEmoji;
  final List<Color>? gradientColors;
  final VoidCallback? onTap;

  const RelatedDishData({
    required this.name,
    required this.price,
    this.imageUrl,
    this.fallbackEmoji = "🍽️",
    this.gradientColors,
    this.onTap,
  });
}

class RelatedDishesSection extends StatelessWidget {
  final String title;
  final List<RelatedDishData> dishes;

  const RelatedDishesSection({
    super.key,
    this.title = "You Might Also Like",
    required this.dishes,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: dishes.length,
            itemBuilder: (context, index) {
              final dish = dishes[index];
              return RelatedDishItem(
                name: dish.name,
                price: dish.price,
                imageUrl: dish.imageUrl,
                fallbackEmoji: dish.fallbackEmoji,
                gradientColors: dish.gradientColors,
                onTap: dish.onTap,
              );
            },
          ),
        ),
      ],
    );
  }
}

class RelatedDishItem extends StatelessWidget {
  final String name;
  final String price;
  final String? imageUrl;
  final String fallbackEmoji;
  final List<Color>? gradientColors;
  final VoidCallback? onTap;

  const RelatedDishItem({
    super.key,
    required this.name,
    required this.price,
    this.imageUrl,
    this.fallbackEmoji = "🍽️",
    this.gradientColors,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors =
        gradientColors ?? [const Color(0xFFFF6B6B), const Color(0xFFFFA726)];

    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 160,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: colors[0].withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: imageUrl != null
                  ? Image.asset(
                      imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildFallbackContainer(colors);
                      },
                    )
                  : _buildFallbackContainer(colors),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
              fontSize: 14,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            price,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 36,
            child: OutlinedButton(
              onPressed: onTap,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF6366F1),
                side: const BorderSide(color: Color(0xFF6366F1)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "View Dish",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFallbackContainer(List<Color> colors) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(fallbackEmoji, style: const TextStyle(fontSize: 40)),
      ),
    );
  }
}
