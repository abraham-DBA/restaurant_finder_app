import 'package:flutter/material.dart';
import '../destination_item.dart';

class DestinationsSection extends StatelessWidget {
  final String title;
  final String seeAllText;
  final List<DestinationData> destinations;
  final VoidCallback? onSeeAllTap;

  const DestinationsSection({
    super.key,
    this.title = "Popular Destinations",
    this.seeAllText = "See all",
    required this.destinations,
    this.onSeeAllTap,
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
              onTap: onSeeAllTap,
              child: Text(
                seeAllText,
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
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: destinations.length,
            itemBuilder: (context, index) {
              final destination = destinations[index];
              return DestinationItem(
                name: destination.name,
                image: destination.image,
                imageUrl: destination.imageUrl,
                rating: destination.rating,
                onTap: destination.onTap,
              );
            },
          ),
        ),
      ],
    );
  }
}

class DestinationData {
  final String name;
  final String image;
  final String? imageUrl;
  final double rating;
  final VoidCallback? onTap;

  const DestinationData({
    required this.name,
    required this.image,
    this.imageUrl,
    required this.rating,
    this.onTap,
  });
}
