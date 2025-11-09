import 'package:flutter/material.dart';
import '../../models/booking.dart';
import '../booking_card.dart';

class BookingListSection extends StatelessWidget {
  final int selectedTab;
  final List<Booking> upcomingBookings;
  final List<Booking> pastBookings;
  final Function(Booking) onBookingTap;

  const BookingListSection({
    super.key,
    required this.selectedTab,
    required this.upcomingBookings,
    required this.pastBookings,
    required this.onBookingTap,
  });

  @override
  Widget build(BuildContext context) {
    final bookings = selectedTab == 0 ? upcomingBookings : pastBookings;

    if (bookings.isEmpty) {
      return _buildEmptyState(context);
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        return BookingCard(
          booking: bookings[index],
          onTap: () => onBookingTap(bookings[index]),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(60),
            ),
            child: Icon(
              selectedTab == 0 ? Icons.event_available : Icons.history,
              size: 60,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            selectedTab == 0 ? "No Upcoming Bookings" : "No Past Bookings",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            selectedTab == 0
                ? "Your upcoming reservations will appear here"
                : "Your booking history will appear here",
            style: TextStyle(fontSize: 16, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
          if (selectedTab == 0) ...[
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Navigate to restaurants to make a booking
                Navigator.of(context).pop(); // Go back to main screen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6366F1),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Make a Booking",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
