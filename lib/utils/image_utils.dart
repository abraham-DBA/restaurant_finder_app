import 'package:flutter/material.dart';

class ImageUtils {
  static ImageProvider getImageProvider(String imagePath) {
    try {
      return AssetImage(imagePath);
    } catch (e) {
      // Fallback to a placeholder if image doesn't exist
      return const AssetImage('assets/images/placeholder.jpg');
    }
  }

  static Widget buildNetworkImageWithFallback(
    String imageUrl, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    return Image.asset(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          color: Colors.grey[300],
          child: const Icon(Icons.restaurant, color: Colors.grey),
        );
      },
    );
  }
}
