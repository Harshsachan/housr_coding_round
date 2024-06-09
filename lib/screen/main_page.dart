import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housr_booking_app/bloc/hotel/hotel_list_bloc.dart';
import 'package:housr_booking_app/bloc/hotel/hotel_list_event.dart';
import 'package:housr_booking_app/bloc/hotel/hotel_list_state.dart';
import 'package:housr_booking_app/models/hotel_model.dart';
import 'package:housr_booking_app/screen/common/ratings_widget.dart';
import 'package:housr_booking_app/screen/hotel_description.dart';
import 'package:housr_booking_app/util/custom_theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late HotelBloc _hotelBloc;
  @override
  void initState() {
    super.initState();

    _hotelBloc = BlocProvider.of<HotelBloc>(context);
    _hotelBloc.add(LoadHotels());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelBloc, HotelState>(
      builder: (context, state) {
        if (state is HotelLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HotelError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is HotelLoaded) {
          return MainPageView(hotels: state.hotels);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class MainPageView extends StatelessWidget {
  final List<Hotel> hotels;
  const MainPageView({Key? key, required this.hotels}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/hotel7.jpeg',
              height: height*0.55,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0,top: 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AutoSizeText(
                        'Explore Nearby',
                        style:
                        CustomTheme.of(context).titleSmall.override(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const Icon(Icons.explore_outlined)
                    ],
                  ),
                  NearbyWidget(hotels: hotels,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NearbyWidget extends StatelessWidget {
  final List<Hotel> hotels;
  const NearbyWidget({super.key, required this.hotels});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        final hotel = hotels[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            shadowColor: Colors.black,
            elevation: 2,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HotelDescriptionPage(hotel: hotel),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image(
                        image: AssetImage(hotel.image),
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          12, 12, 12, 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            '${hotel.name} , ${hotel.location}',
                            style:
                            CustomTheme.of(context).titleSmall.override(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AutoSizeText(
                                '\$- ${hotel.price} , night',
                                style: CustomTheme.of(context)
                                    .bodyMedium
                                    .override(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                ),
                              ),
                              Row(
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
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
