import 'package:flutter/material.dart';
import '../widgets/restaurant_card.dart';
import '../widgets/category_chip.dart';
import '../utils/mock_data.dart';
import '../models/restaurant.dart';
import '../models/category.dart';

class RestaurantsScreen extends StatefulWidget {
  const RestaurantsScreen({super.key});

  @override
  State<RestaurantsScreen> createState() => _RestaurantsScreenState();
}

class _RestaurantsScreenState extends State<RestaurantsScreen> {
  List<Restaurant> _filteredRestaurants = [];
  List<Category> _categories = [];
  String _selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _initializeData() {
    _categories = List.from(categories);
    _filteredRestaurants = List.from(restaurantData);
  }

  void _onCategorySelected(String categoryName) {
    setState(() {
      _selectedCategory = categoryName;
      _filterRestaurants();
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      _filterRestaurants();
    });
  }

  void _filterRestaurants() {
    List<Restaurant> filtered = List.from(restaurantData);

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((restaurant) {
        return restaurant.name.toLowerCase().contains(
              _searchQuery.toLowerCase(),
            ) ||
            restaurant.cuisine.toLowerCase().contains(
              _searchQuery.toLowerCase(),
            );
      }).toList();
    }

    // Filter by category
    if (_selectedCategory != 'All') {
      filtered = filtered.where((restaurant) {
        return _getCategoryForCuisine(restaurant.cuisine) == _selectedCategory;
      }).toList();
    }

    _filteredRestaurants = filtered;
  }

  String _getCategoryForCuisine(String cuisine) {
    switch (cuisine.toLowerCase()) {
      case 'fast food':
        return 'Fast Food';
      case 'italian':
        return 'Pizza';
      case 'coffee':
        return 'Coffee';
      case 'drinks':
        return 'Drinks';
      case 'international':
      case 'asian fusion':
      case 'french':
      case 'japanese':
      case 'indian':
      case 'thai':
        return 'Local';
      default:
        return 'Local';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Discover Restaurants',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            _buildSearchBar(),
            const SizedBox(height: 20),

            // Categories Section
            _buildCategoriesSection(),
            const SizedBox(height: 24),

            // Restaurants Section
            _buildRestaurantsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: _onSearchChanged,
        decoration: InputDecoration(
          hintText: 'Search restaurants, cuisines...',
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.grey),
                  onPressed: () {
                    _searchController.clear();
                    _onSearchChanged('');
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 16,
          ),
          hintStyle: TextStyle(color: Colors.grey[600]),
        ),
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4.0),
          child: Text(
            'Categories',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];
              final isSelected = category.name == _selectedCategory;
              final updatedCategory = Category(
                category.name,
                category.icon,
                isSelected,
              );
              return GestureDetector(
                onTap: () => _onCategorySelected(category.name),
                child: CategoryChip(category: updatedCategory),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRestaurantsSection() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _getRestaurantsSectionTitle(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${_filteredRestaurants.length} ${_filteredRestaurants.length == 1 ? 'place' : 'places'}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _filteredRestaurants.isEmpty
                ? _buildEmptyState()
                : ListView.separated(
                    itemCount: _filteredRestaurants.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      return RestaurantCard(
                        restaurant: _filteredRestaurants[index],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  String _getRestaurantsSectionTitle() {
    if (_selectedCategory != 'All') {
      return '$_selectedCategory Restaurants';
    } else {
      return 'Popular Restaurants';
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.restaurant_menu, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No restaurants found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _searchQuery.isNotEmpty
                ? 'No restaurants match your search'
                : 'No restaurants match the selected category',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
          if (_selectedCategory != 'All' || _searchQuery.isNotEmpty) ...[
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedCategory = 'All';
                  _searchController.clear();
                  _searchQuery = '';
                  _filterRestaurants();
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                _searchQuery.isNotEmpty
                    ? 'Clear Search'
                    : 'Show All Restaurants',
              ),
            ),
          ],
        ],
      ),
    );
  }
}
