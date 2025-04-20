import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://sakaniapi1.runasp.net/api/',
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10),
  ));

  Future<Response> filterProperties(
    Map<String, dynamic> queryParams, {
    required String token,
  }) async {
    try {
      final response = await _dio.get(
        'Property/filter',
        queryParameters: queryParams,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response;
    } catch (e) {
      throw Exception('فشل الاتصال بالسيرفر: $e');
    }
  }
}
