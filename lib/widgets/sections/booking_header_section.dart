import 'package:flutter/material.dart';

class BookingHeaderSection extends StatelessWidget {
  final VoidCallback onBackPressed;

  const BookingHeaderSection({super.key, required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          // Back Button
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
            child: IconButton(
              onPressed: onBackPressed,
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: Colors.grey[700],
              ),
              padding: EdgeInsets.zero,
            ),
          ),
          const SizedBox(width: 16),
          // Title
          Text(
            "My Bookings",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.grey[800],
            ),
          ),
          const Spacer(),
          // Search/Filter Icon (optional)
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
            child: IconButton(
              onPressed: () {
                // Handle search/filter action
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Search & Filter feature coming soon!"),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              icon: Icon(
                Icons.search_rounded,
                size: 20,
                color: Colors.grey[600],
              ),
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}
