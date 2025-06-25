import 'package:dio/dio.dart';
import 'package:peron_project/core/utils/property_model.dart';

class PropertyApi {
  static final Dio _dio = Dio(
    BaseOptions(baseUrl: 'https://sakaniapi1.runasp.net'),
  );

  static Future<Property> getPropertyById({ required int id }) async {
    final resp = await _dio.get('/api/Property/$id');
    if (resp.statusCode == 200) {
      return Property.fromJson(resp.data as Map<String, dynamic>);
    }
    throw Exception('فشل جلب تفاصيل العقار (Status ${resp.statusCode})');
  }

  static Future<List<Property>> getAllProperties() async {
    final resp = await _dio.get('/api/Property');
    if (resp.statusCode == 200) {
      final list = List<Map<String, dynamic>>.from(resp.data as List);
      return Property.fromJsonList(list, 0);
    }
    throw Exception('فشل جلب قائمة العقارات (Status ${resp.statusCode})');
  }
}
