class PropertyModel {
  final int id;
  final String title;
  final String location;
  final int price; 
  final int bedrooms;
  final int bathrooms;

  PropertyModel({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.bedrooms,
    required this.bathrooms,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      location: json['location'] ?? '',
      price: json['price'] is double
          ? (json['price'] as double).toInt()
          : json['price'] ?? 0,
      bedrooms: json['bedrooms'] ?? 0,
      bathrooms: json['bathrooms'] ?? 0,
    );
  }
}
