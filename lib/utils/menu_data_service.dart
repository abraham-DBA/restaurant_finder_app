class MenuDataService {
  static List<Map<String, dynamic>> getMenuItems() {
    return [
      {
        'name': 'Chicken Stir-Fry',
        'description':
            'Succulent crispy, dry chicken, vegetables and savory sauce',
        'price': 'UGX 32,000',
        'image': 'assets/images/menu1.jpg',
        'category': 'Mains',
        'rating': 4.5,
        'prepTime': '20-25 min',
      },
      {
        'name': 'Beef Pilau',
        'description': 'Tender beef served with spiced rice and salad',
        'price': 'UGX 28,000',
        'image': 'assets/images/menu2.jpg',
        'category': 'Mains',
        'rating': 4.3,
        'prepTime': '25-30 min',
      },
      {
        'name': 'Grilled Fish',
        'description': 'Fresh fish grilled with herbs and lemon sauce',
        'price': 'UGX 35,000',
        'image': 'assets/images/menu3.jpg',
        'category': 'Mains',
        'rating': 4.7,
        'prepTime': '30-35 min',
      },
      {
        'name': 'Chapati Wrap',
        'description': 'Soft chapati rolled with eggs, beef, and veggies',
        'price': 'UGX 15,000',
        'image': 'assets/images/menu4.jpg',
        'category': 'Starters',
        'rating': 4.2,
        'prepTime': '15-20 min',
      },
      {
        'name': 'Fruit Juice',
        'description': 'Freshly squeezed seasonal fruit juice',
        'price': 'UGX 8,000',
        'image': 'assets/images/image5.jpg',
        'category': 'Drinks',
        'rating': 4.4,
        'prepTime': '5-10 min',
      },
      {
        'name': 'Chocolate Cake',
        'description': 'Rich chocolate cake with vanilla ice cream',
        'price': 'UGX 12,000',
        'image': 'assets/images/image6.jpg',
        'category': 'Desserts',
        'rating': 4.6,
        'prepTime': '10-15 min',
      },
      {
        'name': 'Chocolate Cake',
        'description': 'Rich chocolate cake with vanilla ice cream',
        'price': 'UGX 12,000',
        'image': 'assets/images/image7.jpeg',
        'category': 'Desserts',
        'rating': 4.6,
        'prepTime': '10-15 min',
      },
      {
        'name': 'Chocolate Cake',
        'description': 'Rich chocolate cake with vanilla ice cream',
        'price': 'UGX 12,000',
        'image': 'assets/images/image8.jpg',
        'category': 'Desserts',
        'rating': 4.6,
        'prepTime': '10-15 min',
      },
      {
        'name': 'Chocolate Cake',
        'description': 'Rich chocolate cake with vanilla ice cream',
        'price': 'UGX 12,000',
        'image': 'assets/images/image9.jpg',
        'category': 'Desserts',
        'rating': 4.6,
        'prepTime': '10-15 min',
      },
      {
        'name': 'Chocolate Cake',
        'description': 'Rich chocolate cake with vanilla ice cream',
        'price': 'UGX 12,000',
        'image': 'assets/images/image10.jpg',
        'category': 'Desserts',
        'rating': 4.6,
        'prepTime': '10-15 min',
      },
      {
        'name': 'Chocolate Cake',
        'description': 'Rich chocolate cake with vanilla ice cream',
        'price': 'UGX 12,000',
        'image': 'assets/images/image11.jpg',
        'category': 'Desserts',
        'rating': 4.6,
        'prepTime': '10-15 min',
      },
    ];
  }

  static List<String> getCategories() {
    return ['All', 'Starters', 'Mains', 'Drinks', 'Desserts'];
  }
}
