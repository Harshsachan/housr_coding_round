import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:housr_booking_app/db/shared_prefence.dart';
import 'package:housr_booking_app/models/hotel_model.dart';
import 'package:housr_booking_app/screen/booking_confirmation.dart';
import 'package:housr_booking_app/screen/common/ratings_widget.dart';
import 'package:housr_booking_app/util/custom_theme.dart';

class HotelDescriptionPage extends StatelessWidget {
  final Hotel hotel;
  const HotelDescriptionPage({Key? key, required this.hotel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipPath(
                          clipper: BottomRoundedClipper(
                              radius: 30.0), // Radius of the rounded corners
                          child: Image(
                            image: AssetImage(hotel.image),
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.40,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: AutoSizeText(
                                  hotel.name,
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    color: Color(0xff565FFF),
                                  ),
                                  AutoSizeText(
                                    ' Private Room in ${hotel.location}',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Row(
                                  children: [
                                    RatingWidget(
                                        rating: hotel.calculateAverageRating()),
                                    AutoSizeText(
                                      '${hotel.calculateAverageRating()}/5',
                                      style: CustomTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Divider(thickness: 2),
                              const SizedBox(height: 10),
                              const AutoSizeText(
                                'Hosted by Housr',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 20),
                              const Divider(thickness: 2),
                              const AutoSizeText(
                                'Facilities',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5,
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 10.0,
                                  childAspectRatio:
                                      2, // Adjust this aspect ratio as needed
                                ),
                                itemCount: hotel.amenities.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      Container(
                                        height:
                                            80, // Adjust the height as needed
                                        width: 50,
                                        decoration: const BoxDecoration(
                                          color: Color(0xffF1F1FF),
                                        ),
                                        child: Icon(
                                            getAmenityIcon(
                                                hotel.amenities[index]),
                                            color: const Color(0xff565FFF)),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                              const Divider(thickness: 2),
                              const SizedBox(height: 10),
                              const AutoSizeText(
                                'Room Types',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Wrap(
                                spacing: 8.0,
                                children: hotel.roomTypes.map((roomType) {
                                  return Chip(label: Text(roomType));
                                }).toList(),
                              ),
                              const SizedBox(height: 20),
                              const Divider(thickness: 2),
                              const SizedBox(height: 10),
                              const AutoSizeText(
                                'All Ratings',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: hotel.ratings.length,
                                itemBuilder: (context, index) {
                                  final review = hotel.ratings[index];
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          AutoSizeText(
                                            review.userName ?? '',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          RatingWidget(
                                              rating:
                                                  review.rating.toDouble() ??
                                                      0),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      AutoSizeText(
                                        review.review ?? 'No review',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      const Divider(thickness: 1),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 16.0,
                    left: 16.0,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: IconButton(
                        color: Colors.black,
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border(
                  top: BorderSide(
                    color: Colors.grey.shade300, // Adjust border color as needed
                    width: 1.0, // Adjust border width as needed
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        AutoSizeText(
                          '\$ ${hotel.price}.00',
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        AutoSizeText(
                          '1 Night Price',
                          style: TextStyle(
                              fontSize: 10,
                            color: Colors.grey.shade600
                              ),
                        ),
                      ],
                    ),
                    Container(
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
                        onPressed: () async {


                          final email = await UserPreferences.getEmail();
                          if (email!= null) {
                            UserPreferences.addIdToEmail(int.parse(hotel.id), email);
                          } else {
                          }
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const BookingConfirmation()),
                          );

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          elevation: 0, // No shadow
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 24.0),
                          // primary: Colors.transparent, // Transparent color to allow gradient
                          // onPrimary: Colors.transparent, // Transparent color to allow gradient
                          shadowColor: Colors.transparent, // Transparent shadow
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'Book Now',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData getAmenityIcon(String amenity) {
    switch (amenity) {
      case "Wi-Fi":
        return Icons.wifi;
      case "Swimming Pool":
        return Icons.pool;
      case "Gym":
        return Icons.fitness_center;
      case "Hot Tub":
        return Icons.hot_tub;
      case "Air Condition":
        return Icons.ac_unit;
      case "Tv":
        return Icons.tv;
      case "Hair Dryer":
        return Icons
            .local_hotel; // Just a placeholder, you can replace it with a suitable icon
      default:
        return Icons.check_circle;
    }
  }
}

class BottomRoundedClipper extends CustomClipper<Path> {
  final double radius;

  BottomRoundedClipper({required this.radius});

  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, size.height - radius)
      ..quadraticBezierTo(0, size.height, radius, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
