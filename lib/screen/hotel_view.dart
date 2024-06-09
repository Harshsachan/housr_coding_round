import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housr_booking_app/bloc/hotel/hotel_list_bloc.dart';
import 'package:housr_booking_app/models/hotel_model.dart';
import 'package:housr_booking_app/screen/common/ratings_widget.dart';
import 'package:housr_booking_app/screen/hotel_description.dart';
import 'package:housr_booking_app/util/custom_theme.dart';

class HotelViewWidget extends StatefulWidget {
  final List<Hotel> hotels;

  const HotelViewWidget({Key? key, required this.hotels}) : super(key: key);

  @override
  State<HotelViewWidget> createState() => _HotelViewWidgetState();
}

class _HotelViewWidgetState extends State<HotelViewWidget> {
  late HotelBloc _hotelBloc;
  void initState() {
    super.initState();
    _hotelBloc = BlocProvider.of<HotelBloc>(context);
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.hotels.length,
        itemBuilder: (context, index) {
          final hotel = widget.hotels[index];
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
                    // mainAxisSize: MainAxisSize.max,
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
                            // Rating(rating: product.averageRating),
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
      ),
    );
  }
}
