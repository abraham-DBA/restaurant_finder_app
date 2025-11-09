import 'package:flutter/material.dart';
import '../profile_menu_item.dart';

class ProfileMenuData {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final String? badge;
  final bool isLogout;
  final VoidCallback? onTap;

  const ProfileMenuData({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    this.badge,
    this.isLogout = false,
    this.onTap,
  });
}

class ProfileMenuSection extends StatelessWidget {
  final List<ProfileMenuData> menuItems;
  final VoidCallback? onLogoutPressed;

  const ProfileMenuSection({
    super.key,
    required this.menuItems,
    this.onLogoutPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          ...menuItems.map((item) {
            final isLastNonLogout =
                !item.isLogout &&
                menuItems.indexOf(item) ==
                    menuItems.where((m) => !m.isLogout).length - 1;

            return Column(
              children: [
                ProfileMenuItem(
                  icon: item.icon,
                  title: item.title,
                  subtitle: item.subtitle,
                  color: item.color,
                  badge: item.badge,
                  isLogout: item.isLogout,
                  onTap: item.isLogout
                      ? () => _showLogoutDialog(context)
                      : item.onTap,
                ),
                if (isLastNonLogout)
                  const Divider(
                    height: 1,
                    thickness: 1,
                    indent: 16,
                    endIndent: 16,
                  ),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            "Log Out",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.grey[800],
            ),
          ),
          content: Text(
            "Are you sure you want to log out of your account?",
            style: TextStyle(color: Colors.grey[600]),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: TextStyle(color: Colors.grey[600])),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onLogoutPressed?.call();
              },
              child: const Text("Log Out", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
