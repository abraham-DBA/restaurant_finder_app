import 'package:flutter/material.dart';
import '../widgets/menu_item_card.dart';
import '../widgets/menu_search_section.dart';
import '../widgets/menu_category_filters.dart';
import '../widgets/menu_empty_state.dart';
import '../utils/menu_data_service.dart';
import 'restaurant_detail_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final List<String> categories = MenuDataService.getCategories();
  final List<Map<String, dynamic>> menuItems = MenuDataService.getMenuItems();

  String selectedCategory = 'All';
  String searchQuery = '';

  List<Map<String, dynamic>> get filteredMenuItems {
    List<Map<String, dynamic>> filtered = menuItems;

    // Filter by category
    if (selectedCategory != 'All') {
      filtered = filtered
          .where((item) => item['category'] == selectedCategory)
          .toList();
    }

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered
          .where(
            (item) =>
                item['name'].toLowerCase().contains(
                  searchQuery.toLowerCase(),
                ) ||
                item['description'].toLowerCase().contains(
                  searchQuery.toLowerCase(),
                ),
          )
          .toList();
    }

    return filtered;
  }

  void _handleSearchChanged(String value) {
    setState(() {
      searchQuery = value;
    });
  }

  void _handleCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  void _handleItemTap(int index) {
    final item = filteredMenuItems[index];
    // Handle item tap - you can navigate to item details page
    print('Tapped on: ${item['name']}');
  }

  void _handleAddToOrder(int index) {
    final item = filteredMenuItems[index];
    // Navigate to restaurant detail screen for ordering with selected item
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RestaurantDetailScreen(menuItem: item),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: const Text(
          'Our Menu',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          // Search Section
          MenuSearchSection(
            onSearchChanged: _handleSearchChanged,
            searchQuery: searchQuery,
          ),

          // Category Filters
          MenuCategoryFilters(
            categories: categories,
            selectedCategory: selectedCategory,
            onCategorySelected: _handleCategorySelected,
          ),

          // Menu Items
          _buildMenuItems(),
        ],
      ),
    );
  }

  Widget _buildMenuItems() {
    final items = filteredMenuItems;

    return Expanded(
      child: Container(
        color: Colors.grey[50],
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${items.length} Items',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  if (selectedCategory != 'All')
                    Text(
                      selectedCategory,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: items.isEmpty
                  ? const MenuEmptyState()
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return MenuItemCard(
                          name: item['name'],
                          description: item['description'],
                          price: item['price'],
                          imagePath: item['image'],
                          rating: item['rating'],
                          prepTime: item['prepTime'],
                          onTap: () => _handleItemTap(index),
                          onAddToOrder: () => _handleAddToOrder(index),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
