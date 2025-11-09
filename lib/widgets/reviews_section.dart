import 'package:flutter/material.dart';

class ReviewData {
  final String reviewerName;
  final int rating;
  final String timeAgo;
  final String comment;
  final Color avatarColor;

  const ReviewData({
    required this.reviewerName,
    required this.rating,
    required this.timeAgo,
    required this.comment,
    this.avatarColor = const Color(0xFF6366F1),
  });
}

class ReviewsSection extends StatelessWidget {
  final String title;
  final String seeAllText;
  final List<ReviewData> reviews;
  final VoidCallback? onSeeAllPressed;

  const ReviewsSection({
    super.key,
    this.title = "Customer Reviews",
    this.seeAllText = "See all",
    required this.reviews,
    this.onSeeAllPressed,
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
              onTap: onSeeAllPressed,
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
        ...reviews
            .map(
              (review) => Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 15,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: review.avatarColor.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.person_rounded,
                            color: review.avatarColor,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                review.reviewerName,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[800],
                                ),
                              ),
                              Row(
                                children: [
                                  ...List.generate(5, (index) {
                                    return Icon(
                                      Icons.star_rounded,
                                      size: 16,
                                      color: index < review.rating
                                          ? Colors.amber[600]
                                          : Colors.grey[300],
                                    );
                                  }),
                                  const SizedBox(width: 8),
                                  Text(
                                    review.timeAgo,
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      review.comment,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            )
            ,
      ],
    );
  }
}
