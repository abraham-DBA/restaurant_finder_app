import 'package:flutter/material.dart';

class FAQSection extends StatelessWidget {
  final bool isLoading;

  const FAQSection({super.key, required this.isLoading});

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
                  color: const Color(0xFF4CAF50).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.quiz_outlined,
                  color: Color(0xFF4CAF50),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "Popular Questions",
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
              child: CircularProgressIndicator(color: Color(0xFF4CAF50)),
            )
          else
            Column(
              children: _getTopFAQs()
                  .map(
                    (faq) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _buildFAQPreview(faq['question']!, faq['answer']!),
                    ),
                  )
                  .toList(),
            ),

          const SizedBox(height: 16),

          // View All FAQs Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                // This would navigate to full FAQ screen
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Opening full FAQ list..."),
                    backgroundColor: Color(0xFF4CAF50),
                  ),
                );
              },
              icon: const Icon(Icons.list_alt, size: 18),
              label: const Text("View All FAQs"),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF4CAF50),
                side: const BorderSide(color: Color(0xFF4CAF50)),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQPreview(String question, String answer) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        title: Text(
          question,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              answer,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, String>> _getTopFAQs() {
    return [
      {
        'question': 'How do I place an order?',
        'answer':
            'Browse restaurants, select items, add to cart, choose delivery address, and confirm your order.',
      },
      {
        'question': 'What payment methods do you accept?',
        'answer':
            'We accept credit/debit cards, mobile money (MTN, Airtel, Orange), and bank transfers.',
      },
      {
        'question': 'How long does delivery take?',
        'answer':
            'Delivery typically takes 30-45 minutes depending on your location and restaurant preparation time.',
      },
      {
        'question': 'Can I cancel my order?',
        'answer':
            'You can cancel your order within 5 minutes of placing it. After that, please contact support.',
      },
    ];
  }
}
