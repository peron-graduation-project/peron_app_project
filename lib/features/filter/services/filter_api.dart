import 'package:peron_project/core/utils/property_model.dart';
import 'package:peron_project/features/filter/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FilterApi {
  static Future<List<Property>> getFilteredProperties({
    required Map<String, dynamic> queryParams,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    final api = ApiService();
    final response = await api.filterProperties(
      queryParams,
      token: token,
    );

    if (response.statusCode == 200 && response.data is List) {
      return (response.data as List)
          .map((json) => Property.fromJson(json))
          .toList();
    } else {
      throw Exception(
        'فشل في تحميل العقارات: ${response.statusCode} ${response.data}',
      );
    }
  }
}
