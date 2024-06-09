import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:housr_booking_app/models/hotel_model.dart';

class DataLoader {
  static Future<List<Hotel>> loadHotels() async {
    final String response = await rootBundle.loadString('lib/data/hotels.json');
    final data = await json.decode(response);
    return (data as List).map((hotel) => Hotel.fromJson(hotel)).toList();
  }


}
