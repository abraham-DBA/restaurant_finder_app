import 'package:flutter/material.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_card.dart';
import '../widgets/sections/profile_menu_section.dart';

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
                menuItems: _getMenuItems(),
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

  List<ProfileMenuData> _getMenuItems() {
    return [
      ProfileMenuData(
        icon: Icons.person_outline_rounded,
        title: "Edit Profile",
        subtitle: "Update your personal information",
        color: const Color(0xFF6366F1),
        onTap: () {
          // Handle edit profile navigation
        },
      ),
      ProfileMenuData(
        icon: Icons.payment_rounded,
        title: "Payment Methods",
        subtitle: "Manage your payment options",
        color: const Color(0xFF4ECDC4),
        onTap: () {
          // Handle payment methods navigation
        },
      ),
      ProfileMenuData(
        icon: Icons.receipt_long_rounded,
        title: "Order History",
        subtitle: "View your past orders",
        color: const Color(0xFFFF6B6B),
        badge: "12",
        onTap: () {
          // Handle order history navigation
        },
      ),
      ProfileMenuData(
        icon: Icons.calendar_today_rounded,
        title: "Bookings",
        subtitle: "Your table reservations",
        color: const Color(0xFF45B7D1),
        onTap: () {
          // Handle bookings navigation
        },
      ),
      ProfileMenuData(
        icon: Icons.location_on_rounded,
        title: "Addresses",
        subtitle: "Manage delivery locations",
        color: const Color(0xFF96CEB4),
        onTap: () {
          // Handle addresses navigation
        },
      ),
      ProfileMenuData(
        icon: Icons.notifications_rounded,
        title: "Notifications",
        subtitle: "Manage your alerts",
        color: const Color(0xFFFFA726),
        onTap: () {
          // Handle notifications navigation
        },
      ),
      ProfileMenuData(
        icon: Icons.help_outline_rounded,
        title: "Help & Support",
        subtitle: "Get help with your account",
        color: const Color(0xFF7E57C2),
        onTap: () {
          // Handle help navigation
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
