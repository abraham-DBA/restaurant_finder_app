import 'package:flutter/material.dart';
import '../offer_card.dart';

class OffersSection extends StatelessWidget {
  final String title;
  final List<OfferData> offers;

  const OffersSection({
    super.key,
    this.title = "Special Offers",
    required this.offers,
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '🔥 Hot Deals',
                style: TextStyle(
                  color: Colors.orange[700],
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(right: 4),
            itemCount: offers.length,
            itemBuilder: (context, index) {
              final offer = offers[index];
              return Container(
                width: 280,
                margin: const EdgeInsets.only(right: 16),
                child: OfferCard(
                  title: offer.title,
                  subtitle: offer.subtitle,
                  color: offer.color,
                  icon: offer.icon,
                  onTap: offer.onTap,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class OfferData {
  final String title;
  final String subtitle;
  final Color color;
  final IconData icon;
  final VoidCallback? onTap;

  const OfferData({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.icon,
    this.onTap,
  });
}
