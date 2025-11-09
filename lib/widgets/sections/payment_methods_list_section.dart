import 'package:flutter/material.dart';
import '../../models/payment_method.dart';

class PaymentMethodsListSection extends StatelessWidget {
  final List<PaymentMethod> paymentMethods;
  final bool isLoading;
  final Function(PaymentMethod) onSetDefault;
  final Function(PaymentMethod) onEdit;
  final Function(PaymentMethod) onDelete;

  const PaymentMethodsListSection({
    super.key,
    required this.paymentMethods,
    required this.isLoading,
    required this.onSetDefault,
    required this.onEdit,
    required this.onDelete,
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
                  Icons.payment,
                  color: Color(0xFF6366F1),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "Your Payment Methods",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          if (isLoading)
            const Center(
              child: CircularProgressIndicator(color: Color(0xFF6366F1)),
            )
          else if (paymentMethods.isEmpty)
            _buildEmptyState()
          else
            Column(
              children: paymentMethods
                  .map(
                    (method) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildPaymentMethodCard(method),
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(40),
            ),
            child: Icon(
              Icons.credit_card_off,
              color: Colors.grey[400],
              size: 48,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "No Payment Methods",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Add a payment method to start ordering",
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard(PaymentMethod method) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: method.isDefault
            ? const Color(0xFF6366F1).withValues(alpha: 0.05)
            : Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: method.isDefault
              ? const Color(0xFF6366F1).withValues(alpha: 0.3)
              : Colors.grey[200]!,
        ),
      ),
      child: Row(
        children: [
          // Payment Method Icon
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: method.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(method.icon, color: method.color, size: 20),
          ),

          const SizedBox(width: 16),

          // Payment Method Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      method.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                    if (method.isDefault) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6366F1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          "Default",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  method.formattedDetails,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                if (method.type == 'card' && method.expiryDate != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    "Expires ${method.expiryDate}",
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(width: 12),

          // Action Button
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.grey[600]),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            itemBuilder: (BuildContext context) => [
              if (!method.isDefault)
                PopupMenuItem<String>(
                  value: 'default',
                  child: Row(
                    children: [
                      Icon(
                        Icons.star_outline,
                        size: 18,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 8),
                      const Text('Set as Default'),
                    ],
                  ),
                ),
              PopupMenuItem<String>(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(
                      Icons.edit_outlined,
                      size: 18,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 8),
                    const Text('Edit'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(
                      Icons.delete_outline,
                      size: 18,
                      color: Colors.red[600],
                    ),
                    const SizedBox(width: 8),
                    Text('Delete', style: TextStyle(color: Colors.red[600])),
                  ],
                ),
              ),
            ],
            onSelected: (String value) {
              switch (value) {
                case 'default':
                  onSetDefault(method);
                  break;
                case 'edit':
                  onEdit(method);
                  break;
                case 'delete':
                  onDelete(method);
                  break;
              }
            },
          ),
        ],
      ),
    );
  }
}
