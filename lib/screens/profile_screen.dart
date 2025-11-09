import 'package:flutter/material.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_card.dart';
import '../widgets/sections/profile_menu_section.dart';
import 'my_bookings_screen.dart';
import 'my_orders_screen.dart';
import 'edit_profile_screen.dart';
import 'payment_methods_screen.dart';
import 'addresses_screen.dart';
import 'help_support_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 🔹 Modern Header with Back Button
              ProfileHeader(
                onEditPressed: () {
                  // Handle edit profile
                },
              ),
              const SizedBox(height: 24),

              // 🔹 Enhanced Profile Section
              ProfileCard(
                name: "Alice Johnson",
                email: "myrestaurant@gmail.com",
                membershipType: "Gold Member",
                onCameraPressed: () {
                  // Handle camera action
                },
              ),
              const SizedBox(height: 32),

              // 🔹 Modern Menu Options
              ProfileMenuSection(
                menuItems: _getMenuItems(context),
                onLogoutPressed: () {
                  // Handle logout logic
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  List<ProfileMenuData> _getMenuItems(BuildContext context) {
    return [
      ProfileMenuData(
        icon: Icons.person_outline_rounded,
        title: "Edit Profile",
        subtitle: "Update your personal information",
        color: const Color(0xFF6366F1),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EditProfileScreen()),
          );
        },
      ),
      ProfileMenuData(
        icon: Icons.payment_rounded,
        title: "Payment Methods",
        subtitle: "Manage your payment options",
        color: const Color(0xFF4ECDC4),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PaymentMethodsScreen(),
            ),
          );
        },
      ),
      ProfileMenuData(
        icon: Icons.receipt_long_rounded,
        title: "Order History",
        subtitle: "View your past orders",
        color: const Color(0xFFFF6B6B),
        badge: "12",
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyOrdersScreen()),
          );
        },
      ),
      ProfileMenuData(
        icon: Icons.calendar_today_rounded,
        title: "Bookings",
        subtitle: "Your table reservations",
        color: const Color(0xFF45B7D1),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyBookingsScreen()),
          );
        },
      ),
      ProfileMenuData(
        icon: Icons.location_on_rounded,
        title: "Addresses",
        subtitle: "Manage delivery locations",
        color: const Color(0xFF96CEB4),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddressesScreen()),
          );
        },
      ),
      ProfileMenuData(
        icon: Icons.help_outline_rounded,
        title: "Help & Support",
        subtitle: "Get help with your account",
        color: const Color(0xFF7E57C2),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HelpSupportScreen()),
          );
        },
      ),
      const ProfileMenuData(
        icon: Icons.logout_rounded,
        title: "Log Out",
        subtitle: "Sign out of your account",
        color: Colors.red,
        isLogout: true,
      ),
    ];
  }
}
