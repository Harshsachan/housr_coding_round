import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housr_booking_app/bloc/hotel/hotel_list_bloc.dart';
import 'package:housr_booking_app/bloc/hotel/hotel_list_event.dart';
import 'package:housr_booking_app/bloc/hotel/hotel_list_state.dart';
import 'package:housr_booking_app/models/hotel_model.dart';
import 'package:housr_booking_app/screen/hotel_view.dart';
import 'package:housr_booking_app/util/custom_theme.dart';

class HotelList extends StatefulWidget {
  const HotelList({super.key});

  @override
  _HotelListState createState() => _HotelListState();
}

class _HotelListState extends State<HotelList> {
  late TextEditingController _searchController;
  late HotelBloc _hotelBloc;
  List<String> _selectedAmenities = [];


  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _hotelBloc = BlocProvider.of<HotelBloc>(context);
    _hotelBloc.add(LoadHotels());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          body: BlocBuilder<HotelBloc, HotelState>(
            builder: (context, state) {
              if (state is HotelLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HotelError) {
                return Center(child: Text('Error: ${state.message}'));
              } else if (state is HotelLoaded) {
                return HotelListView(
                  hotels: state.hotels,
                  onSearchTextChanged: _onSearchTextChanged,
                  searchController: _searchController,
                  selectedAmenities: _selectedAmenities,
                  hotelBloc: _hotelBloc,
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  void _onSearchTextChanged(String searchText) {
    if (searchText.isEmpty) {
      _hotelBloc.add(LoadHotels());
    } else {
      _hotelBloc.add(SearchHotels(searchText));
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class HotelListView extends StatefulWidget {
  final List<Hotel> hotels;
  final Function(String) onSearchTextChanged;
  final TextEditingController searchController;
  final List<String> selectedAmenities;
  final HotelBloc hotelBloc;

  const HotelListView({
    super.key,
    required this.hotels,
    required this.onSearchTextChanged,
    required this.searchController,
    required this.selectedAmenities,
    required this.hotelBloc,
  });

  @override
  State<HotelListView> createState() => _HotelListViewState();
}

class _HotelListViewState extends State<HotelListView> {
  late TextEditingController _minPriceController;
  late TextEditingController _maxPriceController;
  double? _minPrice;
  double? _maxPrice;

  @override
  void initState() {
    super.initState();
    _minPriceController = TextEditingController();
    _maxPriceController = TextEditingController();
  }

  @override
  void dispose() {
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  void _applyFilters() {
    widget.hotelBloc.add(FilterHotels(widget.selectedAmenities, minPrice: _minPrice, maxPrice: _maxPrice));
  }

  void _resetFilters() {
    setState(() {
      _minPrice = null;
      _maxPrice = null;
      widget.selectedAmenities.clear();
      _minPriceController.clear();
      _maxPriceController.clear();
    });
    widget.hotelBloc.add(LoadHotels());
  }

  void _showFilterOptions(BuildContext context) {
    _minPriceController.text = _minPrice?.toString() ?? '';
    _maxPriceController.text = _maxPrice?.toString() ?? '';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context,setState){
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Filter Options',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Price Range',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Min Price',
                        ),
                        controller: _minPriceController,
                        onChanged: (value) {
                          setState(() {
                            _minPrice = double.tryParse(value);
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Max Price',
                        ),
                        controller: _maxPriceController,
                        onChanged: (value) {
                          setState(() {
                            _maxPrice = double.tryParse(value);
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Amenities',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 200, // Limit height to avoid overflow
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (var amenity in [
                        "Wi-Fi",
                        "Swimming Pool",
                        "Gym",
                        "Air Condition",
                        "Tv",
                        "dvd",
                      ])
                        CheckboxListTile(
                          activeColor: CustomTheme.of(context).secondaryText, // Checked checkbox color
                          checkColor: Colors.white, // Check color inside checkbox
                          title: Text(
                            amenity,
                          ),
                          value: widget.selectedAmenities.contains(amenity),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value != null) {
                                if (value) {
                                  widget.selectedAmenities.add(amenity);
                                } else {
                                  widget.selectedAmenities.remove(amenity);
                                }
                              }
                            });
                          },
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _resetFilters();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text(
                        'Reset',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _applyFilters();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomTheme.of(context).secondaryText,
                      ),
                      child: const Text(
                        'Apply',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );}
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: widget.searchController,
                    decoration: InputDecoration(
                      hintText: 'Search hotels...',
                      hintStyle: const TextStyle(
                        color: Colors.black,
                      ), // Text color for hint
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.black, // Icon color
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          widget.searchController.clear();
                          widget.onSearchTextChanged('');
                        },
                        icon: const Icon(Icons.clear, color: Colors.black), // Icon color
                      ),
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: CustomTheme.of(context).secondaryText, width: 2), // Border color
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: CustomTheme.of(context).secondaryText, width: 2), // Border color
                      ),
                      fillColor: const Color(0xffE5E5E5), // Background color
                      filled: true,
                    ),
                    style: const TextStyle(color: Colors.black), // Text color
                    onChanged: widget.onSearchTextChanged,
                  ),
                ),
              ),
              FloatingActionButton(
                backgroundColor: const Color(0xff565FFF),
                onPressed: () {
                  _showFilterOptions(context);
                },
                child: const Icon(
                  Icons.filter_list,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          widget.hotels.isEmpty
              ? Center(
            child: AutoSizeText(
              'No Hotels Found',
              style: CustomTheme.of(context).headlineMedium.override(
                fontFamily: 'Poppins',
                fontSize: 20,
              ),
            ),
          )
              : HotelViewWidget(hotels: widget.hotels),
        ],
      ),
    );
  }
}
