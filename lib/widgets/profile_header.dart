import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final VoidCallback? onEditPressed;

  const ProfileHeader({
    super.key,
    this.title = "Profile",
    this.onBackPressed,
    this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Back Button
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            onPressed: onBackPressed ?? () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18,
              color: Colors.grey[700],
            ),
            padding: EdgeInsets.zero,
          ),
        ),
        const SizedBox(width: 16),
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.grey[800],
          ),
        ),
        const Spacer(),
        // Edit Icon
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            onPressed: onEditPressed,
            icon: Icon(Icons.edit_rounded, size: 20, color: Colors.grey[700]),
            padding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }
}
