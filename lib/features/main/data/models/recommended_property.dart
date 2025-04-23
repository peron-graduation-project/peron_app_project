import 'package:peron_project/core/utils/property_model.dart';

class RecommendedProperty {
  final int propertyId;
  final String? ownerId;
  final String title;
  final String location;
  final double price;
  final String rentType;
  final int area;
  final int bedrooms;
  final int bathrooms;
  final int floor;
  final bool isFurnished;
  final bool hasBalcony;
  final bool hasInternet;
  final bool hasSecurity;
  final bool hasElevator;
  final bool allowsPets;
  final bool smokingAllowed;
  final DateTime availableFrom;
  final DateTime availableTo;
  final int minBookingDays;
  final double? averageRating;
  final String description;
  final List<String> images;
  final dynamic ratings;
  final double? latitude;
  final double? longitude;
  final double distance;

  RecommendedProperty({
    required this.propertyId,
    this.ownerId,
    required this.title,
    required this.location,
    required this.price,
    required this.rentType,
    required this.area,
    required this.bedrooms,
    required this.bathrooms,
    required this.floor,
    required this.isFurnished,
    required this.hasBalcony,
    required this.hasInternet,
    required this.hasSecurity,
    required this.hasElevator,
    required this.allowsPets,
    required this.smokingAllowed,
    required this.availableFrom,
    required this.availableTo,
    required this.minBookingDays,
    this.averageRating,
    required this.description,
    required this.images,
    this.ratings,
    this.latitude,
    this.longitude,
    required this.distance,
  });
factory RecommendedProperty.fromProperty(Property p) {
  return RecommendedProperty(
    propertyId: p.propertyId,
    ownerId: p.ownerId,
    title: p.title,
    location: p.location,
    price: p.price,
    rentType: p.rentType,
    area: p.area,
    bedrooms: p.bedrooms,
    bathrooms: p.bathrooms,
    floor: p.floor,
    isFurnished: p.isFurnished,
    hasBalcony: p.hasBalcony,
    hasInternet: p.hasInternet,
    hasSecurity: p.hasSecurity,
    hasElevator: p.hasElevator,
    allowsPets: p.allowsPets,
    smokingAllowed: p.smokingAllowed,
    availableFrom: p.availableFrom,
    availableTo: p.availableTo,
    minBookingDays: p.minBookingDays,
    averageRating: p.ratings,
    description: p.description,
    images: p.images.map((img) => img.toString()).toList(), 
    ratings: p.ratings,
    latitude: p.latitude,
    longitude: p.longitude,
    distance: 0, 
  );
}
factory RecommendedProperty.fromJson(Map<String, dynamic> json) {
  print("📦 JSON INPUT: $json"); 
  return RecommendedProperty(
    propertyId: json['propertyId'] ?? 0, 
    ownerId: json['ownerId'] ?? "", 
    title: json['title'] ?? "No Title", 
    location: json['location'] ?? "Unknown Location", 
    price: (json['price'] as num?)?.toDouble() ?? 0.0, 
    rentType: json['rentType'] ?? "Unknown", 
    area: json['area'] ?? 0, 
    bedrooms: json['bedrooms'] ?? 0, 
    bathrooms: json['bathrooms'] ?? 0, 
    floor: json['floor'] ?? 0, 
    isFurnished: json['isFurnished'] ?? false, 
    hasBalcony: json['hasBalcony'] ?? false, 
    hasInternet: json['hasInternet'] ?? false, 
    hasSecurity: json['hasSecurity'] ?? false, 
    hasElevator: json['hasElevator'] ?? false, 
    allowsPets: json['allowsPets'] ?? false, 
    smokingAllowed: json['smokingAllowed'] ?? false, 
    availableFrom: DateTime.parse(json['availableFrom'] ?? "1970-01-01"),
    availableTo: DateTime.parse(json['availableTo'] ?? "1970-01-01"), 
    minBookingDays: json['minBookingDays'] ?? 1, 
    averageRating: (json['averageRating'] as num?)?.toDouble(), 
    description: json['description'] ?? "No Description", 
    images: List<String>.from(json['images'] ?? []), 
    latitude: (json['latitude'] as num?)?.toDouble(), 
    longitude: (json['longitude'] as num?)?.toDouble(),
    distance: (json['distance'] as num?)?.toDouble() ?? 0.0, 
  );
}




  Map<String, dynamic> toJson() {
    return {
      'propertyId': propertyId,
      'ownerId': ownerId,
      'title': title,
      'location': location,
      'price': price,
      'rentType': rentType,
      'area': area,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'floor': floor,
      'isFurnished': isFurnished,
      'hasBalcony': hasBalcony,
      'hasInternet': hasInternet,
      'hasSecurity': hasSecurity,
      'hasElevator': hasElevator,
      'allowsPets': allowsPets,
      'smokingAllowed': smokingAllowed,
      'availableFrom': availableFrom.toIso8601String(),
      'availableTo': availableTo.toIso8601String(),
      'minBookingDays': minBookingDays,
      'averageRating': averageRating,
      'description': description,
      'images': images,
      'ratings': ratings,
      'latitude': latitude,
      'longitude': longitude,
      'distance': distance,
    };
  }
}