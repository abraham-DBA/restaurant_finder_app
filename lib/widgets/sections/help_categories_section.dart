import 'package:flutter/material.dart';

class HelpCategoriesSection extends StatelessWidget {
  final VoidCallback onFAQPressed;
  final VoidCallback onContactPressed;
  final VoidCallback onReportPressed;
  final VoidCallback onGuidePressed;

  const HelpCategoriesSection({
    super.key,
    required this.onFAQPressed,
    required this.onContactPressed,
    required this.onReportPressed,
    required this.onGuidePressed,
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
                  color: const Color(0xFF7E57C2).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.help_outline_rounded,
                  color: Color(0xFF7E57C2),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "How can we help you?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Help Categories Grid
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildHelpCategory(
                      icon: Icons.quiz_outlined,
                      title: "FAQs",
                      subtitle: "Common questions",
                      color: const Color(0xFF4CAF50),
                      onTap: onFAQPressed,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildHelpCategory(
                      icon: Icons.support_agent_outlined,
                      title: "Contact Us",
                      subtitle: "Get direct support",
                      color: const Color(0xFF2196F3),
                      onTap: onContactPressed,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _buildHelpCategory(
                      icon: Icons.report_problem_outlined,
                      title: "Report Issue",
                      subtitle: "Something wrong?",
                      color: const Color(0xFFFF5722),
                      onTap: onReportPressed,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildHelpCategory(
                      icon: Icons.menu_book_outlined,
                      title: "User Guide",
                      subtitle: "Learn how to use",
                      color: const Color(0xFF9C27B0),
                      onTap: onGuidePressed,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHelpCategory({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
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
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),

            const SizedBox(height: 12),

            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 4),

            Text(
              subtitle,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
