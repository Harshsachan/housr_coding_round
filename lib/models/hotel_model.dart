class Hotel {
  final String id;
  final String name;
  final String location;
  final int price;
  final int stars;
  final List<String> amenities;
  final List<String> roomTypes;
  final List<Rating> ratings;
  final String image;

  Hotel({
    required this.id,
    required this.name,
    required this.location,
    required this.price,
    required this.stars,
    required this.amenities,
    required this.roomTypes,
    required this.ratings,
    required this.image,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      price: json['price'],
      stars: json['stars'],
      amenities: List<String>.from(json['amenities']),
      roomTypes: List<String>.from(json['roomTypes']),
      ratings: List<Rating>.from(json['ratings'].map((x) => Rating.fromJson(x))),
      image: json['image'],
    );
  }
  double calculateAverageRating() {
    if (ratings.isEmpty) return 0.0;

    double totalRating = ratings.fold(0.0, (sum, rating) => sum + rating.rating);
    return totalRating / ratings.length;
  }
}

class Rating {
  final String userName;
  final int rating;
  final String review;

  Rating({
    required this.userName,
    required this.rating,
    required this.review,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      userName: json['userName'],
      rating: json['rating'],
      review: json['review'],
    );
  }

}
