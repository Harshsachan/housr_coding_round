import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:housr_booking_app/screen/home_page.dart';
import 'package:housr_booking_app/util/custom_theme.dart';
import 'package:housr_booking_app/util/draw_star.dart';

class BookingConfirmation extends StatefulWidget {
  const BookingConfirmation({super.key});

  @override
  State<BookingConfirmation> createState() => _BookingConfirmationState();
}

class _BookingConfirmationState extends State<BookingConfirmation> {
  final ConfettiController _confettiController = ConfettiController();

  @override
  void initState() {
    super.initState();
    _confettiController.play();
    Timer(const Duration(seconds: 6), () {
      _confettiController.stop();
    });
  }


  @override
  Widget build(BuildContext context) {
    return ConfettiWidget(
      confettiController: _confettiController,
      blastDirectionality: BlastDirectionality.explosive,
      shouldLoop: true,
      colors: const [
        Colors.green,
        Colors.blue,
        Colors.pink,
        Colors.orange,
        Colors.purple
      ],
      createParticlePath: drawStar,
      child: Scaffold(
        body: SafeArea(
          top: true,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  'Congrats!',
                  style: CustomTheme.of(context).headlineMedium.override(
                        fontFamily: 'Poppins',
                        color: CustomTheme.of(context).primaryText,
                        fontSize: 32,
                      ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                  child: AutoSizeText(
                    'Your Booking is Confirmed',
                    style: CustomTheme.of(context).titleSmall.override(
                          fontFamily: 'Poppins',
                          color: CustomTheme.of(context).primaryText,
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                  child: AutoSizeText(
                    'Enjoy Your Luxurious Stay!',
                    style: CustomTheme.of(context).titleSmall.override(
                          fontFamily: 'Poppins',
                          color: CustomTheme.of(context).pBackground,
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 44, 0, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.40,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xff6a73fe), Color(0xff2b36ff)],
                        stops: [0.25, 0.75],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const MyHomePage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 4, // No shadow
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 24.0),
                        // Transparent color to allow gradient
                        shadowColor: Colors.transparent, // Transparent shadow
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Home',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
