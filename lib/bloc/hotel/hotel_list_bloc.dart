import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housr_booking_app/bloc/hotel/hotel_list_event.dart';
import 'package:housr_booking_app/bloc/hotel/hotel_list_state.dart';
import 'package:housr_booking_app/db/shared_prefence.dart';
import 'package:housr_booking_app/models/hotel_model.dart';
import 'package:housr_booking_app/repo/hotel_repositry.dart';

class HotelBloc extends Bloc<HotelEvent, HotelState> {
  final HotelRepository _hotelRepository = HotelRepository();

  HotelRepository get hotelRepository => _hotelRepository;


  HotelBloc() : super(HotelInitial()) {
    on<LoadHotels>(_onLoadHotels);
    on<SearchHotels>(_onSearchHotels);
    on<FilterHotels>(_onFilterHotels);
    on<FindHotelsByUserEmail>(_onFindHotelsByUserEmail);
  }

  void _onLoadHotels(LoadHotels event, Emitter<HotelState> emit) async {
    emit(HotelLoading());
    try {
      final hotels = await _hotelRepository.getHotels();
      emit(HotelLoaded(hotels));
    } catch (e) {
      emit(HotelError("Failed to load hotels: $e"));
    }
  }
  void _onFilterHotels(FilterHotels event, Emitter<HotelState> emit) async {
    emit(HotelLoading());
    try {
      final filteredHotels = await _hotelRepository.filterHotels(event.selectedAmenities, event.minPrice, event.maxPrice);
      emit(HotelLoaded(filteredHotels));
    } catch (e) {
      emit(HotelError("Failed to filter hotels: $e"));
    }
  }

  void _onSearchHotels(SearchHotels event, Emitter<HotelState> emit) async {
    if (event.query.isEmpty) {
      emit(HotelLoaded([]));
    } else {
      try {
        final hotels = await _hotelRepository.searchHotels(event.query);
        emit(HotelLoaded(hotels));
      } catch (e) {
        emit(HotelError("Failed to search hotels: $e"));
      }
    }
  }

  void _onFindHotelsByUserEmail(FindHotelsByUserEmail event, Emitter<HotelState> emit) async {
    emit(HotelLoading());

    try {
      final ids = await UserPreferences.getIdsForEmail(event.userEmail);
      List<Hotel?> hotels = await Future.wait(ids.map((id) async {
        return await _hotelRepository.findHotelById(id.toString());
      }));

      final nonNullHotels = hotels.where((hotel) => hotel!= null).toList();

      if (nonNullHotels.isNotEmpty) {
        emit(HotelLoaded(nonNullHotels.cast<Hotel>())); // Cast to List<Hotel>
      } else {
        emit(HotelError("No hotels found"));
      }
    } catch (e) {
      emit(HotelError("Failed to find hotels: $e"));
    }
  }


}