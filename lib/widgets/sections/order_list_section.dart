import 'package:flutter/material.dart';
import '../../models/order.dart';
import '../order_card.dart';

class OrderListSection extends StatelessWidget {
  final int selectedTab;
  final List<Order> ongoingOrders;
  final List<Order> pastOrders;
  final Function(Order) onOrderTap;
  final Function(Order) onTrackOrder;
  final Function(Order) onReorder;

  const OrderListSection({
    super.key,
    required this.selectedTab,
    required this.ongoingOrders,
    required this.pastOrders,
    required this.onOrderTap,
    required this.onTrackOrder,
    required this.onReorder,
  });

  @override
  Widget build(BuildContext context) {
    final orders = selectedTab == 0 ? ongoingOrders : pastOrders;

    if (orders.isEmpty) {
      return _buildEmptyState(context);
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return OrderCard(
          order: orders[index],
          isOngoing: selectedTab == 0,
          onViewDetails: () => onOrderTap(orders[index]),
          onTrackOrder: () => onTrackOrder(orders[index]),
          onReorder: () => onReorder(orders[index]),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(60),
            ),
            child: Icon(
              selectedTab == 0
                  ? Icons.shopping_bag_outlined
                  : Icons.history_rounded,
              size: 60,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            selectedTab == 0 ? "No Ongoing Orders" : "No Past Orders",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            selectedTab == 0
                ? "Your active orders will appear here"
                : "Your order history will appear here",
            style: TextStyle(fontSize: 16, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
          if (selectedTab == 0) ...[
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                // Navigate to restaurants to place an order
                Navigator.of(context).pop(); // Go back to main screen
              },
              icon: const Icon(Icons.restaurant_menu_rounded, size: 20),
              label: const Text(
                "Browse Restaurants",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6366F1),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
