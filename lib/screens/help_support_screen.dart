import 'package:flutter/material.dart';
import '../widgets/sections/help_header_section.dart';
import '../widgets/sections/help_categories_section.dart';
import '../widgets/sections/contact_support_section.dart';
import '../widgets/sections/faq_section.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            HelpHeaderSection(onBackPressed: () => Navigator.pop(context)),

            // Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // Help Categories Section
                    HelpCategoriesSection(
                      onFAQPressed: _showFAQSection,
                      onContactPressed: _showContactOptions,
                      onReportPressed: _showReportIssue,
                      onGuidePressed: _showUserGuide,
                    ),

                    const SizedBox(height: 24),

                    // Quick Contact Section
                    ContactSupportSection(
                      onEmailPressed: _contactViaEmail,
                      onPhonePressed: _contactViaPhone,
                      onChatPressed: _startLiveChat,
                    ),

                    const SizedBox(height: 24),

                    // FAQ Section
                    FAQSection(isLoading: _isLoading),

                    const SizedBox(height: 32),

                    // App Info Section
                    _buildAppInfoSection(),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppInfoSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF7E57C2).withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF7E57C2).withValues(alpha: 0.2),
        ),
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
                  Icons.info_outline,
                  color: Color(0xFF7E57C2),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "App Information",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoRow("Version", "2.1.0"),
          const SizedBox(height: 8),
          _buildInfoRow("Build", "124"),
          const SizedBox(height: 8),
          _buildInfoRow("Developer", "Restaurant Finder Team"),
          const SizedBox(height: 8),
          _buildInfoRow("Last Updated", "November 2025"),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _showPrivacyPolicy,
                  icon: const Icon(Icons.privacy_tip_outlined, size: 16),
                  label: const Text("Privacy Policy"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF7E57C2),
                    side: const BorderSide(color: Color(0xFF7E57C2)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _showTermsOfService,
                  icon: const Icon(Icons.description_outlined, size: 16),
                  label: const Text("Terms"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF7E57C2),
                    side: const BorderSide(color: Color(0xFF7E57C2)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }

  void _showFAQSection() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _buildFAQScreen()),
    );
  }

  Widget _buildFAQScreen() {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Frequently Asked Questions'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey[800],
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: _getFAQItems()
              .map(
                (faq) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildFAQCard(faq['question']!, faq['answer']!),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildFAQCard(String question, String answer) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
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

  List<Map<String, String>> _getFAQItems() {
    return [
      {
        'question': 'How do I place an order?',
        'answer':
            'Browse restaurants, select items, add to cart, choose delivery address, select payment method, and confirm your order.',
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
      {
        'question': 'How do I make a table reservation?',
        'answer':
            'Go to the restaurant page, tap "Book Table", select date, time, and party size, then confirm your booking.',
      },
      {
        'question': 'What if my order is late or incorrect?',
        'answer':
            'Contact our support team immediately. We\'ll work with the restaurant to resolve the issue and may offer compensation.',
      },
      {
        'question': 'How do I update my profile information?',
        'answer':
            'Go to Profile > Edit Profile to update your name, email, phone number, and profile picture.',
      },
      {
        'question': 'Can I save multiple delivery addresses?',
        'answer':
            'Yes! Go to Profile > Addresses to add and manage multiple delivery locations.',
      },
    ];
  }

  void _showContactOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Contact Support",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 24),
            _buildContactOption(
              icon: Icons.email_outlined,
              title: "Email Support",
              subtitle: "support@restaurantfinder.com",
              color: const Color(0xFF4CAF50),
              onTap: _contactViaEmail,
            ),
            const SizedBox(height: 16),
            _buildContactOption(
              icon: Icons.phone_outlined,
              title: "Phone Support",
              subtitle: "+256 700 123 456",
              color: const Color(0xFF2196F3),
              onTap: _contactViaPhone,
            ),
            const SizedBox(height: 16),
            _buildContactOption(
              icon: Icons.chat_outlined,
              title: "Live Chat",
              subtitle: "Available 9 AM - 9 PM",
              color: const Color(0xFF9C27B0),
              onTap: _startLiveChat,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactOption({
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
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: color, size: 16),
          ],
        ),
      ),
    );
  }

  void _showReportIssue() {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController issueController = TextEditingController();
        String selectedCategory = 'Order Issue';

        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.report_outlined,
                    color: Colors.red,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 8),
                const Text("Report an Issue"),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  decoration: const InputDecoration(
                    labelText: "Issue Category",
                    border: OutlineInputBorder(),
                  ),
                  items:
                      [
                            'Order Issue',
                            'Payment Problem',
                            'App Bug',
                            'Restaurant Issue',
                            'Account Problem',
                            'Other',
                          ]
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(category),
                            ),
                          )
                          .toList(),
                  onChanged: (value) =>
                      setState(() => selectedCategory = value!),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: issueController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: "Describe the issue",
                    hintText: "Please provide as much detail as possible...",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  issueController.dispose();
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  issueController.dispose();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Issue reported successfully! We'll get back to you soon.",
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Report Issue"),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showUserGuide() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("User guide feature coming soon!"),
        backgroundColor: Color(0xFF7E57C2),
      ),
    );
  }

  void _contactViaEmail() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Opening email app..."),
        backgroundColor: Color(0xFF4CAF50),
      ),
    );
  }

  void _contactViaPhone() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Calling support..."),
        backgroundColor: Color(0xFF2196F3),
      ),
    );
  }

  void _startLiveChat() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Starting live chat..."),
        backgroundColor: Color(0xFF9C27B0),
      ),
    );
  }

  void _showPrivacyPolicy() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Privacy policy feature coming soon!"),
        backgroundColor: Color(0xFF7E57C2),
      ),
    );
  }

  void _showTermsOfService() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Terms of service feature coming soon!"),
        backgroundColor: Color(0xFF7E57C2),
      ),
    );
  }
}
