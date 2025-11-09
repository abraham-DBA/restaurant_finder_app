import 'package:flutter/material.dart';

class Booking {
  final String id;
  final String restaurantName;
  final String date;
  final String time;
  final int guests;
  final String status;
  final String? tableType;
  final String? specialRequests;
  final String? phoneNumber;
  final String? customerName;

  const Booking({
    required this.id,
    required this.restaurantName,
    required this.date,
    required this.time,
    required this.guests,
    required this.status,
    this.tableType,
    this.specialRequests,
    this.phoneNumber,
    this.customerName,
  });

  // Helper method to get status color
  static getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return const Color(0xFF4ECDC4);
      case 'pending':
        return const Color(0xFFFFA726);
      case 'completed':
        return const Color(0xFF6366F1);
      case 'cancelled':
        return const Color(0xFFFF6B6B);
      default:
        return const Color(0xFF9E9E9E);
    }
  }

  // Copy method for modifications
  Booking copyWith({
    String? id,
    String? restaurantName,
    String? date,
    String? time,
    int? guests,
    String? status,
    String? tableType,
    String? specialRequests,
    String? phoneNumber,
    String? customerName,
  }) {
    return Booking(
      id: id ?? this.id,
      restaurantName: restaurantName ?? this.restaurantName,
      date: date ?? this.date,
      time: time ?? this.time,
      guests: guests ?? this.guests,
      status: status ?? this.status,
      tableType: tableType ?? this.tableType,
      specialRequests: specialRequests ?? this.specialRequests,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      customerName: customerName ?? this.customerName,
    );
  }
}
