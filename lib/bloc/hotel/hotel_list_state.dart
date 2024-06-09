import 'package:housr_booking_app/models/hotel_model.dart';

abstract class HotelState {}

class HotelInitial extends HotelState {}

class HotelLoading extends HotelState {}

class HotelLoaded extends HotelState {
  final List<Hotel> hotels;

  HotelLoaded(this.hotels);
}


class HotelError extends HotelState {
  final String message;

  HotelError(this.message);
}
class HotelLoadedById extends HotelState {
  final Hotel hotel;
  HotelLoadedById(this.hotel);
}