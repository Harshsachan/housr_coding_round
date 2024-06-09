abstract class HotelEvent {}

class LoadHotels extends HotelEvent {}

class SearchHotels extends HotelEvent {
  final String query;

  SearchHotels(this.query);
}


class FilterHotels extends HotelEvent {
  final List<String> selectedAmenities;
  final double? minPrice;
  final double? maxPrice;

  FilterHotels(this.selectedAmenities, {this.minPrice, this.maxPrice});
}

class FindHotelsByUserEmail extends HotelEvent {
  final String userEmail;

  FindHotelsByUserEmail({required this.userEmail});
}