import 'package:peron_project/features/filter/models/property_model.dart';
import 'package:peron_project/features/filter/services/api_service.dart';

class FilterApi {
  static Future<List<PropertyModel>> getFilteredProperties({
    String? location,
    double? minPrice,
    double? maxPrice,
    String? rentType,
    int? area,
    int? bedrooms,
    int? bathrooms,
    int? floor,
    double? minRating,
    bool? isFurnished,
    bool? hasBalcony,
    bool? hasInternet,
    bool? hasSecurity,
    bool? hasElevator,
    bool? allowsPets,
    bool? smokingAllowed,
    int? minBookingDays,
    String? availableFrom,
    String? availableTo,
    required String token,
  }) async {
    try {
      final apiService = ApiService();
      final response = await apiService.filterProperties({
        if (location != null) 'Location': location,
        if (minPrice != null) 'MinPrice': minPrice,
        if (maxPrice != null) 'MaxPrice': maxPrice,
        if (rentType != null) 'RentType': rentType,
        if (area != null) 'Area': area,
        if (bedrooms != null) 'Bedrooms': bedrooms,
        if (bathrooms != null) 'Bathrooms': bathrooms,
        if (floor != null) 'Floor': floor,
        if (minRating != null) 'MinRating': minRating,
        if (isFurnished != null) 'IsFurnished': isFurnished,
        if (hasBalcony != null) 'HasBalcony': hasBalcony,
        if (hasInternet != null) 'HasInternet': hasInternet,
        if (hasSecurity != null) 'HasSecurity': hasSecurity,
        if (hasElevator != null) 'HasElevator': hasElevator,
        if (allowsPets != null) 'AllowsPets': allowsPets,
        if (smokingAllowed != null) 'SmokingAllowed': smokingAllowed,
        if (minBookingDays != null) 'MinBookingDays': minBookingDays,
        if (availableFrom != null) 'AvailableFrom': availableFrom,
        if (availableTo != null) 'AvailableTo': availableTo,
      }, token: token);

      if (response.statusCode == 200) {
        final List data = response.data is List ? response.data : [];
        return data.map((json) => PropertyModel.fromJson(json)).toList();
      } else {
        print('Status Code: ${response.statusCode}');
        print('Response: ${response.data}');
        throw Exception('فشل في تحميل العقارات: ${response.statusCode}');
      }
    } catch (e) {
      print('خطأ في API الفلترة: $e');
      rethrow;
    }
  }
}
