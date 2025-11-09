import 'package:flutter/material.dart';
import '../widgets/sections/edit_profile_header_section.dart';
import '../widgets/sections/edit_profile_form_section.dart';
import '../widgets/sections/edit_profile_photo_section.dart';
import '../models/user_profile.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _bioController = TextEditingController();

  String _selectedGender = 'Male';
  DateTime? _selectedBirthDate;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _loadUserProfile() {
    // Load current user profile data
    _nameController.text = "Alice Johnson";
    _emailController.text = "alice.johnson@email.com";
    _phoneController.text = "+256 700 123 456";
    _addressController.text = "123 Main Street, Kampala, Uganda";
    _bioController.text =
        "Food enthusiast and restaurant explorer. Love trying new cuisines!";
    _selectedGender = "Female";
    _selectedBirthDate = DateTime(1992, 5, 15);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            EditProfileHeaderSection(
              onBackPressed: () => Navigator.pop(context),
              onSavePressed: _saveProfile,
              isLoading: _isLoading,
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // Profile Photo Section
                    EditProfilePhotoSection(
                      onChangePhoto: _changeProfilePhoto,
                      onRemovePhoto: _removeProfilePhoto,
                    ),

                    const SizedBox(height: 32),

                    // Form Section
                    EditProfileFormSection(
                      formKey: _formKey,
                      nameController: _nameController,
                      emailController: _emailController,
                      phoneController: _phoneController,
                      addressController: _addressController,
                      bioController: _bioController,
                      selectedGender: _selectedGender,
                      selectedBirthDate: _selectedBirthDate,
                      onGenderChanged: (gender) {
                        setState(() {
                          _selectedGender = gender!;
                        });
                      },
                      onBirthDateChanged: (date) {
                        setState(() {
                          _selectedBirthDate = date;
                        });
                      },
                    ),

                    const SizedBox(height: 32),

                    // Delete Account Section
                    _buildDeleteAccountSection(),

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

  Widget _buildDeleteAccountSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red[100]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_rounded, color: Colors.red[600], size: 20),
              const SizedBox(width: 8),
              Text(
                "Danger Zone",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.red[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "Once you delete your account, there is no going back. Please be certain.",
            style: TextStyle(color: Colors.red[600], fontSize: 14),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _showDeleteAccountDialog,
              icon: const Icon(Icons.delete_forever_rounded),
              label: const Text("Delete Account"),
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
    );
  }

  void _changeProfilePhoto() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Change Profile Photo",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _pickImageFromCamera();
                    },
                    icon: const Icon(Icons.camera_alt_rounded),
                    label: const Text("Camera"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6366F1),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _pickImageFromGallery();
                    },
                    icon: const Icon(Icons.photo_library_rounded),
                    label: const Text("Gallery"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4ECDC4),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _pickImageFromCamera() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Camera feature will be available soon!"),
        backgroundColor: Color(0xFF6366F1),
      ),
    );
  }

  void _pickImageFromGallery() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Gallery feature will be available soon!"),
        backgroundColor: Color(0xFF4ECDC4),
      ),
    );
  }

  void _removeProfilePhoto() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            "Remove Photo",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.grey[800],
            ),
          ),
          content: const Text(
            "Are you sure you want to remove your profile photo?",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: TextStyle(color: Colors.grey[600])),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Profile photo removed"),
                    backgroundColor: Colors.orange,
                  ),
                );
              },
              child: const Text("Remove", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _saveProfile() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Profile updated successfully!"),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
        Navigator.pop(context);
      }
    }
  }

  void _showDeleteAccountDialog() {
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
              Text(
                "Delete Account",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.red[600],
                ),
              ),
            ],
          ),
          content: const Text(
            "This action cannot be undone. All your data including orders, bookings, and preferences will be permanently deleted.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: TextStyle(color: Colors.grey[600])),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _confirmDeleteAccount();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Delete Account"),
            ),
          ],
        );
      },
    );
  }

  void _confirmDeleteAccount() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController confirmController = TextEditingController();

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text("Final Confirmation"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Type 'DELETE' to confirm account deletion:"),
              const SizedBox(height: 12),
              TextField(
                controller: confirmController,
                decoration: const InputDecoration(
                  hintText: "Type DELETE here",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                confirmController.dispose();
                Navigator.pop(context);
              },
              child: Text("Cancel", style: TextStyle(color: Colors.grey[600])),
            ),
            ElevatedButton(
              onPressed: () {
                if (confirmController.text.toUpperCase() == 'DELETE') {
                  confirmController.dispose();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Account deletion process started. You will be contacted shortly.",
                      ),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 4),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please type 'DELETE' to confirm"),
                      backgroundColor: Colors.orange,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Confirm Delete"),
            ),
          ],
        );
      },
    );
  }
}
