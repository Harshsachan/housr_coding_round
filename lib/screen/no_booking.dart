import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class NoBooking extends StatelessWidget {
  const NoBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffD3E2FD),
        title: const Text('My Bookings'),
        centerTitle: true,
      ),
      body: const Center(
        child: AutoSizeText(
          'No Bookings Found',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
