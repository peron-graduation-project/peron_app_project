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

  PropertyFormData copyWith({
    String? title,
    String? location,
    String? ownerId,
    double? price,
    String? rentType,
    int? bedrooms,
    int? bathrooms,
    bool? hasInternet,
    bool? allowsPets,
    int? area,
    bool? smokingAllowed,
    int? floor,
    bool? isFurnished,
    bool? hasBalcony,
    bool? hasSecurity,
    bool? hasElevator,
    int? minBookingDays,
    DateTime? availableFrom,
    DateTime? availableTo,
    String? description,
    List<File>? images,
    double? latitude,
    double? longitude,
    List<String>? selectedFeatures,
    String? phone,
  }) {
    return PropertyFormData()
      ..title = title ?? this.title
      ..location = location ?? this.location
      ..ownerId = ownerId ?? this.ownerId
      ..price = price ?? this.price
      ..rentType = rentType ?? this.rentType
      ..bedrooms = bedrooms ?? this.bedrooms
      ..bathrooms = bathrooms ?? this.bathrooms
      ..hasInternet = hasInternet ?? this.hasInternet
      ..allowsPets = allowsPets ?? this.allowsPets
      ..area = area ?? this.area
      ..smokingAllowed = smokingAllowed ?? this.smokingAllowed
      ..floor = floor ?? this.floor
      ..isFurnished = isFurnished ?? this.isFurnished
      ..hasBalcony = hasBalcony ?? this.hasBalcony
      ..hasSecurity = hasSecurity ?? this.hasSecurity
      ..hasElevator = hasElevator ?? this.hasElevator
      ..minBookingDays = minBookingDays ?? this.minBookingDays
      ..availableFrom = availableFrom ?? this.availableFrom
      ..availableTo = availableTo ?? this.availableTo
      ..description = description ?? this.description
      ..images = images ?? this.images
      ..latitude = latitude ?? this.latitude
      ..longitude = longitude ?? this.longitude
      ..selectedFeatures = selectedFeatures ?? this.selectedFeatures
      ..phone = phone ?? this.phone;
  }

  /// Convert form data to a map matching backend expectations
  Map<String, dynamic> toMap() {
    final dateFormat = DateFormat('yyyy-MM-dd');
    return {
      'title': title,
      'location': location,
      'ownerId': ownerId,
      'price': price,
      'rentType': rentType,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'hasInternet': hasInternet,
      'allowsPets': allowsPets,
      'area': area,
      'smokingAllowed': smokingAllowed,
      'floor': floor,
      'isFurnished': isFurnished,
      'hasBalcony': hasBalcony,
      'hasSecurity': hasSecurity,
      'hasElevator': hasElevator,
      'minBookingDays': minBookingDays,
      'availableFrom': dateFormat.format(availableFrom),
      'availableTo': dateFormat.format(availableTo),
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'selectedFeatures': selectedFeatures,
      'phone': phone,
      'images': images.map((file) => file.path).toList(),
    };
  }
}
