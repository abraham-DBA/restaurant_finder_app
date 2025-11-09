import 'package:flutter/material.dart';

class EditProfileFormSection extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final TextEditingController bioController;
  final String selectedGender;
  final DateTime? selectedBirthDate;
  final Function(String?) onGenderChanged;
  final Function(DateTime?) onBirthDateChanged;

  const EditProfileFormSection({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.addressController,
    required this.bioController,
    required this.selectedGender,
    required this.selectedBirthDate,
    required this.onGenderChanged,
    required this.onBirthDateChanged,
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
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Title
            Text(
              "Personal Information",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 24),

            // Full Name
            _buildTextField(
              controller: nameController,
              label: "Full Name",
              icon: Icons.person_outline_rounded,
              validator: (value) {
                if (value?.isEmpty ?? true)
                  return "Please enter your full name";
                if (value!.length < 2)
                  return "Name must be at least 2 characters";
                return null;
              },
            ),

            const SizedBox(height: 20),

            // Email
            _buildTextField(
              controller: emailController,
              label: "Email Address",
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value?.isEmpty ?? true) return "Please enter your email";
                if (!RegExp(
                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                ).hasMatch(value!)) {
                  return "Please enter a valid email address";
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            // Phone Number
            _buildTextField(
              controller: phoneController,
              label: "Phone Number",
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value?.isEmpty ?? true)
                  return "Please enter your phone number";
                if (value!.length < 10)
                  return "Please enter a valid phone number";
                return null;
              },
            ),

            const SizedBox(height: 20),

            // Address
            _buildTextField(
              controller: addressController,
              label: "Address",
              icon: Icons.location_on_outlined,
              maxLines: 2,
            ),

            const SizedBox(height: 20),

            // Gender
            _buildGenderDropdown(),

            const SizedBox(height: 20),

            // Birth Date
            _buildBirthDateField(context),

            const SizedBox(height: 20),

            // Bio
            _buildTextField(
              controller: bioController,
              label: "Bio (Optional)",
              icon: Icons.description_outlined,
              maxLines: 3,
              hint: "Tell us a bit about yourself...",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    int maxLines = 1,
    String? hint,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: const Color(0xFF6366F1)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF6366F1), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[50],
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }

  Widget _buildGenderDropdown() {
    return DropdownButtonFormField<String>(
      initialValue: selectedGender,
      decoration: InputDecoration(
        labelText: "Gender",
        prefixIcon: const Icon(
          Icons.person_outline_rounded,
          color: Color(0xFF6366F1),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF6366F1), width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[50],
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      items: ['Male', 'Female', 'Other', 'Prefer not to say'].map((
        String gender,
      ) {
        return DropdownMenuItem<String>(value: gender, child: Text(gender));
      }).toList(),
      onChanged: onGenderChanged,
    );
  }

  Widget _buildBirthDateField(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectBirthDate(context),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[50],
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today_rounded, color: Color(0xFF6366F1)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Birth Date",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    selectedBirthDate != null
                        ? "${selectedBirthDate!.day}/${selectedBirthDate!.month}/${selectedBirthDate!.year}"
                        : "Select your birth date",
                    style: TextStyle(
                      fontSize: 16,
                      color: selectedBirthDate != null
                          ? Colors.grey[800]
                          : Colors.grey[500],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  Future<void> _selectBirthDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedBirthDate ?? DateTime(1990, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now().subtract(
        const Duration(days: 365 * 13),
      ), // At least 13 years old
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(
              context,
            ).colorScheme.copyWith(primary: const Color(0xFF6366F1)),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedBirthDate) {
      onBirthDateChanged(picked);
    }
  }
}
