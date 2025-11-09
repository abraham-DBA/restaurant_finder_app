import 'package:flutter/material.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final String? badge;
  final bool isLogout;
  final VoidCallback? onTap;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    this.badge,
    this.isLogout = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: isLogout ? Colors.red : Colors.grey[800],
          fontSize: 15,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: isLogout
              ? Colors.red.withValues(alpha: 0.7)
              : Colors.grey[600],
          fontSize: 12,
        ),
      ),
      trailing: badge != null
          ? Badge(
              backgroundColor: color,
              label: Text(
                badge!,
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
              child: Icon(
                Icons.chevron_right_rounded,
                color: isLogout ? Colors.red : Colors.grey[400],
              ),
            )
          : Icon(
              Icons.chevron_right_rounded,
              color: isLogout ? Colors.red : Colors.grey[400],
            ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}
