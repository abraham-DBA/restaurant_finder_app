import 'package:flutter/material.dart';

class Order {
  final String id;
  final String restaurantName;
  final String orderId;
  final String orderTime;
  final List<OrderItem> items;
  final String totalPrice;
  final String status;
  final String? eta;
  final String? deliveryAddress;
  final String? phoneNumber;

  const Order({
    required this.id,
    required this.restaurantName,
    required this.orderId,
    required this.orderTime,
    required this.items,
    required this.totalPrice,
    required this.status,
    this.eta,
    this.deliveryAddress,
    this.phoneNumber,
  });

  // Helper method to get status color
  static getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'processing':
        return const Color(0xFFFFA726);
      case 'preparing':
        return const Color(0xFF45B7D1);
      case 'on the way':
        return const Color(0xFF6366F1);
      case 'delivered':
        return const Color(0xFF4ECDC4);
      case 'cancelled':
        return const Color(0xFFFF6B6B);
      case 'ready for pickup':
        return const Color(0xFF9C27B0);
      default:
        return const Color(0xFF9E9E9E);
    }
  }

  // Copy method for modifications
  Order copyWith({
    String? id,
    String? restaurantName,
    String? orderId,
    String? orderTime,
    List<OrderItem>? items,
    String? totalPrice,
    String? status,
    String? eta,
    String? deliveryAddress,
    String? phoneNumber,
  }) {
    return Order(
      id: id ?? this.id,
      restaurantName: restaurantName ?? this.restaurantName,
      orderId: orderId ?? this.orderId,
      orderTime: orderTime ?? this.orderTime,
      items: items ?? this.items,
      totalPrice: totalPrice ?? this.totalPrice,
      status: status ?? this.status,
      eta: eta ?? this.eta,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}

class OrderItem {
  final String name;
  final int quantity;
  final String price;
  final String? specialInstructions;

  const OrderItem({
    required this.name,
    required this.quantity,
    required this.price,
    this.specialInstructions,
  });

  // Copy method for modifications
  OrderItem copyWith({
    String? name,
    int? quantity,
    String? price,
    String? specialInstructions,
  }) {
    return OrderItem(
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      specialInstructions: specialInstructions ?? this.specialInstructions,
    );
  }
}
