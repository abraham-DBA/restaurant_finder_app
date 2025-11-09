import 'package:flutter/material.dart';

class RestaurantHeaderSection extends StatelessWidget {
  final String restaurantName;
  final String greeting;
  final VoidCallback? onBackPressed;

  const RestaurantHeaderSection({
    super.key,
    required this.restaurantName,
    required this.greeting,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back button (only show if callback provided)
          if (onBackPressed != null)
            GestureDetector(
              onTap: onBackPressed,
              child: Container(
                width: 44,
                height: 44,
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
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.grey[700],
                  size: 18,
                ),
              ),
            ),

          Column(
            crossAxisAlignment: onBackPressed != null
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [
              Text(
                restaurantName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[800],
                ),
              ),
              Text(
                greeting,
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ],
          ),
          Container(
            width: 44,
            height: 44,
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
            child: Icon(Icons.notifications_outlined, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}
