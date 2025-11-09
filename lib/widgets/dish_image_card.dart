import 'package:flutter/material.dart';

class DishImageCard extends StatelessWidget {
  final String? imageUrl;
  final String fallbackEmoji;
  final double rating;
  final List<Color>? gradientColors;
  final double height;

  const DishImageCard({
    super.key,
    this.imageUrl,
    this.fallbackEmoji = "🍽️",
    this.rating = 4.8,
    this.gradientColors,
    this.height = 260,
  });

  @override
  Widget build(BuildContext context) {
    final colors =
        gradientColors ?? [const Color(0xFF667EEA), const Color(0xFF764BA2)];

    return Stack(
      children: [
        Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: colors[0].withValues(alpha: 0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
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
        Positioned(
          top: 16,
          right: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star_rounded, size: 16, color: Colors.amber[600]),
                const SizedBox(width: 4),
                Text(
                  rating.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(fallbackEmoji, style: const TextStyle(fontSize: 80)),
      ),
    );
  }
}
