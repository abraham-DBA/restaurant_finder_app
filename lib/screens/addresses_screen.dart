import 'package:flutter/material.dart';
import '../widgets/sections/address_header_section.dart';
import '../widgets/sections/addresses_list_section.dart';
import '../widgets/sections/add_address_section.dart';
import '../models/address.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({super.key});

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  List<Address> _addresses = Address.getSampleAddresses();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            AddressHeaderSection(
              onBackPressed: () => Navigator.pop(context),
              addressCount: _addresses.length,
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // Add Address Section
                    AddAddressSection(
                      onAddAddress: _showAddAddressDialog,
                      onCurrentLocation: _useCurrentLocation,
                    ),

                    const SizedBox(height: 24),

                    // Addresses List
                    AddressesListSection(
                      addresses: _addresses,
                      isLoading: _isLoading,
                      onSetDefault: _setDefaultAddress,
                      onEdit: _editAddress,
                      onDelete: _deleteAddress,
                    ),

                    const SizedBox(height: 32),

                    // Location Info Section
                    _buildLocationInfoSection(),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationInfoSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF4CAF50).withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF4CAF50).withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.location_on_rounded,
                  color: Color(0xFF4CAF50),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "Delivery Information",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            "Your addresses are used for food delivery and table reservations. Make sure they're accurate for the best experience.",
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green[600], size: 16),
              const SizedBox(width: 8),
              Text(
                "GPS coordinates for accurate delivery",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green[600], size: 16),
              const SizedBox(width: 8),
              Text(
                "Delivery instructions for drivers",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAddAddressDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController titleController = TextEditingController();
        final TextEditingController streetController = TextEditingController();
        final TextEditingController cityController = TextEditingController();
        final TextEditingController stateController = TextEditingController();
        final TextEditingController postalCodeController =
            TextEditingController();
        final TextEditingController countryController = TextEditingController();
        final TextEditingController instructionsController =
            TextEditingController();
        String selectedType = 'home';

        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.add_location_outlined,
                    color: Color(0xFF4CAF50),
                    size: 18,
                  ),
                ),
                const SizedBox(width: 8),
                const Text("Add Address"),
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Address Type
                  DropdownButtonFormField<String>(
                    value: selectedType,
                    decoration: const InputDecoration(
                      labelText: "Address Type",
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: 'home',
                        child: Row(
                          children: [
                            Icon(
                              Icons.home_outlined,
                              size: 18,
                              color: Color(0xFF4CAF50),
                            ),
                            SizedBox(width: 8),
                            Text('Home'),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'work',
                        child: Row(
                          children: [
                            Icon(
                              Icons.business_outlined,
                              size: 18,
                              color: Color(0xFF2196F3),
                            ),
                            SizedBox(width: 8),
                            Text('Work'),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'other',
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 18,
                              color: Color(0xFF9C27B0),
                            ),
                            SizedBox(width: 8),
                            Text('Other'),
                          ],
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedType = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // Title
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: "Address Title",
                      hintText: "e.g., My Home, Office, etc.",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Street
                  TextField(
                    controller: streetController,
                    decoration: const InputDecoration(
                      labelText: "Street Address",
                      hintText: "123 Main Street, Apt 4B",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // City and State
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: cityController,
                          decoration: const InputDecoration(
                            labelText: "City",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: stateController,
                          decoration: const InputDecoration(
                            labelText: "State/Region",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Postal Code and Country
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: postalCodeController,
                          decoration: const InputDecoration(
                            labelText: "Postal Code",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: countryController,
                          decoration: const InputDecoration(
                            labelText: "Country",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Delivery Instructions
                  TextField(
                    controller: instructionsController,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      labelText: "Delivery Instructions (Optional)",
                      hintText: "e.g., Ring the bell, Call when you arrive",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  titleController.dispose();
                  streetController.dispose();
                  cityController.dispose();
                  stateController.dispose();
                  postalCodeController.dispose();
                  countryController.dispose();
                  instructionsController.dispose();
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  // Add address logic here
                  final newAddress = Address(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    type: selectedType,
                    title: titleController.text,
                    street: streetController.text,
                    city: cityController.text,
                    state: stateController.text,
                    postalCode: postalCodeController.text,
                    country: countryController.text,
                    instructions: instructionsController.text.isEmpty
                        ? null
                        : instructionsController.text,
                    isDefault: _addresses.isEmpty,
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                  );

                  setState(() {
                    _addresses.add(newAddress);
                  });

                  titleController.dispose();
                  streetController.dispose();
                  cityController.dispose();
                  stateController.dispose();
                  postalCodeController.dispose();
                  countryController.dispose();
                  instructionsController.dispose();
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Address added successfully!"),
                      backgroundColor: Color(0xFF4CAF50),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  foregroundColor: Colors.white,
                ),
                child: const Text("Add Address"),
              ),
            ],
          ),
        );
      },
    );
  }

  void _useCurrentLocation() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Getting your current location..."),
        backgroundColor: Color(0xFF2196F3),
      ),
    );

    // In a real app, you would use location services here
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Location services feature coming soon!"),
            backgroundColor: Color(0xFF4CAF50),
          ),
        );
      }
    });
  }

  void _setDefaultAddress(Address address) {
    setState(() {
      _isLoading = true;
      // Remove default from all addresses
      _addresses = _addresses
          .map((addr) => addr.copyWith(isDefault: false))
          .toList();
      // Set new default
      final index = _addresses.indexWhere((addr) => addr.id == address.id);
      if (index != -1) {
        _addresses[index] = _addresses[index].copyWith(isDefault: true);
      }
    });

    // Simulate API call
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${address.title} set as default address"),
            backgroundColor: Colors.green,
          ),
        );
      }
    });
  }

  void _editAddress(Address address) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Edit address feature coming soon!"),
        backgroundColor: Color(0xFF2196F3),
      ),
    );
  }

  void _deleteAddress(Address address) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.warning_rounded, color: Colors.red[600]),
              const SizedBox(width: 8),
              const Text("Delete Address"),
            ],
          ),
          content: Text(
            "Are you sure you want to delete ${address.title}? This action cannot be undone.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _addresses.removeWhere((addr) => addr.id == address.id);
                  // If deleted address was default, set first address as default
                  if (address.isDefault && _addresses.isNotEmpty) {
                    _addresses[0] = _addresses[0].copyWith(isDefault: true);
                  }
                });

                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("${address.title} deleted successfully"),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
