import 'package:flutter/material.dart';

class UserProfile {
  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  final String? address;
  final String? bio;
  final String? profileImageUrl;
  final String gender;
  final DateTime? birthDate;
  final String membershipType;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.address,
    this.bio,
    this.profileImageUrl,
    this.gender = 'Not specified',
    this.birthDate,
    this.membershipType = 'Standard',
    required this.createdAt,
    required this.updatedAt,
  });

  // Calculate age from birth date
  int? get age {
    if (birthDate == null) return null;
    final now = DateTime.now();
    int age = now.year - birthDate!.year;
    if (now.month < birthDate!.month ||
        (now.month == birthDate!.month && now.day < birthDate!.day)) {
      age--;
    }
    return age;
  }

  // Get formatted birth date
  String get formattedBirthDate {
    if (birthDate == null) return 'Not specified';
    return '${birthDate!.day}/${birthDate!.month}/${birthDate!.year}';
  }

  // Get membership color
  Color get membershipColor {
    switch (membershipType.toLowerCase()) {
      case 'gold':
        return const Color(0xFFFFD700);
      case 'silver':
        return const Color(0xFFC0C0C0);
      case 'platinum':
        return const Color(0xFFE5E4E2);
      case 'premium':
        return const Color(0xFF6366F1);
      default:
        return const Color(0xFF9E9E9E);
    }
  }

  // Copy method for modifications
  UserProfile copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? address,
    String? bio,
    String? profileImageUrl,
    String? gender,
    DateTime? birthDate,
    String? membershipType,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      bio: bio ?? this.bio,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      membershipType: membershipType ?? this.membershipType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'bio': bio,
      'profileImageUrl': profileImageUrl,
      'gender': gender,
      'birthDate': birthDate?.toIso8601String(),
      'membershipType': membershipType,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Create from JSON
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      address: json['address'] as String?,
      bio: json['bio'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      gender: json['gender'] as String? ?? 'Not specified',
      birthDate: json['birthDate'] != null
          ? DateTime.parse(json['birthDate'] as String)
          : null,
      membershipType: json['membershipType'] as String? ?? 'Standard',
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  @override
  String toString() {
    return 'UserProfile(id: $id, name: $name, email: $email, membershipType: $membershipType)';
  }
}
