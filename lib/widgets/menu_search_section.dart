import 'package:flutter/material.dart';

class MenuSearchSection extends StatelessWidget {
  final ValueChanged<String> onSearchChanged;
  final String searchQuery;

  const MenuSearchSection({
    super.key,
    required this.onSearchChanged,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          TextField(
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Search menu items...',
              hintStyle: TextStyle(color: Colors.grey[600], fontSize: 16),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
                size: 24,
              ),
              filled: true,
              fillColor: Colors.grey[100],
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.black54, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
