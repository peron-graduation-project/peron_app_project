import 'package:intl/intl.dart';

class PropertyModel {
  final int id;
  final String title;
  final String location;
  final int price;
  final int bedrooms;
  final int bathrooms;
  final int? area;
  final DateTime? publishedDate;
  final List<String>? images;


  final String? rentType;
  final int? floor;
  final double? minRating;
  final bool? isFurnished;
  final bool? hasBalcony;
  final bool? hasInternet;
  final bool? hasSecurity;
  final bool? hasElevator;
  final bool? allowsPets;
  final bool? smokingAllowed;
  final int? minBookingDays;
  final DateTime? availableFrom;
  final DateTime? availableTo;

  PropertyModel({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.bedrooms,
    required this.bathrooms,
    this.area,
    this.publishedDate,
    this.rentType,
    this.floor,
    this.minRating,
    this.isFurnished,
    this.hasBalcony,
    this.hasInternet,
    this.hasSecurity,
    this.hasElevator,
    this.allowsPets,
    this.smokingAllowed,
    this.minBookingDays,
    this.availableFrom,
    this.availableTo,
     this.images,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      location: json['location'] ?? '',
      price: json['price'] is double
          ? (json['price'] as double).toInt()
          : (json['price'] ?? 0),
      bedrooms: json['bedrooms'] ?? 0,
      bathrooms: json['bathrooms'] ?? 0,
      area: json['area'] != null ? (json['area'] as num).toInt() : null,
      publishedDate: json['publishedDate'] != null
          ? DateTime.tryParse(json['publishedDate'])
          : null,

      rentType: json['rentType'],
      floor: json['floor'],
      minRating: json['minRating'] != null ? (json['minRating'] as num).toDouble() : null,
      isFurnished: json['isFurnished'],
      hasBalcony: json['hasBalcony'],
      hasInternet: json['hasInternet'],
      hasSecurity: json['hasSecurity'],
      hasElevator: json['hasElevator'],
      allowsPets: json['allowsPets'],
      smokingAllowed: json['smokingAllowed'],
      minBookingDays: json['minBookingDays'],
      availableFrom: json['availableFrom'] != null
          ? DateTime.tryParse(json['availableFrom'])
          : null,
      availableTo: json['availableTo'] != null
          ? DateTime.tryParse(json['availableTo'])
          : null,
          images: (json['images'] as List?)?.map((e) => e.toString()).toList(),
    );
  }

  String get publishedDateFormatted {
    if (publishedDate == null) return '—';
    return DateFormat('dd/MM/yyyy').format(publishedDate!);
  }
}
