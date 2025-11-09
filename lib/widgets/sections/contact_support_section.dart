import 'package:flutter/material.dart';

class ContactSupportSection extends StatelessWidget {
  final VoidCallback onEmailPressed;
  final VoidCallback onPhonePressed;
  final VoidCallback onChatPressed;

  const ContactSupportSection({
    super.key,
    required this.onEmailPressed,
    required this.onPhonePressed,
    required this.onChatPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 2),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF2196F3).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.contact_support_outlined,
                  color: Color(0xFF2196F3),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "Quick Contact",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Contact Options
          Column(
            children: [
              _buildContactOption(
                icon: Icons.email_outlined,
                title: "Email Support",
                subtitle: "support@restaurantfinder.com",
                status: "Response in 24 hours",
                color: const Color(0xFF4CAF50),
                onTap: onEmailPressed,
              ),

              const SizedBox(height: 12),

              _buildContactOption(
                icon: Icons.phone_outlined,
                title: "Phone Support",
                subtitle: "+256 700 123 456",
                status: "Mon-Sat, 9 AM - 9 PM",
                color: const Color(0xFF2196F3),
                onTap: onPhonePressed,
              ),

              const SizedBox(height: 12),

              _buildContactOption(
                icon: Icons.chat_bubble_outline,
                title: "Live Chat",
                subtitle: "Chat with our support team",
                status: "Available now",
                color: const Color(0xFF9C27B0),
                onTap: onChatPressed,
                isLive: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required String status,
    required Color color,
    required VoidCallback onTap,
    bool isLive = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 20),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                      if (isLive) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4CAF50),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            "LIVE",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(Icons.arrow_forward_ios, color: color, size: 14),
            ),
          ],
        ),
      ),
    );
  }
}
