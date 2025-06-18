class Property {
  final int? propertyId;
  final String? ownerId;
  final dynamic owner;
  final String? title;
  final int? area;
  final String? location;
  final double? price;
  final DateTime? createdAt;
  final String? rentType;
  final int? bedrooms;
  final int? bathrooms;
  final int? floor;
  final bool? isFurnished;
  final bool? hasBalcony;
  final bool? hasInternet;
  final bool? hasSecurity;
  final bool? hasElevator;
  final bool? allowsPets;
  final bool? smokingAllowed;
  final DateTime? availableFrom;
  final DateTime? availableTo;
  final int? minBookingDays;
  final String? description;
  final List<String>? images;
  final dynamic bookings;
  final dynamic ratings;
  final double? latitude;
  final double? longitude;

  Property({
    this.propertyId,
    this.ownerId,
    this.owner,
    this.title,
    this.area,
    this.location,
    this.price,
    this.createdAt,
    this.rentType,
    this.bedrooms,
    this.bathrooms,
    this.floor,
    this.isFurnished,
    this.hasBalcony,
    this.hasInternet,
    this.hasSecurity,
    this.hasElevator,
    this.allowsPets,
    this.smokingAllowed,
    this.availableFrom,
    this.availableTo,
    this.minBookingDays,
    this.description,
    this.images,
    this.bookings,
    this.ratings,
    this.latitude,
    this.longitude,
  });

  // Factory method to create a Property object from JSON data
  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      propertyId: json['propertyId'],
      ownerId: json['ownerId'],
      owner: json['owner'],
      title: json['title'],
      area: json['area'],
      location: json['location'],
      price: json['price'] != null ? (json['price'] as num).toDouble() : null,
      createdAt:
      json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
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
      availableFrom:
      json['availableFrom'] != null
          ? DateTime.tryParse(json['availableFrom'])
          : null,
      availableTo:
      json['availableTo'] != null
          ? DateTime.tryParse(json['availableTo'])
          : null,
      minBookingDays: json['minBookingDays'],
      description: json['description'],
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      bookings: json['bookings'],
      ratings: json['ratings'],
      latitude:
      json['latitude'] != null
          ? (json['latitude'] as num).toDouble()
          : null,
      longitude:
      json['longitude'] != null
          ? (json['longitude'] as num).toDouble()
          : null,
    );
  }
  factory Property.fromJson1(Map<String, dynamic> json) {
    return Property(
      propertyId: json['propertyId'],
      ownerId: json['ownerId'],
      owner: json['owner'],
      title: json['title'],
      area: json['area'],
      location: json['location'],
      price: json['price'] != null ? (json['price'] as num).toDouble() : null,
      createdAt:
      json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
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
      availableFrom:
      json['availableFrom'] != null
          ? DateTime.tryParse(json['availableFrom'])
          : null,
      availableTo:
      json['availableTo'] != null
          ? DateTime.tryParse(json['availableTo'])
          : null,
      minBookingDays: json['minBookingDays'],
      description: json['description'],
      images:
      json['imageUrls'] != null
          ? List<String>.from(json['imageUrls'])
          : null,
      bookings: json['bookings'],
      ratings: json['ratings'],
      latitude:
      json['latitude'] != null
          ? (json['latitude'] as num).toDouble()
          : null,
      longitude:
      json['longitude'] != null
          ? (json['longitude'] as num).toDouble()
          : null,
    );
  }

  // Convert the Property object to JSON
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
      'availableFrom': availableFrom?.toIso8601String(),
      'availableTo': availableTo?.toIso8601String(),
      'minBookingDays': minBookingDays,
      'description': description,
      'images': images,
      'bookings': bookings,
      'ratings': ratings,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  static List<Property> fromJsonList(List<dynamic> jsonList, int index) {
    List<Property> properties = [];
    for (var json in jsonList) {
      properties.add(
        index == 0 ? Property.fromJson(json) : Property.fromJson1(json),
      );
    }
    print("hna fromJsonList ${properties.length}");
    return properties;
  }
}
