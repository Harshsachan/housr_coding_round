import 'package:housr_booking_app/models/hotel_model.dart';
import 'package:housr_booking_app/util/data_loader.dart';

/// Repository for managing hotel data.
class HotelRepository {
  /// Loads all hotels.
  Future<List<Hotel>> getHotels() async {
    return await DataLoader.loadHotels();
  }

  /// Searches hotels based on a query string.
  /// The search is case-insensitive and matches hotel names containing the query.
  Future<List<Hotel>> searchHotels(String query) async {
    final hotels = await DataLoader.loadHotels();
    return hotels.where((hotel) => hotel.location.toLowerCase().contains(query.toLowerCase())).toList();
  }
  /// Filter Functionality
  Future<List<Hotel>> filterHotels(List<String> amenities, double? minPrice, double? maxPrice) async {
    final hotels = await DataLoader.loadHotels();
    return hotels.where((hotel) {
      final matchesAmenities = amenities.every((amenity) => hotel.amenities.contains(amenity));
      final matchesMinPrice = minPrice == null || hotel.price >= minPrice;
      final matchesMaxPrice = maxPrice == null || hotel.price <= maxPrice;
      return matchesAmenities && matchesMinPrice && matchesMaxPrice;
    }).toList();
  }

  Future<Hotel?> findHotelByIdAndUserEmail(String hotelId, String userEmail) async {
    final hotels = await DataLoader.loadHotels();
    return hotels.firstWhere((hotel) => hotel.id == hotelId && hotel.ratings.any((rating) => rating.userId == userEmail));
  }
  Future<Hotel?> findHotelById(String id) async {
    final hotels = await DataLoader.loadHotels();
    return hotels.firstWhere((hotel) => hotel.id == id);
  }
}
