import 'package:flutter/material.dart';

class AddPaymentMethodSection extends StatelessWidget {
  final VoidCallback onAddCard;
  final VoidCallback onAddMobileMoney;
  final VoidCallback onAddBankAccount;

  const AddPaymentMethodSection({
    super.key,
    required this.onAddCard,
    required this.onAddMobileMoney,
    required this.onAddBankAccount,
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
                  color: const Color(0xFF6366F1).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.add_circle_outline,
                  color: Color(0xFF6366F1),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "Add Payment Method",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Payment Method Options
          Column(
            children: [
              _buildPaymentOption(
                icon: Icons.credit_card,
                title: "Credit/Debit Card",
                subtitle: "Add Visa, Mastercard, or American Express",
                color: const Color(0xFF6366F1),
                onTap: onAddCard,
              ),

              const SizedBox(height: 12),

              _buildPaymentOption(
                icon: Icons.phone_android,
                title: "Mobile Money",
                subtitle: "Add MTN, Airtel, or Orange Money",
                color: const Color(0xFF4ECDC4),
                onTap: onAddMobileMoney,
              ),

              const SizedBox(height: 12),

              _buildPaymentOption(
                icon: Icons.account_balance,
                title: "Bank Account",
                subtitle: "Link your bank account directly",
                color: const Color(0xFF45B7D1),
                onTap: onAddBankAccount,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption({
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
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
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
              child: Icon(Icons.add, color: color, size: 16),
            ),
          ],
        ),
      ),
    );
  }
}
