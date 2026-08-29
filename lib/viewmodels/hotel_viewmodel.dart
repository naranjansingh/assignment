import 'package:flutter/material.dart';

import '../data/models/hotel_model.dart';

class HotelViewModel extends ChangeNotifier {
  final List<HotelModel> _hotels = [
    HotelModel(
      id: 'h1',
      name: 'Toronto, Canada',
      location: '1155 Rue Sherbrooke Ouest, Toronto, Canada H3A 2N3',
      distance: '150KM',
      availableDates: 'OCT 24-25',
      price: 50.00,
      imageUrl: 'assets/images/hotel_1.jpg',
      hostName: 'Hosted by Trang Luxury, Lifestyle',
      hostRole: 'Host',
      rating: 4.9,
      reviews: 1848,
      address: '1155 Rue Sherbrooke Ouest, Toronto, Canada H3A 2N3',
      description:
          'Experience a comfortable and memorable stay at our hotel, where modern amenities, warm hospitality, and convenient surroundings come together. Designed for both business and leisure travelers, the hotel offers well-appointed rooms, quality facilities, and attentive service to make every stay relaxing and enjoyable.',
    ),
    HotelModel(
      id: 'h2',
      name: 'Vancouver, Canada',
      location: '123 Robson St, Vancouver, Canada V6B 2A8',
      distance: '200KM',
      availableDates: 'NOV 10-14',
      price: 75.00,
      imageUrl: 'assets/images/hotel_2.jpg',
      hostName: 'Hosted by Alice Premium',
      hostRole: 'Host',
      rating: 4.8,
      reviews: 1205,
      address: '123 Robson St, Vancouver, Canada V6B 2A8',
      description:
          'Relax in the heart of downtown Vancouver with breathtaking views of the city and mountains. Enjoy luxury accommodations and world-class service.',
    ),
  ];

  List<HotelModel> get hotels => _hotels;

  HotelModel? _selectedHotel;
  HotelModel? get selectedHotel => _selectedHotel;

  void selectHotel(HotelModel hotel) {
    _selectedHotel = hotel;
    notifyListeners();
  }
}
