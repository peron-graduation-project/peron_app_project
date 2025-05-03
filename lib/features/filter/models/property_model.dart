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

  PropertyModel({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.bedrooms,
    required this.bathrooms,
    this.area,
    this.publishedDate,
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
    );
  }

  String get publishedDateFormatted {
    if (publishedDate == null) return '—';
    return DateFormat('dd/MM/yyyy').format(publishedDate!);
  }
}
