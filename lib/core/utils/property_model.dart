class Property {
  final int propertyId;
  final String ownerId;
  final dynamic owner;
  final String title;
  final int area;
  final String location;
  final double price;
  final DateTime? createdAt;
  final String rentType;
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
  final String description;
  final List<dynamic> images;
  final dynamic bookings;
  final dynamic ratings;
  final double latitude;
  final double longitude;

  Property({
    required this.propertyId,
    required this.ownerId,
    this.owner,
    required this.title,
    required this.area,
    required this.location,
    required this.price,
    this.createdAt,
    required this.rentType,
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
    required this.description,
    required this.images,
    this.bookings,
    this.ratings,
    required this.latitude,
    required this.longitude,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      propertyId: json['propertyId'],
      ownerId: json['ownerId'],
      owner: json['owner'],
      title: json['title'],
      area: json['area'],
      location: json['location'],
      price: (json['price'] as num).toDouble(),
      createdAt: json['createdAt'] == null ? null : DateTime.parse(json['createdAt']),
      rentType: json['rentType'],
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
      description: json['description'],
      images: json['images'],
      bookings: json['bookings'],
      ratings: json['ratings'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'propertyId': propertyId,
      'ownerId': ownerId,
      'owner': owner,
      'title': title,
      'area': area,
      'location': location,
      'price': price,
      'createdAt': createdAt?.toIso8601String(),
      'rentType': rentType,
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
      'description': description,
      'images': images,
      'bookings': bookings,
      'ratings': ratings,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}