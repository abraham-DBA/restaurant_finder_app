import 'package:flutter/material.dart';

class EditProfilePhotoSection extends StatelessWidget {
  final VoidCallback onChangePhoto;
  final VoidCallback onRemovePhoto;
  final String? profileImageUrl;

  const EditProfilePhotoSection({
    super.key,
    required this.onChangePhoto,
    required this.onRemovePhoto,
    this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
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
          // Profile Photo
          Stack(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[100],
                  border: Border.all(
                    color: const Color(0xFF6366F1).withValues(alpha: 0.2),
                    width: 3,
                  ),
                ),
                child: profileImageUrl != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Image.network(
                          profileImageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              _buildAvatarPlaceholder(),
                        ),
                      )
                    : _buildAvatarPlaceholder(),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6366F1),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: IconButton(
                    onPressed: onChangePhoto,
                    icon: const Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onChangePhoto,
                  icon: const Icon(Icons.photo_camera_rounded, size: 18),
                  label: const Text("Change Photo"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF6366F1),
                    side: const BorderSide(color: Color(0xFF6366F1)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onRemovePhoto,
                  icon: const Icon(Icons.delete_outline_rounded, size: 18),
                  label: const Text("Remove"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red[600],
                    side: BorderSide(color: Colors.red[300]!),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarPlaceholder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_rounded,
            size: 50,
            color: const Color(0xFF6366F1).withValues(alpha: 0.6),
          ),
          const SizedBox(height: 4),
          Text(
            "Add Photo",
            style: TextStyle(
              fontSize: 12,
              color: const Color(0xFF6366F1).withValues(alpha: 0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
