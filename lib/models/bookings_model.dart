class Booking {
  final String id;
  final String hotelName;
  final String userEmail;
  final DateTime bookingDate;

  Booking({
    required this.id,
    required this.hotelName,
    required this.userEmail,
    required this.bookingDate,
  });

  // Method to create a Booking instance from a map
  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'],
      hotelName: map['hotelName'],
      userEmail: map['userEmail'],
      bookingDate: DateTime.parse(map['bookingDate']),
    );
  }

  // Method to convert Booking instance to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'hotelName': hotelName,
      'userEmail': userEmail,
      'bookingDate': bookingDate.toIso8601String(),
    };
  }
}
