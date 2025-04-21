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

  factory RecommendedProperty.fromJson(Map<String, dynamic> json) {
    return RecommendedProperty(
      propertyId: json['propertyId'],
      ownerId: json['ownerId'],
      title: json['title'],
      location: json['location'],
      price: (json['price'] as num).toDouble(),
      rentType: json['rentType'],
      area: json['area'],
      bedrooms: json['bedrooms'],
      bathrooms: json['bathrooms'],
      floor: json['floor'],
      isFurnished: json['isFurnished'],
      hasBalcony: json['hasBalcony'],
      hasInternet: json['hasInternet'],
      hasSecurity: json['hasSecurity'],
      hasElevator: json['hasElevator'],
      allowsPets: json['allowsPets'],
      smokingAllowed: json['smokingAllowed'],
      availableFrom: DateTime.parse(json['availableFrom']),
      availableTo: DateTime.parse(json['availableTo']),
      minBookingDays: json['minBookingDays'],
      averageRating: (json['averageRating'] as num?)?.toDouble(),
      description: json['description'],
      images: List<String>.from(json['images']),
      ratings: json['ratings'],
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      distance: (json['distance'] as num).toDouble(),
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