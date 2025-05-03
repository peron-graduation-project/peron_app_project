import 'dart:io';
import 'package:dio/dio.dart';
import 'package:peron_project/features/advertisements/data/property_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final Dio _dio;

  ApiService._internal(this._dio);

  static Future<ApiService> create() async {
    final dio = Dio(BaseOptions(
      baseUrl: 'https://sakaniapi1.runasp.net/api/',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token');
        if (token != null) {
          options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ));

    return ApiService._internal(dio);
  }

  Future<void> createProperty(PropertyFormData data) async {
    try {
      final map = data.toMap();

      map['Images'] = await Future.wait(
        data.images.map((file) => MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        )),
      );

      final formData = FormData.fromMap(map);

      final response = await _dio.post(
        'Property/create',
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        print('✅ إنشاء العقار تم بنجاح');
      } else {
        throw Exception('فشل إنشاء العقار: ${response.statusCode}');
      }
    } catch (e) {
      print('خطأ أثناء رفع العقار: $e');
      rethrow;
    }
  }
}
