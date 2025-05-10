import 'dart:io';

import 'package:intl/intl.dart';

class PropertyFormData {
  String title = '';
  String location = '';
  String ownerId = '';
  double price = 0.0;
  String rentType = '';
  int bedrooms = 0;
  int bathrooms = 0;
  bool hasInternet = false;
  bool allowsPets = false;
  int area = 0;
  bool smokingAllowed = false;
  int floor = 0;
  bool isFurnished = false;
  bool hasBalcony = false;
  bool hasSecurity = false;
  bool hasElevator = false;
  int minBookingDays = 1;
  DateTime availableFrom = DateTime.now();
  DateTime availableTo = DateTime.now().add(Duration(days: 1));
  String description = '';
  List<File> images = [];
  double latitude = 0.0;
  double longitude = 0.0;
  List<String> selectedFeatures = [];
  String phone = '';

  PropertyFormData();

  Map<String, dynamic> toMap() {
    final dateFormat = DateFormat('yyyy-dd-MM');
    return {
      'Title': title,
      'Location': location,
      'OwnerId': ownerId,
      'Price': price,
      'RentType': rentType,
      'Bedrooms': bedrooms,
      'Bathrooms': bathrooms,
      'HasInternet': hasInternet,
      'AllowsPets': allowsPets,
      'Area': area,
      'SmokingAllowed': smokingAllowed,
      'Floor': floor,
      'IsFurnished': isFurnished,
      'HasBalcony': hasBalcony,
      'HasSecurity': hasSecurity,
      'HasElevator': hasElevator,
      'MinBookingDays': minBookingDays,
      'AvailableFrom': dateFormat.format(availableFrom),
      'AvailableTo': dateFormat.format(availableTo),
      'Description': description,
      'Latitude': latitude,
      'Longitude': longitude,
      'SelectedFeatures': selectedFeatures,
    };
  }
}
