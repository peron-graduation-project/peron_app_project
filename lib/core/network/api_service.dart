import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peron_project/features/notification/data/notification_model.dart';
import '../../../../core/error/failure.dart';

class ApiService {
  final String _baseUrl = 'https://sakaniapi1.runasp.net/api';
  final Dio _dio;

  ApiService(this._dio) {
    _dio.options.baseUrl = _baseUrl;
  }

  void _printDebugInfo({
    required String functionName,
    Response? response,
    DioException? error,
  }) {
    print('========== $functionName ==========');
    if (response != null) {
      print('Request URL: ${response.requestOptions.uri}');
      print('Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');
    }
    if (error != null) {
      print('Dio Error: ${error.message}');
      if (error.response != null) {
        print('Error Response Code: ${error.response?.statusCode}');
        print('Error Response Data: ${error.response?.data}');
      }
    }
  }

  Future<Either<Failure, String>> sendOtp(String email) async {
    try {
      Response response = await _dio.post('/Auth/Send-Otp', data: {"email": email});
      _printDebugInfo(functionName: 'sendOtp', response: response);
      return Right(response.data["message"] ?? "OTP أُرسل بنجاح");
    } on DioException catch (e) {
      _printDebugInfo(functionName: 'sendOtp', error: e);
      return Left(ServiceFailure.fromDioError(e));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> signup({required Map<String, dynamic> body}) async {
    try {
      Response response = await _dio.post('/Auth/register', data: body);
      _printDebugInfo(functionName: 'signup', response: response);
      return Right(response.data);
    } on DioException catch (e) {
      _printDebugInfo(functionName: 'signup', error: e);
      return Left(ServiceFailure.fromDioError(e));
    }
  }

  Future<Either<Failure, bool>> verifyOtp({required String email, required String otpCode}) async {
    try {
      debugPrint("📩 إرسال طلب تحقق إلى API...");
      debugPrint("🔹 Email: $email");
      debugPrint("🔹 OTP Code: $otpCode");

      Response response = await _dio.post(
        '/Auth/Verify-Otp-ForConfirmedEmail',
        data: {"email": email.toLowerCase(), "otpCode": otpCode},
      );

      _printDebugInfo(functionName: 'verifyOtp', response: response);
      return Right(response.data["isAuthenticated"] ?? false);
    } on DioException catch (e) {
      _printDebugInfo(functionName: 'verifyOtp', error: e);
      return Left(ServiceFailure.fromDioError(e));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> login({
    required String email,
    required String password,
  }) async {
    try {
      debugPrint("📩 إرسال طلب تسجيل الدخول إلى API...");
      debugPrint("🔹 Email: $email");
      debugPrint("🔹 Password: $password");

      Response response = await _dio.post(
        '/Auth/login',
        data: {
          "email": email,
          "password": password,
        },
      );

      _printDebugInfo(functionName: 'login', response: response);

      if (response.data["isAuthenticated"] == true) {
        return Right(response.data as Map<String, dynamic>);
      } else {
        return Left(ServiceFailure(
          errorMessage: response.data["message"] ?? "خطأ في بيانات الدخول",
          errors: [],
        ));
      }
    } on DioException catch (e) {
      _printDebugInfo(functionName: 'login', error: e);
      return Left(ServiceFailure.fromDioError(e));
    } catch (e) {
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع: $e",
        errors: [e.toString()],
      ));
    }
  }


  Future<Either<Failure, List<NotificationModel>>> getNotifications({required String endPoint, Map<String, dynamic>? queryParameters}) async {
    try {
      Response response = await _dio.get(endPoint, queryParameters: queryParameters);
      _printDebugInfo(functionName: 'getNotifications', response: response);

      if (response.data is List) {
        List<NotificationModel> notifications = (response.data as List)
            .map((json) => NotificationModel.fromJson(json))
            .toList();
        return Right(notifications);
      } else {
        return Left(ServiceFailure(errorMessage: "البيانات المستلمة غير صحيحة", errors: ["توقعنا قائمة، ولكن استلمنا نوعًا مختلفًا"]));
      }
    } on DioException catch (e) {
      _printDebugInfo(functionName: 'getNotifications', error: e);
      return Left(ServiceFailure.fromDioError(e));
    } catch (e) {
      return Left(ServiceFailure(errorMessage: "حدث خطأ أثناء معالجة الإشعارات", errors: [e.toString()]));
    }
  }

  Future<Either<Failure, bool>> deleteNotifications({required String endPoint, required List<String> ids}) async {
    try {
      Response response = await _dio.delete(endPoint, data: {"ids": ids});
      _printDebugInfo(functionName: 'deleteNotifications', response: response);
      return Right(response.statusCode == 200 || response.statusCode == 204);
    } on DioException catch (e) {
      _printDebugInfo(functionName: 'deleteNotifications', error: e);
      return Left(ServiceFailure.fromDioError(e));
    }
  }
}
