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
  final List<Map<String, dynamic>>? ratings;
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
      propertyId: p.propertyId ?? 0,
      ownerId: p.ownerId,
      title: p.title ?? "No Title",
      location: p.location ?? "Unknown Location",
      price: p.price ?? 0.0,
      rentType: p.rentType ?? "Unknown",
      area: p.area ?? 0,
      bedrooms: p.bedrooms ?? 0,
      bathrooms: p.bathrooms ?? 0,
      floor: p.floor ?? 0,
      isFurnished: p.isFurnished ?? false,
      hasBalcony: p.hasBalcony ?? false,
      hasInternet: p.hasInternet ?? false,
      hasSecurity: p.hasSecurity ?? false,
      hasElevator: p.hasElevator ?? false,
      allowsPets: p.allowsPets ?? false,
      smokingAllowed: p.smokingAllowed ?? false,
      availableFrom: p.availableFrom ?? DateTime(1970),
      availableTo: p.availableTo ?? DateTime(1970),
      minBookingDays: p.minBookingDays ?? 1,
      averageRating: (p.ratings is List && (p.ratings as List).isNotEmpty)
          ? double.tryParse(p.ratings[0]["rating"].toString())
          : null,
      description: p.description ?? "No Description",
      images: p.images ?? [],
      ratings: p.ratings is List<Map<String, dynamic>> ? p.ratings : null,
      latitude: p.latitude,
      longitude: p.longitude,
      distance: 0,
    );
  }

  factory RecommendedProperty.fromJson(Map<String, dynamic> json) {
    return RecommendedProperty(
      propertyId: json['propertyId'] ?? 0,
      ownerId: json['ownerId'],
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
      availableFrom: json['availableFrom'] != null
          ? DateTime.tryParse(json['availableFrom']) ?? DateTime(1970)
          : DateTime(1970),
      availableTo: json['availableTo'] != null
          ? DateTime.tryParse(json['availableTo']) ?? DateTime(1970)
          : DateTime(1970),
      minBookingDays: json['minBookingDays'] ?? 1,
      averageRating: (json['averageRating'] as num?)?.toDouble(),
      description: json['description'] ?? "No Description",
      images: List<String>.from(json['images'] ?? []),
      ratings: (json['ratings'] as List?)
          ?.map((e) => Map<String, dynamic>.from(e))
          .toList(),
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
