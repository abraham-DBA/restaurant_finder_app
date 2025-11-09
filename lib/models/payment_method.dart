import 'package:flutter/material.dart';

class PaymentMethod {
  final String id;
  final String type; // 'card', 'mobile_money', 'bank'
  final String name;
  final String
  details; // Last 4 digits for card, phone number for mobile money, etc.
  final String? cardBrand; // visa, mastercard, amex
  final String? expiryDate;
  final bool isDefault;
  final DateTime createdAt;
  final DateTime updatedAt;

  const PaymentMethod({
    required this.id,
    required this.type,
    required this.name,
    required this.details,
    this.cardBrand,
    this.expiryDate,
    this.isDefault = false,
    required this.createdAt,
    required this.updatedAt,
  });

  // Get payment method icon
  IconData get icon {
    switch (type.toLowerCase()) {
      case 'card':
        return Icons.credit_card;
      case 'mobile_money':
        return Icons.phone_android;
      case 'bank':
        return Icons.account_balance;
      default:
        return Icons.payment;
    }
  }

  // Get payment method color
  Color get color {
    switch (type.toLowerCase()) {
      case 'card':
        return const Color(0xFF6366F1);
      case 'mobile_money':
        return const Color(0xFF4ECDC4);
      case 'bank':
        return const Color(0xFF45B7D1);
      default:
        return const Color(0xFF9E9E9E);
    }
  }

  // Get card brand color
  Color get cardBrandColor {
    switch (cardBrand?.toLowerCase()) {
      case 'visa':
        return const Color(0xFF1A1F71);
      case 'mastercard':
        return const Color(0xFFEB001B);
      case 'amex':
        return const Color(0xFF006FCF);
      case 'discover':
        return const Color(0xFFFF6000);
      default:
        return const Color(0xFF6366F1);
    }
  }

  // Get formatted details
  String get formattedDetails {
    switch (type.toLowerCase()) {
      case 'card':
        return "**** **** **** $details";
      case 'mobile_money':
        return details;
      case 'bank':
        return "****$details";
      default:
        return details;
    }
  }

  // Copy with method
  PaymentMethod copyWith({
    String? id,
    String? type,
    String? name,
    String? details,
    String? cardBrand,
    String? expiryDate,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PaymentMethod(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      details: details ?? this.details,
      cardBrand: cardBrand ?? this.cardBrand,
      expiryDate: expiryDate ?? this.expiryDate,
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
      'name': name,
      'details': details,
      'cardBrand': cardBrand,
      'expiryDate': expiryDate,
      'isDefault': isDefault,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Create from JSON
  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      id: json['id'] as String,
      type: json['type'] as String,
      name: json['name'] as String,
      details: json['details'] as String,
      cardBrand: json['cardBrand'] as String?,
      expiryDate: json['expiryDate'] as String?,
      isDefault: json['isDefault'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  @override
  String toString() {
    return 'PaymentMethod(id: $id, type: $type, name: $name, isDefault: $isDefault)';
  }
}
