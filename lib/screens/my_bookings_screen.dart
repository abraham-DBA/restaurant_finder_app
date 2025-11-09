import 'package:flutter/material.dart';
import '../widgets/sections/booking_header_section.dart';
import '../widgets/sections/booking_tab_section.dart';
import '../widgets/sections/booking_list_section.dart';
import '../models/booking.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  int selectedTab = 0; // 0 for Upcoming, 1 for Past bookings

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            BookingHeaderSection(onBackPressed: () => Navigator.pop(context)),

            // Tab Selection Section
            BookingTabSection(
              selectedTab: selectedTab,
              onTabChanged: (index) {
                setState(() {
                  selectedTab = index;
                });
              },
            ),

            // Bookings List Section
            Expanded(
              child: BookingListSection(
                selectedTab: selectedTab,
                upcomingBookings: _upcomingBookings,
                pastBookings: _pastBookings,
                onBookingTap: (booking) =>
                    _showBookingDetails(booking, selectedTab),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBookingDetails(Booking booking, int currentTab) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildBookingDetailsSheet(booking, currentTab),
    );
  }

  Widget _buildBookingDetailsSheet(Booking booking, int currentTab) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Booking Details",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 20),
          _buildDetailCard(booking),
          const SizedBox(height: 20),
          // Only show action buttons for upcoming bookings (tab 0)
          if (currentTab == 0) ...[
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _showCancelBookingDialog(booking);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Cancel Booking"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _showModifyBookingDialog(booking);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6366F1),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Modify"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ] else ...[
            // For past bookings, show a close button or just extra spacing
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.grey[600],
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: const Text(
                  "Close",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 30),
        ],
      ),
    );
  }

  Widget _buildDetailCard(Booking booking) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _buildDetailItem("Restaurant", booking.restaurantName),
          const SizedBox(height: 12),
          _buildDetailItem("Booking Date", booking.date),
          const SizedBox(height: 12),
          _buildDetailItem("Time", booking.time),
          const SizedBox(height: 12),
          _buildDetailItem("Number of Guests", "${booking.guests} people"),
          const SizedBox(height: 12),
          _buildDetailItem(
            "Table Preference",
            booking.tableType ?? "Standard Table",
          ),
          const SizedBox(height: 12),
          _buildDetailItem("Status", booking.status),
          if (booking.specialRequests != null &&
              booking.specialRequests!.isNotEmpty) ...[
            const SizedBox(height: 12),
            _buildDetailItem("Special Requests", booking.specialRequests!),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: TextStyle(
              color: Colors.grey[800],
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  void _showCancelBookingDialog(Booking booking) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            "Cancel Booking",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.grey[800],
            ),
          ),
          content: Text(
            "Are you sure you want to cancel your booking at ${booking.restaurantName} on ${booking.date}?",
            style: TextStyle(color: Colors.grey[600]),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Keep Booking",
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Booking at ${booking.restaurantName} has been cancelled",
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Cancel Booking"),
            ),
          ],
        );
      },
    );
  }

  void _showModifyBookingDialog(Booking booking) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            "Modify Booking",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.grey[800],
            ),
          ),
          content: Text(
            "Would you like to modify your booking at ${booking.restaurantName}?",
            style: TextStyle(color: Colors.grey[600]),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: TextStyle(color: Colors.grey[600])),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Booking modification feature coming soon!"),
                    backgroundColor: Color(0xFF6366F1),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6366F1),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Modify"),
            ),
          ],
        );
      },
    );
  }

  // Sample data - In a real app, this would come from an API or database
  final List<Booking> _upcomingBookings = [
    Booking(
      id: "1",
      restaurantName: "The Gourmet Hub",
      date: "November 15, 2025",
      time: "7:00 PM",
      guests: 4,
      status: "Confirmed",
      tableType: "Window Seat",
      specialRequests: "Birthday celebration",
    ),
    Booking(
      id: "2",
      restaurantName: "Pizza Palace",
      date: "November 12, 2025",
      time: "6:30 PM",
      guests: 2,
      status: "Pending",
      tableType: "Private Booth",
    ),
    Booking(
      id: "3",
      restaurantName: "Sushi Express",
      date: "November 18, 2025",
      time: "8:00 PM",
      guests: 6,
      status: "Confirmed",
      tableType: "Standard Table",
      specialRequests: "Vegetarian options preferred",
    ),
  ];

  final List<Booking> _pastBookings = [
    Booking(
      id: "4",
      restaurantName: "Burger Corner",
      date: "October 25, 2025",
      time: "6:30 PM",
      guests: 3,
      status: "Completed",
      tableType: "Bar Counter",
    ),
    Booking(
      id: "5",
      restaurantName: "Italian Bistro",
      date: "October 15, 2025",
      time: "7:30 PM",
      guests: 2,
      status: "Completed",
      tableType: "Window Seat",
      specialRequests: "Anniversary dinner",
    ),
    Booking(
      id: "6",
      restaurantName: "Seafood Delights",
      date: "September 30, 2025",
      time: "8:00 PM",
      guests: 4,
      status: "Cancelled",
      tableType: "Garden Patio",
    ),
  ];
}
