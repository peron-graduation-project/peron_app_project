import 'package:peron_project/features/filter/models/property_model.dart';
import 'package:peron_project/features/filter/services/api_service.dart';


class FilterApi {
  static Future<List<PropertyModel>> getFilteredProperties({
    required Map<String, dynamic> queryParams,
    required String token,
  }) async {
    try {
      final apiService = ApiService();
      final response = await apiService.filterProperties(
        queryParams,
        token: token,
      );

      if (response.statusCode == 200) {
        final data = response.data is List ? response.data as List : [];
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