import 'package:flutter/material.dart';
import '../widgets/sections/payment_header_section.dart';
import '../widgets/sections/payment_methods_list_section.dart';
import '../widgets/sections/add_payment_method_section.dart';
import '../models/payment_method.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            PaymentHeaderSection(onBackPressed: () => Navigator.pop(context)),

            // Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // Add Payment Method Section
                    AddPaymentMethodSection(
                      onAddCard: _showAddCardDialog,
                      onAddMobileMoney: _showAddMobileMoneyDialog,
                      onAddBankAccount: _showAddBankDialog,
                    ),

                    const SizedBox(height: 24),

                    // Payment Methods List
                    PaymentMethodsListSection(
                      paymentMethods: _paymentMethods,
                      isLoading: _isLoading,
                      onSetDefault: _setDefaultPaymentMethod,
                      onEdit: _editPaymentMethod,
                      onDelete: _deletePaymentMethod,
                    ),

                    const SizedBox(height: 32),

                    // Security Info Section
                    _buildSecurityInfoSection(),

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

  Widget _buildSecurityInfoSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF6366F1).withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF6366F1).withValues(alpha: 0.2),
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
                  color: const Color(0xFF6366F1).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.security_rounded,
                  color: Color(0xFF6366F1),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "Security & Privacy",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            "Your payment information is encrypted and securely stored. We never store your full card details on our servers.",
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green[600], size: 16),
              const SizedBox(width: 8),
              Text(
                "PCI DSS Compliant",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green[600], size: 16),
              const SizedBox(width: 8),
              Text(
                "256-bit SSL Encryption",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAddCardDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController cardNumberController =
            TextEditingController();
        final TextEditingController expiryController = TextEditingController();
        final TextEditingController cvvController = TextEditingController();
        final TextEditingController nameController = TextEditingController();

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.credit_card,
                  color: Color(0xFF6366F1),
                  size: 18,
                ),
              ),
              const SizedBox(width: 8),
              const Text("Add Credit Card"),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: cardNumberController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Card Number",
                    hintText: "1234 5678 9012 3456",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: expiryController,
                        keyboardType: TextInputType.datetime,
                        decoration: const InputDecoration(
                          labelText: "MM/YY",
                          hintText: "12/28",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: cvvController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "CVV",
                          hintText: "123",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Cardholder Name",
                    hintText: "John Doe",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                cardNumberController.dispose();
                expiryController.dispose();
                cvvController.dispose();
                nameController.dispose();
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                // Add card logic here
                cardNumberController.dispose();
                expiryController.dispose();
                cvvController.dispose();
                nameController.dispose();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Credit card added successfully!"),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6366F1),
                foregroundColor: Colors.white,
              ),
              child: const Text("Add Card"),
            ),
          ],
        );
      },
    );
  }

  void _showAddMobileMoneyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController phoneController = TextEditingController();
        String selectedProvider = 'MTN';

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
                    color: const Color(0xFF4ECDC4).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.phone_android,
                    color: Color(0xFF4ECDC4),
                    size: 18,
                  ),
                ),
                const SizedBox(width: 8),
                const Text("Add Mobile Money"),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  value: selectedProvider,
                  decoration: const InputDecoration(
                    labelText: "Provider",
                    border: OutlineInputBorder(),
                  ),
                  items: ['MTN', 'Airtel', 'Orange'].map((provider) {
                    return DropdownMenuItem(
                      value: provider,
                      child: Text(provider),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedProvider = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: "Phone Number",
                    hintText: "+256 700 123 456",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  phoneController.dispose();
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  phoneController.dispose();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "$selectedProvider Mobile Money added successfully!",
                      ),
                      backgroundColor: const Color(0xFF4ECDC4),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4ECDC4),
                  foregroundColor: Colors.white,
                ),
                child: const Text("Add Account"),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAddBankDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController accountController = TextEditingController();
        final TextEditingController bankController = TextEditingController();

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFF45B7D1).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.account_balance,
                  color: Color(0xFF45B7D1),
                  size: 18,
                ),
              ),
              const SizedBox(width: 8),
              const Text("Add Bank Account"),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: bankController,
                decoration: const InputDecoration(
                  labelText: "Bank Name",
                  hintText: "e.g., Stanbic Bank",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: accountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Account Number",
                  hintText: "1234567890",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                accountController.dispose();
                bankController.dispose();
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                accountController.dispose();
                bankController.dispose();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Bank account added successfully!"),
                    backgroundColor: Color(0xFF45B7D1),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF45B7D1),
                foregroundColor: Colors.white,
              ),
              child: const Text("Add Account"),
            ),
          ],
        );
      },
    );
  }

  void _setDefaultPaymentMethod(PaymentMethod method) {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${method.name} set as default payment method"),
            backgroundColor: Colors.green,
          ),
        );
      }
    });
  }

  void _editPaymentMethod(PaymentMethod method) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Edit payment method feature coming soon!"),
        backgroundColor: Color(0xFF6366F1),
      ),
    );
  }

  void _deletePaymentMethod(PaymentMethod method) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.warning_rounded, color: Colors.red[600]),
              const SizedBox(width: 8),
              const Text("Delete Payment Method"),
            ],
          ),
          content: Text(
            "Are you sure you want to delete ${method.name}? This action cannot be undone.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("${method.name} deleted successfully"),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  // Sample data - In a real app, this would come from an API or database
  final List<PaymentMethod> _paymentMethods = [
    PaymentMethod(
      id: "1",
      type: "card",
      name: "Visa Credit Card",
      details: "4532",
      cardBrand: "visa",
      expiryDate: "12/28",
      isDefault: true,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now().subtract(const Duration(days: 30)),
    ),
    PaymentMethod(
      id: "2",
      type: "mobile_money",
      name: "MTN Mobile Money",
      details: "+256 700 123 456",
      isDefault: false,
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      updatedAt: DateTime.now().subtract(const Duration(days: 15)),
    ),
    PaymentMethod(
      id: "3",
      type: "card",
      name: "Mastercard Debit",
      details: "8901",
      cardBrand: "mastercard",
      expiryDate: "06/27",
      isDefault: false,
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      updatedAt: DateTime.now().subtract(const Duration(days: 10)),
    ),
    PaymentMethod(
      id: "4",
      type: "bank",
      name: "Stanbic Bank",
      details: "7890",
      isDefault: false,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      updatedAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
  ];
}
