class HotelModel {
  final String id;
  final String name;
  final String location;
  final String distance;
  final String availableDates;
  final double price;
  final String imageUrl;
  final String hostName;
  final String hostRole;
  final double rating;
  final int reviews;
  final String address;
  final String description;

  HotelModel({
    required this.id,
    required this.name,
    required this.location,
    required this.distance,
    required this.availableDates,
    required this.price,
    required this.imageUrl,
    required this.hostName,
    required this.hostRole,
    required this.rating,
    required this.reviews,
    required this.address,
    required this.description,
  });
}
