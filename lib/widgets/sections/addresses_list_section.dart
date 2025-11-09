import 'package:flutter/material.dart';
import '../../models/address.dart';

class AddressesListSection extends StatelessWidget {
  final List<Address> addresses;
  final bool isLoading;
  final Function(Address) onSetDefault;
  final Function(Address) onEdit;
  final Function(Address) onDelete;

  const AddressesListSection({
    super.key,
    required this.addresses,
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
                  color: const Color(0xFF4CAF50).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.location_city,
                  color: Color(0xFF4CAF50),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "Your Addresses",
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
          else if (addresses.isEmpty)
            _buildEmptyState()
          else
            Column(
              children: addresses
                  .map(
                    (address) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildAddressCard(address),
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
            child: Icon(Icons.location_off, color: Colors.grey[400], size: 48),
          ),
          const SizedBox(height: 16),
          Text(
            "No Addresses Added",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Add an address to get food delivered",
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAddressCard(Address address) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: address.isDefault
            ? const Color(0xFF4CAF50).withValues(alpha: 0.05)
            : Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: address.isDefault
              ? const Color(0xFF4CAF50).withValues(alpha: 0.3)
              : Colors.grey[200]!,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Address Type Icon
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: address.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(address.icon, color: address.color, size: 20),
          ),

          const SizedBox(width: 16),

          // Address Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      address.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                    if (address.isDefault) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CAF50),
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
                const SizedBox(height: 6),
                Text(
                  address.displayAddress,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.3,
                  ),
                ),
                if (address.instructions != null) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 14,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          address.instructions!,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                if (address.hasCoordinates) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.gps_fixed, size: 14, color: Colors.green[600]),
                      const SizedBox(width: 4),
                      Text(
                        "GPS coordinates available",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.green[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
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
              if (!address.isDefault)
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
                  onSetDefault(address);
                  break;
                case 'edit':
                  onEdit(address);
                  break;
                case 'delete':
                  onDelete(address);
                  break;
              }
            },
          ),
        ],
      ),
    );
  }
}
