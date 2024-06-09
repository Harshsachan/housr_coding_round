import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housr_booking_app/bloc/hotel/hotel_list_bloc.dart';
import 'package:housr_booking_app/bloc/hotel/hotel_list_event.dart';
import 'package:housr_booking_app/db/shared_prefence.dart';
import 'package:housr_booking_app/models/hotel_model.dart';
import 'package:housr_booking_app/screen/no_booking.dart';
import 'package:housr_booking_app/screen/booked_hotel.dart';
import 'package:housr_booking_app/screen/sign_in_screen.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late HotelBloc _hotelBloc;
  @override
  void initState() {
    super.initState();
    _hotelBloc = BlocProvider.of<HotelBloc>(context);
    _hotelBloc.add(LoadHotels());
    final email = UserPreferences.getEmail();
    _hotelBloc.add(FindHotelsByUserEmail(userEmail: email.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffD3E2FD),
        title: const Center(child: Text("My Profile")),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: _getUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No user data available'));
          } else {
            final userDetails = snapshot.data as Map<String, String>;
            var width = MediaQuery.of(context).size.width;
            var height = MediaQuery.of(context).size.height;
            return BlocProvider(
              create: (context) => HotelBloc(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    color: const Color(0xffD3E2FD),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                height: MediaQuery.of(context).size.width * 0.2,
                                clipBehavior: Clip.antiAlias,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset(
                                    "assets/icons/boy_blue.png"), // Change this line
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  AutoSizeText(
                                    '${userDetails['name']}',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  AutoSizeText(
                                    '${userDetails['email']}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      final email = await UserPreferences.getEmail();
                      _hotelBloc.add(
                          FindHotelsByUserEmail(userEmail: email.toString()));
                      var ids = await UserPreferences.getIdsForEmail(
                          email.toString());
                      List<Hotel?> hotels =
                          await Future.wait(ids.map((id) async {
                        return await context
                            .read<HotelBloc>()
                            .hotelRepository
                            .findHotelById(id.toString());
                      }));
                      if (ids.isEmpty) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const NoBooking(),
                          ),
                        );
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => HotelListScreen(
                                hotels: hotels
                                    .where((hotel) => hotel != null)
                                    .toList()
                                    .cast<Hotel>()),
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: width * 0.90,
                      height: height * 0.075,
                      decoration: const BoxDecoration(
                        color: Color(0xffD3E2FD),
                        borderRadius:
                            BorderRadius.all(Radius.circular(10)), // add this
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(
                              'My Bookings',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.arrow_forward_ios_sharp)
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: width * 0.50,
                    child: ElevatedButton(
                      onPressed: () async {
                        await UserPreferences.clearUser();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()),
                        );
                      },
                      child: const Text('Logout'),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future<Map<String, String>> _getUserDetails() async {
    final name = await UserPreferences.getUsername();
    final email = await UserPreferences.getEmail();
    return {
      'name': name ?? 'N/A',
      'email': email ?? 'N/A',
    };
  }
}
