import 'package:flutter/material.dart';
import '../widgets/sections/order_header_section.dart';
import '../widgets/sections/order_tab_section.dart';
import '../widgets/sections/order_list_section.dart';
import '../models/order.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  int selectedTab = 0; // 0 for Ongoing, 1 for Past Orders

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            OrderHeaderSection(onBackPressed: () => Navigator.pop(context)),

            // Tab Selection Section
            OrderTabSection(
              selectedTab: selectedTab,
              onTabChanged: (index) {
                setState(() {
                  selectedTab = index;
                });
              },
            ),

            // Orders List Section
            Expanded(
              child: OrderListSection(
                selectedTab: selectedTab,
                ongoingOrders: _ongoingOrders,
                pastOrders: _pastOrders,
                onOrderTap: (order) => _viewOrderDetails(order, selectedTab),
                onTrackOrder: _trackOrder,
                onReorder: _reorder,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _viewOrderDetails(Order order, int currentTab) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildOrderDetailsSheet(order, currentTab),
    );
  }

  Widget _buildOrderDetailsSheet(Order order, int currentTab) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Order Details",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 20),
          _buildOrderDetailsCard(order),
          const SizedBox(height: 20),

          // Show different buttons based on tab
          if (currentTab == 0) ...[
            // Ongoing order actions
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _trackOrder(order);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6366F1),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Track Order",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.grey[600],
                      side: BorderSide(color: Colors.grey[400]!),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Close"),
                  ),
                ),
              ],
            ),
          ] else ...[
            // Past order actions
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _reorder(order);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4ECDC4),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Reorder",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.grey[600],
                      side: BorderSide(color: Colors.grey[400]!),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Close"),
                  ),
                ),
              ],
            ),
          ],

          SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 30),
        ],
      ),
    );
  }

  Widget _buildOrderDetailsCard(Order order) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailItem("Restaurant", order.restaurantName),
          const SizedBox(height: 12),
          _buildDetailItem("Order ID", order.orderId),
          const SizedBox(height: 12),
          _buildDetailItem("Order Time", order.orderTime),
          const SizedBox(height: 12),
          _buildDetailItem("Status", order.status),
          const SizedBox(height: 12),
          _buildDetailItem("Total Amount", order.totalPrice),
          if (order.eta != null) ...[
            const SizedBox(height: 12),
            _buildDetailItem("Estimated Delivery", order.eta!),
          ],
          if (order.deliveryAddress != null) ...[
            const SizedBox(height: 12),
            _buildDetailItem("Delivery Address", order.deliveryAddress!),
          ],

          // Order Items
          const SizedBox(height: 20),
          Text(
            "Order Items",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 12),
          ...order.items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${item.quantity}x ${item.name}",
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (item.specialInstructions != null &&
                            item.specialInstructions!.isNotEmpty) ...[
                          const SizedBox(height: 2),
                          Text(
                            "Note: ${item.specialInstructions}",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Text(
                    item.price,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600,
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

  Widget _buildDetailItem(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: TextStyle(
              color: Colors.grey[800],
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  void _trackOrder(Order order) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.location_on,
                  color: Color(0xFF6366F1),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  "Track Order",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Order: ${order.orderId}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Restaurant: ${order.restaurantName}",
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 8),
              Text(
                "Status: ${order.status}",
                style: TextStyle(color: Colors.grey[600]),
              ),
              if (order.eta != null) ...[
                const SizedBox(height: 8),
                Text(
                  "ETA: ${order.eta}",
                  style: TextStyle(
                    color: const Color(0xFF6366F1),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close", style: TextStyle(color: Colors.grey[600])),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Real-time tracking feature coming soon!"),
                    backgroundColor: Color(0xFF6366F1),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6366F1),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Live Track"),
            ),
          ],
        );
      },
    );
  }

  void _reorder(Order order) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF4ECDC4).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.refresh,
                  color: Color(0xFF4ECDC4),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "Reorder",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          content: Text(
            "Would you like to add all items from this order to your cart?",
            style: TextStyle(color: Colors.grey[600]),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: TextStyle(color: Colors.grey[600])),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "${order.items.length} items added to cart from ${order.restaurantName}",
                    ),
                    backgroundColor: const Color(0xFF4ECDC4),
                    duration: const Duration(seconds: 3),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4ECDC4),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Add to Cart"),
            ),
          ],
        );
      },
    );
  }

  // Sample data - In a real app, this would come from an API or database
  final List<Order> _ongoingOrders = [
    Order(
      id: "1",
      restaurantName: "The Gourmet Hub",
      orderId: "ORD-2025-001",
      orderTime: "Today, 4:40 PM",
      items: [
        OrderItem(
          name: "Chicken Biryani",
          quantity: 1,
          price: "UGX 35,000",
          specialInstructions: "Extra spicy",
        ),
        OrderItem(name: "Garlic Naan", quantity: 2, price: "UGX 8,000"),
        OrderItem(name: "Mango Lassi", quantity: 1, price: "UGX 5,000"),
      ],
      totalPrice: "UGX 48,000",
      status: "Preparing",
      eta: "25-30 minutes",
      deliveryAddress: "123 Main Street, Kampala",
    ),
    Order(
      id: "2",
      restaurantName: "Pizza Palace",
      orderId: "ORD-2025-002",
      orderTime: "Today, 3:15 PM",
      items: [
        OrderItem(
          name: "Margherita Pizza",
          quantity: 1,
          price: "UGX 28,000",
          specialInstructions: "Thin crust",
        ),
        OrderItem(name: "Garlic Bread", quantity: 1, price: "UGX 6,000"),
      ],
      totalPrice: "UGX 34,000",
      status: "On the way",
      eta: "10-15 minutes",
      deliveryAddress: "456 Oak Avenue, Kampala",
    ),
  ];

  final List<Order> _pastOrders = [
    Order(
      id: "3",
      restaurantName: "Burger Corner",
      orderId: "ORD-2025-003",
      orderTime: "Yesterday, 7:15 PM",
      items: [
        OrderItem(name: "Classic Burger", quantity: 2, price: "UGX 30,000"),
        OrderItem(name: "French Fries", quantity: 1, price: "UGX 8,000"),
        OrderItem(name: "Coca Cola", quantity: 2, price: "UGX 6,000"),
      ],
      totalPrice: "UGX 44,000",
      status: "Delivered",
      deliveryAddress: "789 Elm Street, Kampala",
    ),
    Order(
      id: "4",
      restaurantName: "Sushi Express",
      orderId: "ORD-2025-004",
      orderTime: "November 5, 2025, 12:30 PM",
      items: [
        OrderItem(name: "California Roll", quantity: 2, price: "UGX 25,000"),
        OrderItem(name: "Miso Soup", quantity: 1, price: "UGX 8,000"),
        OrderItem(name: "Green Tea", quantity: 1, price: "UGX 4,000"),
      ],
      totalPrice: "UGX 37,000",
      status: "Delivered",
      deliveryAddress: "321 Pine Road, Kampala",
    ),
    Order(
      id: "5",
      restaurantName: "Italian Bistro",
      orderId: "ORD-2025-005",
      orderTime: "November 3, 2025, 6:45 PM",
      items: [
        OrderItem(
          name: "Spaghetti Carbonara",
          quantity: 1,
          price: "UGX 32,000",
          specialInstructions: "No bacon",
        ),
        OrderItem(name: "Caesar Salad", quantity: 1, price: "UGX 15,000"),
      ],
      totalPrice: "UGX 47,000",
      status: "Cancelled",
      deliveryAddress: "654 Maple Drive, Kampala",
    ),
  ];
}
