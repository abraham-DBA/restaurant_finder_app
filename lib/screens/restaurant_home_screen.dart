import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../widgets/sections/restaurant_header_section.dart';
import '../widgets/sections/restaurant_welcome_section.dart';
import '../widgets/sections/restaurant_location_section.dart';
import '../widgets/sections/restaurant_navigation_tabs.dart';
import '../widgets/sections/restaurant_menu_items_section.dart';
import '../utils/image_utils.dart';
import 'restaurant_detail_screen.dart';

class RestaurantHomeScreen extends StatefulWidget {
  final Restaurant? restaurant;

  const RestaurantHomeScreen({super.key, this.restaurant});

  @override
  State<RestaurantHomeScreen> createState() => _RestaurantHomeScreenState();
}

class _RestaurantHomeScreenState extends State<RestaurantHomeScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              RestaurantHeaderSection(
                restaurantName: _getRestaurantName(),
                greeting: _getGreeting(),
                onBackPressed: () => Navigator.pop(context),
              ),

              // Restaurant Image
              _buildRestaurantImage(),
              const SizedBox(height: 20),

              // Welcome Section
              RestaurantWelcomeSection(
                restaurantName: _getRestaurantName(),
                description: _getRestaurantDescription(),
              ),

              // Location Section
              RestaurantLocationSection(
                location: _getLocation(),
                onLocationTap: _openMap,
              ),

              // Navigation Tabs
              RestaurantNavigationTabs(
                selectedTab: selectedTab,
                onTabChanged: (index) {
                  setState(() {
                    selectedTab = index;
                  });
                },
              ),

              // Dynamic Content based on selected tab
              _buildTabContent(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Data provider methods
  String _getRestaurantName() => widget.restaurant?.name ?? "The Gourmet Hub";

  String _getGreeting() => "Good morning! 👋";

  String _getRestaurantDescription() => widget.restaurant != null
      ? "Welcome to ${widget.restaurant!.name}. ${widget.restaurant!.cuisine} cuisine restaurant offering fresh, delicious meals made with love. We serve a variety of dishes crafted from the finest ingredients to satisfy every craving."
      : "A cozy and modern restaurant that brings you delicious, freshly prepared meals made with love. We serve a variety of local and international dishes, crafted from the finest ingredients to satisfy every craving.";

  String _getLocation() => "Central Kampala";

  // Tab content builder
  Widget _buildTabContent() {
    switch (selectedTab) {
      case 0: // Menus
        return Column(
          children: [
            // Booking Section
            _buildBookingSection(),
            const SizedBox(height: 20),
            // Menu Items
            RestaurantMenuItemsSection(
              restaurant: widget.restaurant,
              onMenuItemTap: (item) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RestaurantDetailScreen(menuItem: item),
                  ),
                );
              },
            ),
          ],
        );
      case 1: // Reviews
        return _buildReviewsContent();
      case 2: // About
        return _buildAboutContent();
      default:
        return const SizedBox();
    }
  }

  Widget _buildRestaurantImage() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: widget.restaurant?.imageUrl != null
            ? Image(
                image: ImageUtils.getImageProvider(widget.restaurant!.imageUrl),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 250,
                errorBuilder: (context, error, stackTrace) =>
                    _buildImagePlaceholder(),
              )
            : _buildImagePlaceholder(),
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey[300]!, Colors.grey[100]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant, size: 50, color: Colors.grey[600]),
            const SizedBox(height: 8),
            Text(
              _getRestaurantName(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Make a Reservation",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Book your table in advance for the best dining experience",
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _showBookingDialog(),
                  icon: const Icon(Icons.calendar_today, size: 18),
                  label: const Text("Book Table"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6366F1),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _openMap(),
                  icon: const Icon(Icons.location_on, size: 18),
                  label: const Text("View Location"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF6366F1),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsContent() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Customer Reviews",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 16),
          _buildReviewCard(
            "Sarah M.",
            5,
            "Amazing food and great service! The atmosphere is perfect for a romantic dinner.",
            "2 days ago",
          ),
          const SizedBox(height: 12),
          _buildReviewCard(
            "John D.",
            4,
            "Delicious meals with reasonable prices. Will definitely come back again.",
            "1 week ago",
          ),
          const SizedBox(height: 12),
          _buildReviewCard(
            "Emma L.",
            5,
            "Best restaurant in town! The staff is friendly and the food is exceptional.",
            "2 weeks ago",
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () => _showWriteReviewDialog(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6366F1),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Write a Review"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(String name, int rating, String review, String time) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    Icons.star,
                    size: 16,
                    color: index < rating ? Colors.amber : Colors.grey[300],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            review,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          Text(time, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildAboutContent() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              "About ${_getRestaurantName()}",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.grey[800],
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildAboutSection("Restaurant Info", [
            "Cuisine: ${widget.restaurant?.cuisine ?? 'International'}",
            "Rating: ${widget.restaurant?.rating ?? '4.5'} ⭐",
            "Price Range: ${widget.restaurant?.priceRange ?? '\$\$ - \$\$\$'}",
            "Distance: ${widget.restaurant?.distance ?? '2.5 km'} from you",
          ]),
          const SizedBox(height: 20),
          _buildAboutSection("Opening Hours", [
            "Monday - Friday: 9:00 AM - 10:00 PM",
            "Saturday: 10:00 AM - 11:00 PM",
            "Sunday: 10:00 AM - 9:00 PM",
            "Kitchen closes 30 minutes before closing time",
          ]),
          const SizedBox(height: 20),
          _buildAboutSection("Contact Information", [
            "Phone: +256 700 123 456",
            "Email: info@${_getRestaurantName().toLowerCase().replaceAll(' ', '')}.com",
            "Address: Central Kampala, Uganda",
            "Delivery: Available through our app",
          ]),
          const SizedBox(height: 20),
          _buildAboutSection("Features", [
            "🅿️ Free parking available",
            "📶 Free WiFi for customers",
            "🍷 Licensed bar with wine selection",
            "👨‍👩‍👧‍👦 Family-friendly environment",
            "♿ Wheelchair accessible",
            "🎵 Live music on weekends",
          ]),
        ],
      ),
    );
  }

  Widget _buildAboutSection(String title, List<String> items) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 16),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 4,
                    height: 4,
                    margin: const EdgeInsets.only(top: 8, right: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6366F1),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 15,
                        height: 1.4,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showBookingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return _BookingDialog(restaurantName: _getRestaurantName());
      },
    );
  }

  void _showWriteReviewDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Write a Review"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: "Your Name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: "Your Review",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text("Rating: "),
                  ...List.generate(
                    5,
                    (index) => IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.star_border, color: Colors.grey[400]),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Review submitted!")),
                );
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }

  void _openMap() {
    // Show map options dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Open Location"),
          content: const Text(
            "Choose how you'd like to view the restaurant location:",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _launchGoogleMaps();
              },
              child: const Text("Google Maps"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _launchAppleMaps();
              },
              child: const Text("Apple Maps"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void _launchGoogleMaps() {
    // final String googleMapsUrl = "https://www.google.com/maps/search/?api=1&query=Central+Kampala+Uganda+${_getRestaurantName().replaceAll(' ', '+')}";
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Opening Google Maps for ${_getRestaurantName()}"),
        duration: const Duration(seconds: 2),
      ),
    );
    // In a real app, you would use url_launcher package here:
    // launchUrl(Uri.parse(googleMapsUrl));
  }

  void _launchAppleMaps() {
    // final String appleMapsUrl = "http://maps.apple.com/?q=Central+Kampala+Uganda+${_getRestaurantName().replaceAll(' ', '+')}";
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Opening Apple Maps for ${_getRestaurantName()}"),
        duration: const Duration(seconds: 2),
      ),
    );
    // In a real app, you would use url_launcher package here:
    // launchUrl(Uri.parse(appleMapsUrl));
  }
}

class _BookingDialog extends StatefulWidget {
  final String restaurantName;

  const _BookingDialog({required this.restaurantName});

  @override
  State<_BookingDialog> createState() => _BookingDialogState();
}

class _BookingDialogState extends State<_BookingDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _guestsController = TextEditingController();
  final _specialRequestsController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedTable;

  final List<String> _tableTypes = [
    'Window Seat',
    'Private Booth',
    'Standard Table',
    'Bar Counter',
    'Garden Patio',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _guestsController.dispose();
    _specialRequestsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 700),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6366F1).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.restaurant_rounded,
                        color: Color(0xFF6366F1),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Reserve Table",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[800],
                            ),
                          ),
                          Text(
                            "at ${widget.restaurantName}",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close, color: Colors.grey[400]),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Name Field
                _buildTextField(
                  controller: _nameController,
                  label: "Full Name",
                  icon: Icons.person_outline,
                  validator: (value) {
                    if (value?.isEmpty ?? true) return "Please enter your name";
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Phone Field
                _buildTextField(
                  controller: _phoneController,
                  label: "Phone Number",
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Please enter your phone number";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Number of Guests
                _buildTextField(
                  controller: _guestsController,
                  label: "Number of Guests",
                  icon: Icons.group_outlined,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Please enter number of guests";
                    }
                    int? guests = int.tryParse(value!);
                    if (guests == null || guests < 1) {
                      return "Please enter a valid number";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Date Picker
                _buildDateField(),

                const SizedBox(height: 16),

                // Time Picker
                _buildTimeField(),

                const SizedBox(height: 16),

                // Table Preference
                _buildTableTypeDropdown(),

                const SizedBox(height: 16),

                // Special Requests
                _buildTextField(
                  controller: _specialRequestsController,
                  label: "Special Requests (Optional)",
                  icon: Icons.note_outlined,
                  maxLines: 3,
                ),

                const SizedBox(height: 24),

                // Booking Summary
                _buildBookingSummary(),

                const SizedBox(height: 24),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text("Cancel"),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: _submitBooking,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6366F1),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Confirm Reservation",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF6366F1)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF6366F1), width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }

  Widget _buildDateField() {
    return GestureDetector(
      onTap: _selectDate,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[50],
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today, color: const Color(0xFF6366F1)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Reservation Date",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _selectedDate != null
                        ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"
                        : "Select date",
                    style: TextStyle(
                      fontSize: 16,
                      color: _selectedDate != null
                          ? Colors.grey[800]
                          : Colors.grey[500],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeField() {
    return GestureDetector(
      onTap: _selectTime,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[50],
        ),
        child: Row(
          children: [
            Icon(Icons.access_time, color: const Color(0xFF6366F1)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Reservation Time",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _selectedTime != null
                        ? _selectedTime!.format(context)
                        : "Select time",
                    style: TextStyle(
                      fontSize: 16,
                      color: _selectedTime != null
                          ? Colors.grey[800]
                          : Colors.grey[500],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  Widget _buildTableTypeDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[50],
      ),
      child: DropdownButtonFormField<String>(
        initialValue: _selectedTable,
        decoration: InputDecoration(
          labelText: "Table Preference",
          prefixIcon: Icon(
            Icons.table_restaurant,
            color: const Color(0xFF6366F1),
          ),
          border: InputBorder.none,
        ),
        items: _tableTypes.map((String table) {
          return DropdownMenuItem<String>(value: table, child: Text(table));
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedTable = newValue;
          });
        },
      ),
    );
  }

  Widget _buildBookingSummary() {
    if (_selectedDate == null || _selectedTime == null) return const SizedBox();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF6366F1).withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF6366F1).withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Booking Summary",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year} at ${_selectedTime!.format(context)}",
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
          if (_guestsController.text.isNotEmpty)
            Text(
              "${_guestsController.text} guest${int.tryParse(_guestsController.text) != 1 ? 's' : ''}",
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
          if (_selectedTable != null)
            Text(
              "Table: $_selectedTable",
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
        ],
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(
              context,
            ).colorScheme.copyWith(primary: const Color(0xFF6366F1)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 19, minute: 0),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(
              context,
            ).colorScheme.copyWith(primary: const Color(0xFF6366F1)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _submitBooking() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_selectedDate == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Please select a date")));
        return;
      }
      if (_selectedTime == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Please select a time")));
        return;
      }

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Reservation confirmed for ${_selectedDate!.day}/${_selectedDate!.month} at ${_selectedTime!.format(context)}",
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}
