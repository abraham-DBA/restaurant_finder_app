import 'package:flutter/material.dart';

class EditProfileHeaderSection extends StatelessWidget {
  final VoidCallback onBackPressed;
  final VoidCallback onSavePressed;
  final bool isLoading;

  const EditProfileHeaderSection({
    super.key,
    required this.onBackPressed,
    required this.onSavePressed,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Back Button
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: onBackPressed,
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: Colors.grey[700],
              ),
              padding: EdgeInsets.zero,
            ),
          ),
          const SizedBox(width: 16),
          // Title
          Expanded(
            child: Text(
              "Edit Profile",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.grey[800],
              ),
            ),
          ),
          // Save Button
          SizedBox(
            height: 44,
            child: ElevatedButton(
              onPressed: isLoading ? null : onSavePressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6366F1),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text(
                      "Save",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
