import 'package:flutter/material.dart';

class Address {
  final String id;
  final String type; // 'home', 'work', 'other'
  final String title;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final double? latitude;
  final double? longitude;
  final String? instructions; // Delivery instructions
  final bool isDefault;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Address({
    required this.id,
    required this.type,
    required this.title,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.latitude,
    this.longitude,
    this.instructions,
    this.isDefault = false,
    required this.createdAt,
    required this.updatedAt,
  });

  // Get address type icon
  IconData get icon {
    switch (type.toLowerCase()) {
      case 'home':
        return Icons.home_outlined;
      case 'work':
        return Icons.business_outlined;
      case 'other':
        return Icons.location_on_outlined;
      default:
        return Icons.place_outlined;
    }
  }

  // Get address type color
  Color get color {
    switch (type.toLowerCase()) {
      case 'home':
        return const Color(0xFF4CAF50);
      case 'work':
        return const Color(0xFF2196F3);
      case 'other':
        return const Color(0xFF9C27B0);
      default:
        return const Color(0xFF757575);
    }
  }

  // Get formatted full address
  String get fullAddress {
    final parts = <String>[];

    if (street.isNotEmpty) parts.add(street);
    if (city.isNotEmpty) parts.add(city);
    if (state.isNotEmpty) parts.add(state);
    if (postalCode.isNotEmpty) parts.add(postalCode);
    if (country.isNotEmpty) parts.add(country);

    return parts.join(', ');
  }

  // Get short address (street and city)
  String get shortAddress {
    final parts = <String>[];

    if (street.isNotEmpty) parts.add(street);
    if (city.isNotEmpty) parts.add(city);

    return parts.join(', ');
  }

  // Get formatted address for display
  String get displayAddress {
    return shortAddress.length > 40
        ? '${shortAddress.substring(0, 40)}...'
        : shortAddress;
  }

  // Validate address completeness
  bool get isComplete {
    return title.isNotEmpty &&
        street.isNotEmpty &&
        city.isNotEmpty &&
        state.isNotEmpty &&
        postalCode.isNotEmpty &&
        country.isNotEmpty;
  }

  // Check if address has GPS coordinates
  bool get hasCoordinates {
    return latitude != null && longitude != null;
  }

  // Get distance text (placeholder - would need actual distance calculation)
  String getDistanceText(double? userLat, double? userLng) {
    if (!hasCoordinates || userLat == null || userLng == null) {
      return '';
    }
    // In a real app, you'd calculate the distance here
    return '2.5 km away';
  }

  // Copy with method
  Address copyWith({
    String? id,
    String? type,
    String? title,
    String? street,
    String? city,
    String? state,
    String? postalCode,
    String? country,
    double? latitude,
    double? longitude,
    String? instructions,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Address(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      instructions: instructions ?? this.instructions,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'street': street,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
      'instructions': instructions,
      'isDefault': isDefault,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Create from JSON
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'] as String,
      type: json['type'] as String,
      title: json['title'] as String,
      street: json['street'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      postalCode: json['postalCode'] as String,
      country: json['country'] as String,
      latitude: json['latitude'] as double?,
      longitude: json['longitude'] as double?,
      instructions: json['instructions'] as String?,
      isDefault: json['isDefault'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  // Create sample addresses for testing
  static List<Address> getSampleAddresses() {
    final now = DateTime.now();
    return [
      Address(
        id: "1",
        type: "home",
        title: "My Home",
        street: "123 Main Street, Apt 4B",
        city: "Kampala",
        state: "Central Region",
        postalCode: "12345",
        country: "Uganda",
        latitude: 0.3476,
        longitude: 32.5825,
        instructions: "Blue gate, ring the bell twice",
        isDefault: true,
        createdAt: now.subtract(const Duration(days: 30)),
        updatedAt: now.subtract(const Duration(days: 30)),
      ),
      Address(
        id: "2",
        type: "work",
        title: "Office",
        street: "456 Business District",
        city: "Kampala",
        state: "Central Region",
        postalCode: "54321",
        country: "Uganda",
        latitude: 0.3136,
        longitude: 32.5811,
        instructions: "Reception on 5th floor",
        isDefault: false,
        createdAt: now.subtract(const Duration(days: 15)),
        updatedAt: now.subtract(const Duration(days: 15)),
      ),
      Address(
        id: "3",
        type: "other",
        title: "Mom's House",
        street: "789 Residential Avenue",
        city: "Entebbe",
        state: "Central Region",
        postalCode: "67890",
        country: "Uganda",
        latitude: 0.0558,
        longitude: 32.4635,
        instructions: "Ask for Mrs. Johnson",
        isDefault: false,
        createdAt: now.subtract(const Duration(days: 7)),
        updatedAt: now.subtract(const Duration(days: 7)),
      ),
    ];
  }

  @override
  String toString() {
    return 'Address(id: $id, type: $type, title: $title, isDefault: $isDefault)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Address && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
