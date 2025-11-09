import 'package:flutter/material.dart';

class RestaurantDetailHeader extends StatefulWidget {
  final String dishName;
  final String price;
  final String cookTime;
  final String deliveryInfo;
  final double rating;
  final bool initialFavoriteState;
  final VoidCallback? onBackPressed;
  final VoidCallback? onFavoritePressed;

  const RestaurantDetailHeader({
    super.key,
    required this.dishName,
    required this.price,
    this.cookTime = "25-30 min",
    this.deliveryInfo = "Free delivery",
    this.rating = 4.8,
    this.initialFavoriteState = false,
    this.onBackPressed,
    this.onFavoritePressed,
  });

  @override
  State<RestaurantDetailHeader> createState() => _RestaurantDetailHeaderState();
}

class _RestaurantDetailHeaderState extends State<RestaurantDetailHeader> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.initialFavoriteState;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // App Bar
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                onPressed: widget.onBackPressed ?? () => Navigator.pop(context),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(
                  isFavorite
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  color: isFavorite ? Colors.red : Colors.grey[700],
                ),
                onPressed: () {
                  setState(() => isFavorite = !isFavorite);
                  widget.onFavoritePressed?.call();
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Dish Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.dishName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[800],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF4ECDC4).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF4ECDC4).withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                widget.price,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF4ECDC4),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.access_time_rounded, size: 16, color: Colors.grey[500]),
            const SizedBox(width: 6),
            Text(
              "${widget.cookTime} • ${widget.deliveryInfo}",
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }
}
