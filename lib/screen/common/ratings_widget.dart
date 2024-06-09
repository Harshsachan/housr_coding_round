import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final double rating;

  const RatingWidget({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    int fullStars = rating.floor(); // Get the integer part of the rating
    double halfStar = rating - fullStars; // Get the fractional part of the rating

    return Row(
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return const Icon(
            Icons.star,
            color: Color(0xff565FFF),
          );
        } else if (index == fullStars && halfStar > 0) {
          return const Icon(
            Icons.star_half,
            color: Color(0xff565FFF),
          );
        } else {
          return const Icon(
            Icons.star_border,
            color: Colors.black,
          );
        }
      }),
    );
  }
}
