class MenuItem {
  final String name;
  final String description;
  final String price;
  final String imagePath;
  final String category;
  final double rating;
  final String prepTime;

  const MenuItem({
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.category,
    required this.rating,
    required this.prepTime,
  });

  // You can add toJson/fromJson methods if needed for API integration
}
