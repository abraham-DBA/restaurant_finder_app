import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../models/category.dart';

// Categories data
final List<Category> categories = [
  Category('All', Icons.restaurant, true),
  Category('Fast Food', Icons.fastfood, false),
  Category('Local', Icons.local_dining, false),
  Category('Coffee', Icons.coffee, false),
  Category('Pizza', Icons.local_pizza, false),
  Category('Drinks', Icons.local_bar, false),
];

// Sample restaurant data with actual food images from Unsplash
final List<Restaurant> restaurantData = [
  Restaurant(
    name: 'The Gourmet Hub',
    cuisine: 'International',
    rating: 4.8,
    deliveryTime: '20-45 min',
    imageUrl: 'assets/images/restaurant1.jpg',
    distance: '1.2 km away',
    priceRange: '\$\$',
    closingTime: '10 PM',
  ),
  Restaurant(
    name: 'Urban Kitchen',
    cuisine: 'Asian Fusion',
    rating: 4.6,
    deliveryTime: '25-40 min',
    imageUrl: 'assets/images/restaurant2.jpg',
    distance: '0.8 km away',
    priceRange: '\$\$\$',
    closingTime: '11 PM',
  ),
  Restaurant(
    name: 'Bistro Central',
    cuisine: 'French',
    rating: 4.9,
    deliveryTime: '30-50 min',
    imageUrl: 'assets/images/restaurant3.jpg',
    distance: '2.1 km away',
    priceRange: '\$\$\$\$',
    closingTime: '9 PM',
  ),
  Restaurant(
    name: 'Flavor Fusion',
    cuisine: 'Modern American',
    rating: 4.7,
    deliveryTime: '15-35 min',
    imageUrl: 'assets/images/restaurant4.jpg',
    distance: '1.5 km away',
    priceRange: '\$\$',
    closingTime: '10:30 PM',
  ),
  Restaurant(
    name: 'Pizza Paradiso',
    cuisine: 'Italian',
    rating: 4.5,
    deliveryTime: '20-30 min',
    imageUrl: 'assets/images/restaurant5.jpg',
    distance: '0.5 km away',
    priceRange: '\$',
    closingTime: '12 AM',
  ),
  Restaurant(
    name: 'Sushi Zen',
    cuisine: 'Japanese',
    rating: 4.8,
    deliveryTime: '35-55 min',
    imageUrl: 'assets/images/restaurant6.jpg',
    distance: '1.8 km away',
    priceRange: '\$\$\$',
    closingTime: '10 PM',
  ),
  Restaurant(
    name: 'Cafe Javas',
    cuisine: 'American',
    rating: 4.2,
    deliveryTime: '20-35 min',
    imageUrl: 'assets/images/restaurant7.jpg',
    distance: '2.8 km away',
    priceRange: '\$\$\$',
    closingTime: '12 AM',
  ),
];
