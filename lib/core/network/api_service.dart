import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peron_project/features/chatPot/data/chat_pot_model.dart';
import 'package:peron_project/features/chats/data/models/chat_model.dart';
import 'package:peron_project/features/main/data/models/recommended_property.dart';
import 'package:peron_project/features/notification/data/notification_model.dart';
import 'package:peron_project/features/profile/data/models/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import '../../../../core/error/failure.dart';
import '../../features/advertisements/data/property_model.dart';
import '../../features/chats/data/models/message_model.dart';
import '../../features/detailsAboutProperty/presentation/view/views/models/rate.dart';
import '../../features/detailsAboutProperty/presentation/view/views/models/rate_param.dart';
import '../../features/profile/data/models/inquiry_model.dart';
import '../utils/property_model.dart';

class ApiService {
  final String _baseUrl = 'https://sakaniapi1.runasp.net/api';
  final Dio _dio;
  late CookieManager _cookieManager;

  ApiService(this._dio) {
    _dio.options.baseUrl = _baseUrl;
    _cookieManager = CookieManager(CookieJar());
    _dio.interceptors.add(_cookieManager);
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
  Future<Either<Failure, bool>> checkOtp({required String email, required String otpCode}) async {
    try {
      debugPrint("📩 إرسال طلب تحقق إلى API...");
      debugPrint("🔹 Email: $email");
      debugPrint("🔹 OTP Code: $otpCode");

      Response response = await _dio.post(
        '/Auth/Check-Otp-For-ResetPassword',
        data: {"email": email.toLowerCase(), "otpCode": otpCode},
      );

      _printDebugInfo(functionName: 'checkOtp', response: response);
      return Right(response.data["isAuthenticated"] ?? false);
    } on DioException catch (e) {
      _printDebugInfo(functionName: 'checkOtp', error: e);
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
      debugPrint("إرسال طلب تسجيل الدخول إلى API..");
      debugPrint("🔹 Email: $email");

      Response response = await _dio.post(
        '/Auth/login',
        data: {
          "email": email,
          "password": password,
        },
      );

      _printDebugInfo(functionName: 'login', response: response);

      if (response.data["isAuthenticated"] == true) {
        final token = response.data['token'];

        final prefs = await SharedPreferences.getInstance();
        bool isTokenSaved = await prefs.setString('token', token);

        if (isTokenSaved) {
          return Right(response.data as Map<String, dynamic>);
        } else {
          return Left(ServiceFailure(
            errorMessage: "فشل في حفظ التوكين",
            errors: [],
          ));
        }
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

  Future<Either<Failure, Map<String, dynamic>>> refreshToken({required String token}) async {
    try {
      final response = await _dio.post(
        '/Auth/refresh-token',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print("✅ [DEBUG] Refresh Token API Response: ${response.data}");

      if (response.data is Map<String, dynamic>) {
        final prefs = await SharedPreferences.getInstance();

        final newToken = response.data['token'];
        await prefs.setString('token', newToken);

        return Right(response.data as Map<String, dynamic>);
      } else {
        return Left(ServiceFailure(
          errorMessage: "استجابة غير متوقعة من الخادم",
          errors: [response.data.toString()],
        ));
      }
    } on DioException catch (e) {
      print("❌ [DEBUG] Dio Error: $e");

      final failure = ServiceFailure.fromDioError(e);
      return Left(failure);
    } catch (e) {
      print("❗ [DEBUG] Unexpected Error in ApiService: $e");

      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء تجديد التوكن",
        errors: [e.toString()],
      ));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> resetPassword(
      Map<String, dynamic> body,
      ) async {
    try {
      final response = await _dio.post(
        '/Auth/reset-password',
        data: body,
      );

      print("✅ [DEBUG] Forgot Password API Response: ${response.data}");

      if (response.data is Map<String, dynamic>) {
        return Right(response.data as Map<String, dynamic>);
      } else {
        return Left(ServiceFailure(
          errorMessage: "استجابة غير متوقعة من الخادم",
          errors: [response.data.toString()],
        ));
      }
    } on DioException catch (e) {
      print("❌ [DEBUG] Dio Error: $e");

      final failure = ServiceFailure.fromDioError(e);
      return Left(failure);
    } catch (e) {
      print("❗ [DEBUG] Unexpected Error in ApiService: $e");

      return Left(ServiceFailure(
        errorMessage: "حدث خطأ أثناء الاتصال بالسيرفر",
        errors: [e.toString()],
      ));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> forgotPassword({
    required String email,
  }) async {
    try {
      final response = await _dio.post(
        '/Auth/forgot-password',
        data: {
          "email": email,
        },
      );

      print(" [DEBUG] Forgot Password API Response: ${response.data}");

      return Right(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      print(" [DEBUG] Dio Error: $e");

      return Left(ServiceFailure.fromDioError(e));
    } catch (e) {
      print(" [DEBUG] Unexpected Error in ApiService: $e");

      return Left(ServiceFailure(
        errorMessage: "حدث خطأ أثناء الاتصال بالسيرفر",
        errors: [e.toString()],
      ));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> logout({required String token}) async {
    try {
      final response = await _dio.post(
        '/Auth/logout',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print("✅ [DEBUG] Logout API Response: ${response.data}");

      if (response.data is Map<String, dynamic>) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('token');
        return Right(response.data as Map<String, dynamic>);
      } else {
        return Left(ServiceFailure(
          errorMessage: "استجابة غير متوقعة من الخادم",
          errors: [response.data.toString()],
        ));
      }
    } on DioException catch (e) {
      print("❌ [DEBUG] Dio Error: $e");

      final failure = ServiceFailure.fromDioError(e);
      return Left(failure);
    } catch (e) {
      print("❗ [DEBUG] Unexpected Error in ApiService: $e");

      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء تسجيل الخروج",
        errors: [e.toString()],
      ));
    }
  }
  Future<Either<Failure, ProfileModel>> getProfile({required String token}) async {
    try {
      final response = await _dio.get(
        '/Profile/me',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Cache-Control': 'no-cache'
          },
        ),
      );
      print("✅ [DEBUG] Get Profile API Response: ${response.data}");
      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        return Right(ProfileModel.fromJson(response.data));
      } else {
        return Left(ServiceFailure(errorMessage: "فشل في استرجاع بيانات البروفايل: استجابة غير متوقعة", errors: [response.data.toString()]));
      }
    } on DioException catch (e) {
      print("❌ [DEBUG] Dio Error (Get Profile): $e");
      return Left(ServiceFailure.fromDioError(e));
    } catch (e) {
      print("❗ [DEBUG] Unexpected Error in getProfile: $e");
      return Left(ServiceFailure(errorMessage: "حدث خطأ غير متوقع أثناء جلب بيانات البروفايل", errors: [e.toString()]));
    }
  }
  Future<Either<Failure, Map<String, dynamic>>> addFavorite({
    required String token,
    required int id,
  }) async {
    try {

      final response = await _dio.post(
        '/Favorites/add/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          "propertyId": id,
        },
      );

      print("✅ [DEBUG] Post Favorite API Response: ${response.data}");
      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        return Right(response.data as Map<String, dynamic>);
      } else {

        return Left(ServiceFailure(
          errorMessage: "فشل في استرجاع بيانات المفضلة: استجابة غير متوقعة",
          errors: [response.data.toString()],
        ));
      }
    } on DioException catch (e) {

      print("❌ [DEBUG] Dio Error (post Favorite): $e");
      return Left(ServiceFailure.fromDioError(e));
    } catch (e) {

      print("❗️ [DEBUG] Unexpected Error in postFavorite: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء جلب بيانات المفضلة",
        errors: [e.toString()],
      ));
    }
  }
  Future<Either<Failure, List<NotificationModel>>> getNotification({required String token}) async {
    try {
      final response = await _dio.get(
        '/Notifications',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print("✅ [DEBUG] Get Notifications API Response: ${response.data}");

      if (response.data is List) {
        final List<NotificationModel> notifications = (response.data as List)
            .map((json) => NotificationModel.fromJson(json as Map<String, dynamic>))
            .toList();
        return Right(notifications);
      } else {
        return Left(ServiceFailure(
          errorMessage: "استجابة غير متوقعة من الخادم عند جلب الإشعارات",
          errors: [response.data.toString()],
        ));
      }
    } on DioException catch (e) {
      print("❌ [DEBUG] Dio Error أثناء جلب الإشعارات: $e");
      final failure = ServiceFailure.fromDioError(e);
      return Left(failure);
    } catch (e) {
      print("❗ [DEBUG] خطأ غير متوقع أثناء جلب الإشعارات في ApiService: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء جلب الإشعارات",
        errors: [e.toString()],
      ));
    }
  }  Future<Either<Failure, bool>> deleteNotification({required String token, required int id}) async {
    try {
      final response = await _dio.delete(
        '/Notifications/Delete/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          'id': id,
        },
      );

      print("✅ [DEBUG] Delete Notification API Response: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 204) {
        return const Right(true);
      } else {
        return Left(ServiceFailure(
          errorMessage: "فشل حذف الإشعار. كود الحالة: ${response.statusCode}",
          errors: [response.data.toString()],
        ));
      }
    } on DioException catch (e) {
      print("❌ [DEBUG] Dio Error أثناء حذف الإشعار: $e");
      final failure = ServiceFailure.fromDioError(e);
      return Left(failure);
    } catch (e) {
      print("❗ [DEBUG] خطأ غير متوقع أثناء حذف الإشعار في ApiService: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء حذف الإشعار",
        errors: [e.toString()],
      ));
    }
  }
  Future<Either<Failure, List<RecommendedProperty>>> getRecommendedProperty() async {
    try {
      final response = await _dio.get(
          '/Rating/most-rating',
      );

      print("✅ [DEBUG] get Recommended Property API Response: ${response.data}");

      if (response.data is List) {
        final List<RecommendedProperty> properties = (response.data as List)
            .map((json) => RecommendedProperty.fromJson(json as Map<String, dynamic>))
            .toList();
        return Right(properties);
      } else {
        return Left(ServiceFailure(
          errorMessage: "استجابة غير متوقعة من الخادم عند جلب الشقق المقترحة",
          errors: [response.data.toString()],
        ));
      }
    } on DioException catch (e) {
      print("❌ [DEBUG] Dio Error أثناء جلب الشقق المقترحة: $e");
      final failure = ServiceFailure.fromDioError(e);
      return Left(failure);
    } catch (e) {
      print("❗ [DEBUG] خطأ غير متوقع أثناء جلب الشقق المقترحة في ApiService: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء جلب الشقق المقترحة",
        errors: [e.toString()],
      ));
    }
  }
  Future<Either<Failure, List<RecommendedProperty>>> getMostAreaProperty({ int? top}) async {
    try {
      final response = await _dio.get(
        '/Rating/most-area?top=$top',
          data: {
            "top":top??10
          },

      );

      print("✅ [DEBUG] get Most Area Property API Response: ${response.data}");

      if (response.data is List) {
        final List<RecommendedProperty> properties = (response.data as List)
            .map((json) => RecommendedProperty.fromJson(json as Map<String, dynamic>))
            .toList();
        return Right(properties);
      } else {
        return Left(ServiceFailure(
          errorMessage: "استجابة غير متوقعة من الخادم عند جلب الشقق الأكثر مساحة",
          errors: [response.data.toString()],
        ));
      }
    } on DioException catch (e) {
      print("❌ [DEBUG] Dio Error أثناء جلب الشقق الأكثر مساحة: $e");
      final failure = ServiceFailure.fromDioError(e);
      return Left(failure);
    } catch (e) {
      print("❗ [DEBUG] خطأ غير متوقع أثناء جلب الشقق الأكثر مساحة في ApiService: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء جلب الشقق الأكثر مساحة",
        errors: [e.toString()],
      ));
    }
  }
  Future<Either<Failure, List<RecommendedProperty>>> getHighestPriceProperty() async {
    try {
      final response = await _dio.get(
        '/Rating/highest-price',
      );

      print("✅ [DEBUG] get Highest Price Property API Response: ${response.data}");

      if (response.data is List) {
        final List<RecommendedProperty> properties = (response.data as List)
            .map((json) => RecommendedProperty.fromJson(json as Map<String, dynamic>))
            .toList();
        return Right(properties);
      } else {
        return Left(ServiceFailure(
          errorMessage: "استجابة غير متوقعة من الخادم عند جلب الشقق الأعلى في السعر",
          errors: [response.data.toString()],
        ));
      }
    } on DioException catch (e) {
      print("❌ [DEBUG] Dio Error أثناء جلب الشقق الأعلى في السعر : $e");
      final failure = ServiceFailure.fromDioError(e);
      return Left(failure);
    } catch (e) {
      print("❗ [DEBUG] خطأ غير متوقع أثناء جلب الشقق الأعلى في السعر   ApiService: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء جلب الشقق الأعلى في السعر ",
        errors: [e.toString()],
      ));
    }
  }
  Future<Either<Failure, List<RecommendedProperty>>> getLowestPriceProperty() async {
    try {
      final response = await _dio.get(
        '/Rating/lowest-price',
      );

      print("✅ [DEBUG] get Lowest Price Property API Response: ${response.data}");

      if (response.data is List) {
        final List<RecommendedProperty> properties = (response.data as List)
            .map((json) => RecommendedProperty.fromJson(json as Map<String, dynamic>))
            .toList();
        return Right(properties);
      } else {
        return Left(ServiceFailure(
          errorMessage: "استجابة غير متوقعة من الخادم عند جلب الشقق الأقل في السعر",
          errors: [response.data.toString()],
        ));
      }
    } on DioException catch (e) {
      print("❌ [DEBUG] Dio Error أثناء جلب الشقق الأقل في السعر : $e");
      final failure = ServiceFailure.fromDioError(e);
      return Left(failure);
    } catch (e) {
      print("❗ [DEBUG] خطأ غير متوقع أثناء جلب الشقق الأقل في السعر   ApiService: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء جلب الشقق الأقل في السعر ",
        errors: [e.toString()],
      ));
    }
  }
  Future<Either<Failure, List<RecommendedProperty>>> getFavoriteProperties({
    required String token,
  }) async {
    try {
      final response = await _dio.get(
          '/Favorites/user-favorites',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
      );

      print("✅ [DEBUG] get Favorite API Response: ${response.data}");

      if (response.data is List) {
        final List<RecommendedProperty> properties = (response.data as List)
            .map((json) => RecommendedProperty.fromJson(json as Map<String, dynamic>))
            .toList();
        return Right(properties);
      } else {
        return Left(ServiceFailure(
          errorMessage: "استجابة غير متوقعة من الخادم عند جلب الشقق المفضلة",
          errors: [response.data.toString()],
        ));
      }
    } on DioException catch (e) {
      print("❌ [DEBUG] Dio Error أثناء جلب الشقق المفضلة: $e");
      final failure = ServiceFailure.fromDioError(e);
      return Left(failure);
    } catch (e) {
      print("❗ [DEBUG] خطأ غير متوقع أثناء جلب الشقق المفضلة في ApiService: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء جلب الشقق المفضلة",
        errors: [e.toString()],
      ));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> deleteFavorite({
  required String token,
  required int id,
}) async {
  try {

    final response = await _dio.delete(
      '/Favorites/remove/$id',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
      data: {
        "propertyId": id,
      },
    );


    print("✅ [DEBUG] delete Favorite API Response: ${response.data}");


    if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
      return Right(response.data as Map<String, dynamic>);
    } else {

      return Left(ServiceFailure(
        errorMessage: "فشل في استرجاع بيانات المفضلة: استجابة غير متوقعة",
        errors: [response.data.toString()],
      ));
    }
  } on DioException catch (e) {

    print("❌ [DEBUG] Dio Error (delete Favorite): $e");
    return Left(ServiceFailure.fromDioError(e));
  } catch (e) {

    print("❗ [DEBUG] Unexpected Error in deleteFavorite: $e");
    return Left(ServiceFailure(
      errorMessage: "حدث خطأ غير متوقع أثناء جلب بيانات المفضلة",
      errors: [e.toString()],
    ));
  }
}
  Future<Either<Failure, List<Message>>> getChatConversation({
    required String token,
    required String id,

  }) async {
    try {
      final response = await _dio.get(
        '/Chat/conversation/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print("✅ [DEBUG] get Chat Conversation API Response: ${response.data}");

      if (response.data is List) {
        final List<Message> messages = (response.data as List)
            .map((json) => Message.fromJson(json as Map<String, dynamic>))
            .toList();
        return Right(messages);
      } else {
        return Left(ServiceFailure(
          errorMessage: "استجابة غير متوقعة من الخادم عند جلب المحادثة ",
          errors: [response.data.toString()],
        ));
      }
    } on DioException catch (e) {
      print("❌ [DEBUG] Dio Error أثناء جلب المحادثة : $e");
      final failure = ServiceFailure.fromDioError(e);
      return Left(failure);
    } catch (e) {
      print("❗ [DEBUG] خطأ غير متوقع أثناء جلب المحادثة  في ApiService: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء جلب المحادثة ",
        errors: [e.toString()],
      ));
    }
  }
  Future<Either<Failure, List<ChatModel>>> getChats({
    required String token,
  }) async {
    try {
      final response = await _dio.get(
        '/Chat/chats',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print("✅ [DEBUG] get Chats  API Response: ${response.data}");

      if (response.data is List) {
        final List<ChatModel> chats = (response.data as List)
            .map((json) => ChatModel.fromJson(json as Map<String, dynamic>))
            .toList();
        return Right(chats);
      } else {
        return Left(ServiceFailure(
          errorMessage: "استجابة غير متوقعة من الخادم عند جلب المحادثات ",
          errors: [response.data.toString()],
        ));
      }
    } on DioException catch (e) {
      print("❌ [DEBUG] Dio Error أثناء جلب المحادثات : $e");
      final failure = ServiceFailure.fromDioError(e);
      return Left(failure);
    } catch (e) {
      print("❗ [DEBUG] خطأ غير متوقع أثناء جلب المحادثات  في ApiService: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء جلب المحادثات ",
        errors: [e.toString()],
      ));
    }
  }
  Future<Either<Failure, Map<String, dynamic>>> sendMessage({
    required String token,
    required String id,
    required String message,

  }) async {
    try {

      final response = await _dio.post(
        '/Chat/send',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          "receiverId": id,
          "message":message,
        },
      );


      print("✅ [DEBUG] send Message API Response: ${response.data}");


      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        return Right(response.data as Map<String, dynamic>);
      } else {

        return Left(ServiceFailure(
          errorMessage: "فشل في إرسال الرسالة: استجابة غير متوقعة",
          errors: [response.data.toString()],
        ));
      }
    } on DioException catch (e) {

      print("❌ [DEBUG] Dio Error (send message): $e");
      return Left(ServiceFailure.fromDioError(e));
    } catch (e) {

      print("❗ [DEBUG] Unexpected Error in send message: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء إرسال الرسالة",
        errors: [e.toString()],
      ));
    }
  }
  Future<Either<Failure, Map<String, dynamic>>> changePassword({
    required String token,
    required String oldPassword ,
    required String newPassword ,
    required String confirmPassword ,
  }) async {
    try {

      final response = await _dio.post(
        '/Profile/change-password',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
         "oldPassword":oldPassword,
          "newPassword":newPassword,
          "confirmPassword":confirmPassword
        },
      );


      print("✅ [DEBUG] change password API Response: ${response.data}");


      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        return Right(response.data as Map<String, dynamic>);
      } else {

        return Left(ServiceFailure(
          errorMessage: "فشل في تغيير كلمة المرور: استجابة غير متوقعة",
          errors: [response.data.toString()],
        ));
      }
    } on DioException catch (e) {

      print("❌ [DEBUG] Dio Error (change password): $e");
      return Left(ServiceFailure.fromDioError(e));
    } catch (e) {

      print("❗ [DEBUG] Unexpected Error in change password: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء تغيير كلمة المرور",
        errors: [e.toString()],
      ));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> updateProfile({
    required String token,
    required String fullName,
    String? profilePicturePath,
    required String phoneNumber,

  }) async {
    try {
      final formData = FormData();
      formData.fields.add(MapEntry('FullName', fullName));
      formData.fields.add(MapEntry('PhoneNumber', phoneNumber));


      if (profilePicturePath != null && profilePicturePath.isNotEmpty) {
        formData.files.add(
          MapEntry(
            'ProfilePicture',
            await MultipartFile.fromFile(profilePicturePath),
          ),
        );
      } else {

        formData.fields.add(MapEntry('ProfilePicture', ''));
      }

      final response = await _dio.put(
        '/Profile/update',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
        data: formData,
      );

      print("✅ [DEBUG] update profile API Response: ${response.data}");

      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        return Right(response.data as Map<String, dynamic>);
      } else {
        return Left(ServiceFailure(
          errorMessage: "فشل في تعديل البروفايل: استجابة غير متوقعة",
          errors: [response.data.toString()],
        ));
      }
    } on DioException catch (e) {
      print("❌ [DEBUG] Dio Error (update profile): $e");
      return Left(ServiceFailure.fromDioError(e));
    } catch (e) {
      print("❗ [DEBUG] Unexpected Error in update profile: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء تعديل البروفايل",
        errors: [e.toString()],
      ));
    }
  }
  Future<Either<Failure, String>> appRating({
    required String token,
    required int star,
  }) async {
    try {
      final response = await _dio.post(
        '/AppRating',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          "stars": star,
        },
      );

      print("✅ [DEBUG] submit appRating API Response: ${response.data}");

      if (response.statusCode == 200 && response.data is String) {
        return Right(response.data);
      } else {
        return Left(ServiceFailure(
          errorMessage: "فشل في إرسال تقييم التطبيق: استجابة غير متوقعة",
          errors: [response.data.toString()],
        ));
      }
    } on DioException catch (e) {
      print("❌ [DEBUG] Dio Error (appRating): $e");
      return Left(ServiceFailure.fromDioError(e));
    } catch (e) {
      print("❗️ [DEBUG] Unexpected Error in appRating: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء إرسال تقييم التطبيق",
        errors: [e.toString()],
      ));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> submitInquiry({
    required String token,
    required String name,
    required String email,
    required String phone,
    required String message,

  }) async {
    try {

      final response = await _dio.post(
        '/Inquiry/submit-inquiry',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          "name": name,
          "email": email,
          "phone":phone,
          "message": message
        },
      );

      print("✅ [DEBUG] submit Inquiry API Response: ${response.data}");
      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        return Right(response.data as Map<String, dynamic>);
      } else {

        return Left(ServiceFailure(
          errorMessage: "فشل في إرسال الإستفسار: استجابة غير متوقعة",
          errors: [response.data.toString()],
        ));
      }
    } on DioException catch (e) {

      print("❌ [DEBUG] Dio Error (submitInquiry): $e");
      return Left(ServiceFailure.fromDioError(e));
    } catch (e) {

      print("❗️ [DEBUG] Unexpected Error in submitInquiry: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء إرسال الإستفسار",
        errors: [e.toString()],
      ));
    }
  }
  Future<Either<Failure, List<InquiryModel>>> getInquiry({
    required String token,
  }) async {
    try {
      final response = await _dio.get(
          '/Inquiry/my-inquiries',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
      );

      print("✅ [DEBUG] get Inquiry API Response: ${response.data}");

      if (response.data is List) {
        final List<InquiryModel> inquires = (response.data as List)
            .map((json) => InquiryModel.fromJson(json as Map<String, dynamic>))
            .toList();
        return Right(inquires);
      } else {
        return Left(ServiceFailure(
          errorMessage: "استجابة غير متوقعة من الخادم عند جلب رد تحتاج الي مساعده",
          errors: [response.data.toString()],
        ));
      }
    } on DioException catch (e) {
      print("❌ [DEBUG] Dio Error أثناء جلب رد تحتاج الي مساعدة: $e");
      final failure = ServiceFailure.fromDioError(e);
      return Left(failure);
    } catch (e) {
      print("❗ [DEBUG] خطأ غير متوقع أثناء جلب رد تحتاج الي مساعده في ApiService: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء جلب رد تحتاج الي مساعده",
        errors: [e.toString()],
      ));
    }
  }

  Future<Either<Failure, List<Property>>> getNearest({
    required String token,
    required double lat,
    required double lon,
    int? maxResults=10,

  }) async {
    try {
      final response = await _dio.get(
        '/Property/nearest?lat$lat&lon=$lon&maxResults=$maxResults',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          "lat":lat,
          "lon":lon,
          "maxResults":maxResults??10
        }
      );

      print("✅ [DEBUG] get Nearest API Response: ${response.data}");

      if (response.data is List) {
        final List<Property> properties = (response.data as List)
            .map((json) => Property.fromJson(json as Map<String, dynamic>))
            .toList();
        return Right(properties);
      } else {
        return Left(ServiceFailure(
          errorMessage: "استجابة غير متوقعة من الخادم عند جلب الشقق القريبة",
          errors: [response.data.toString()],
        ));
      }
    } on DioException catch (e) {
      print("❌ [DEBUG] Dio Error أثناء جلب الشقق القريبة: $e");
      final failure = ServiceFailure.fromDioError(e);
      return Left(failure);
    } catch (e) {
      print("❗ [DEBUG] خطأ غير متوقع أثناء جلب الشقق القريبة في ApiService: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء جلب الشقق القريبة",
        errors: [e.toString()],
      ));
    }
  }
  Future<Either<Failure, Map<String, dynamic>>> deleteAccount({required String token}) async {
    try {
      final response = await _dio.delete(
        '/Profile/delete-account',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print("✅ [DEBUG] delete account API Response: ${response.data}");

      if (response.data is Map<String, dynamic>) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('token');
        return Right(response.data as Map<String, dynamic>);
      } else {
        return Left(ServiceFailure(
          errorMessage: "استجابة غير متوقعة من الخادم",
          errors: [response.data.toString()],
        ));
      }
    } on DioException catch (e) {
      print("❌ [DEBUG] Dio Error: $e");

      final failure = ServiceFailure.fromDioError(e);
      return Left(failure);
    } catch (e) {
      print("❗ [DEBUG] Unexpected Error in ApiService: $e");

      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء حذف الاكونت",
        errors: [e.toString()],
      ));
    }
  }
  Future<Either<Failure, List<Property>>> getSearchProperty(String location,String token) async {
    try {
      final response = await _dio.get(
          '/Property/location/$location',options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),

      );

      print("✅ [DEBUG] get Search Property API Response: ${response.data}");

      if (response.data is List) {
        final List<Property> properties = (response.data as List)
            .map((json) => Property.fromJson(json as Map<String, dynamic>))
            .toList();
        return Right(properties);
      } else {
        return Left(ServiceFailure(
          errorMessage: "استجابة غير متوقعة من الخادم عند البحث  ",
          errors: [response.data.toString()],
        ));
      }
    } on DioException catch (e) {
      print("❌ [DEBUG] Dio Error أثناء   البحث: $e");
      final failure = ServiceFailure.fromDioError(e);
      return Left(failure);
    } catch (e) {
      print("❗ [DEBUG] خطأ غير متوقع أثناء  البحث ApiService: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء البحث  ",
        errors: [e.toString()],
      ));
    }
  }
  Future<Either<Failure, String>> updateProperty({
    required String token,
    required Property property,
    required int id,
  }) async {
    try {
      final response = await _dio.put(
        '/Property/$id',
        data: {
          "title": property.title ?? '',
          "location": property.location ?? '',
          "price": property.price,
          "rentType": property.rentType,
          "bedrooms": property.bedrooms,
          "bathrooms": property.bathrooms,
          "hasInternet": property.hasInternet ?? false,
          "allowsPets": property.allowsPets ?? false,
          "area": property.area,
          "smokingAllowed": property.smokingAllowed ?? false,
          "floor": property.floor,
          "isFurnished": property.isFurnished ?? false,
          "hasBalcony": property.hasBalcony ?? false,
          "hasSecurity": property.hasSecurity ?? false,
          "hasElevator": property.hasElevator ?? false,
          "minBookingDays": property.minBookingDays ?? 1,
          "availableFrom": property.availableFrom?.toIso8601String() ?? DateTime.now().toIso8601String(),
          "availableTo": property.availableTo?.toIso8601String() ?? DateTime.now().add(Duration(days: 30)).toIso8601String(),
          "description": property.description ?? '',
          "latitude": property.latitude ?? 0.0,
          "longitude": property.longitude ?? 0.0,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      print("📦 Sending Data: ${jsonEncode(property)}");


      print("✅ [DEBUG] updateProperty API Response: ${response.data}");

      if (response.statusCode == 200 && response.data is String) {
        return Right(response.data);
      } else {
        return Left(ServiceFailure(
          errorMessage: "فشل في تعديل الشقة: استجابة غير متوقعة",
          errors: [response.data.toString()],
        ));
      }
    } on DioException catch (e) {
      print("❌ [DEBUG] Dio Error (updateProperty): $e");
      return Left(ServiceFailure.fromDioError(e));
    } catch (e) {
      print("❗️ [DEBUG] Unexpected Error in updateProperty: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء إرسال تعديل بيانات الشقة",
        errors: [e.toString()],
      ));
    }
  }

  Future<Either<Failure, Property>> getProperty({
    required String token,
    required int id
  }) async {
    try {
      final response = await _dio.get(
        '/Property/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print("✅ [DEBUG] getProperty API Response: ${response.data}");

      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        final property = Property.fromJson(response.data);
        return Right(property);
      } else {
        return Left(ServiceFailure(
          errorMessage: "فشل في جلب بيانات الشقة: استجابة غير متوقعة",
          errors: [response.data.toString()],
        ));
      }
    } on DioException catch (e) {
      print("❌ [DEBUG] Dio Error (getProperty): $e");
      return Left(ServiceFailure.fromDioError(e));
    } catch (e) {
      print("❗️ [DEBUG] Unexpected Error in getProperty: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء جلب  بيانات الشقة",
        errors: [e.toString()],
      ));
    }
  }


  Future<Either<Failure, Map<String, dynamic>>> postPropertyPending({
    required String token,
    required PropertyFormData property,
  }) async {
    try {
      final dateFormat = DateFormat('yyyy-MM-dd');

      final availableFromStr = dateFormat.format(property.availableFrom);
      final availableToStr = dateFormat.format(property.availableTo);

      List<MultipartFile> images = [];
      if (property.images.isNotEmpty) {
        for (var image in property.images) {
          images.add(await MultipartFile.fromFile(image.path));
        }
      }

      final response = await _dio.post(
        '/Property/pending',
        data: FormData.fromMap({
          'Title': property.title??"",
          'Location': property.location??"",
          'AvailableFrom': availableFromStr??"",
          'AvailableTo': availableToStr??"",
          'RentType': property.rentType??"",
          'Bedrooms': property.bedrooms??"",
          'Bathrooms': property.bathrooms??"",
          'HasInternet': property.hasInternet??false,
          'AllowsPets': property.allowsPets??false,
          'Area': property.area??0,
          'SmokingAllowed': property.smokingAllowed??false,
          'Floor': property.floor??0,
          'IsFurnished': property.isFurnished??false,
          'HasBalcony': property.hasBalcony??false,
          'HasSecurity': property.hasSecurity??false,
          'HasElevator': property.hasElevator??false,
          'MinBookingDays': property.minBookingDays??1,
          'Description': property.description??'',
          'Latitude': property.latitude??0,
          'Longitude': property.longitude??0,
          'Images': images??[],
        }),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return Right(response.data as Map<String, dynamic>);
      } else {
        return Left(ServiceFailure(
          errorMessage: "استجابة غير صحيحة من الخادم",
          errors: [response.data.toString()],
        ));
      }
    } on DioException catch (e) {
      return Left(ServiceFailure.fromDioError(e));
    } catch (e) {
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء رفع الشقة",
        errors: [e.toString()],
      ));
    }
  }


  Future<Either<Failure, Map<String, dynamic>>> getStripeCheckoutSession({
    required String token,
    required String sessionId,
  }) async {
    try {
      final response = await _dio.post(
        '/Property/confirm',
        queryParameters: {
          'session_id': sessionId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print("✅ [DEBUG] Stripe Checkout API Response: ${response.data}");

      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        return Right(response.data as Map<String, dynamic>);
      } else {
        return Left(ServiceFailure(
          errorMessage: "استجابة غير متوقعة من الخادم",
          errors: [response.data.toString()],
        ));
      }
    } on DioException catch (e) {
      print("❌ [DEBUG] Dio Error: $e");

      final failure = ServiceFailure.fromDioError(e);
      return Left(failure);
    } catch (e) {
      print("❗ [DEBUG] Unexpected Error in getStripeCheckoutSession: $e");

      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء تأكيد الدفع",
        errors: [e.toString()],
      ));
    }
  }




Future<Either<Failure, List<ChatBotMessage>>> getChatPotMessages({
    required String token,
  }) async {
    try {
      final response = await _dio.get(
        '/chatBot/history',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.data is List) {
        final List<ChatBotMessage> messages = (response.data as List)
            .map((json) => ChatBotMessage.fromJson(json as Map<String, dynamic>))
            .toList();

        return Right(messages);
      } else {
        return Left(
          ServiceFailure(
            errorMessage: "استجابة غير متوقعة من الخادم عند جلب الرسائل",
            errors: [response.data.toString()],
          ),
        );
      }
    } on DioException catch (e) {
      return Left(ServiceFailure.fromDioError(e));
    } catch (e) {
      return Left(
        ServiceFailure(
          errorMessage: "حدث خطأ غير متوقع أثناء جلب الرسائل",
          errors: [e.toString()],
        ),
      );
    }
  }


  Future<Either<Failure, Map<String, dynamic>>> chatBotSendMessage({
    required String token,
    required String message,
  }) async {
    try {

      final response = await _dio.post(
        '/ChatBot/ask',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',},),
        data: {
          'message': message,},  );
      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        return Right(response.data as Map<String, dynamic>);
      } else {
        return Left(
          ServiceFailure(
            errorMessage: "فشل في إرسال الرسالة: استجابة غير متوقعة من الخادم",
            errors: [response.data.toString()],
          ),);  }
    } on DioException catch (e) {
      return Left(ServiceFailure.fromDioError(e));
    } catch (e) {
      return Left(
        ServiceFailure(
          errorMessage: "حدث خطأ غير متوقع أثناء إرسال الرسالة إلى الشات بوت",
          errors: [e.toString()],
        ),
      );
    }
  }
  Future<Either<Failure, String>> postPropertyCreate({
    required String token,
    required PropertyFormData property,
  }) async {
    try {
      final dateFormat = DateFormat('yyyy-MM-dd');

      final availableFromStr = dateFormat.format(property.availableFrom);
      final availableToStr = dateFormat.format(property.availableTo);

      List<MultipartFile> images = [];
      if (
      // property.images != null &&   unnecessary check
      property.images.isNotEmpty) {
        print("hna property images ${property.images}");
        for (var image in property.images) {
          images.add(await MultipartFile.fromFile(image.path));
        }
        print("hna property images ${images}");
      }

      final response = await _dio.post(
        '/Property/create',
        data: FormData.fromMap({
          'Title': property.title ?? "",
          'Location': property.location ?? "",
          'AvailableFrom': availableFromStr ?? "",
          'AvailableTo': availableToStr ?? "",
          'Price': property.price,
          'RentType': property.rentType ?? "",
          'Bedrooms': property.bedrooms ?? "",
          'Bathrooms': property.bathrooms ?? "",
          'HasInternet': property.hasInternet ?? false,
          'AllowsPets': property.allowsPets ?? false,
          'Area': property.area ?? 0,
          'SmokingAllowed': property.smokingAllowed ?? false,
          'Floor': property.floor ?? 0,
          'IsFurnished': property.isFurnished ?? false,
          'HasBalcony': property.hasBalcony ?? false,
          'HasSecurity': property.hasSecurity ?? false,
          'HasElevator': property.hasElevator ?? false,
          'MinBookingDays': property.minBookingDays ?? 1,
          'Description': property.description ?? '',
          'Latitude': property.latitude ?? 0,
          'Longitude': property.longitude ?? 0,
          'Images': images ?? [],
        }),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      print(
        "hn apend response create ${response.data['propertyId'].runtimeType}",
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("hna in right ${response.statusCode}");
        return Right(response.data['propertyId'].toString());
      } else {
        print("hna in right else ${response.statusCode}");
        return Left(
          ServiceFailure(
            errorMessage: "استجابة غير صحيحة من الخادم",
            errors: [response.data.toString()],
          ),
        );
      }
    } on DioException catch (e) {
      return Left(ServiceFailure.fromDioError(e));
    } catch (e) {
      return Left(
        ServiceFailure(
          errorMessage: "حدث خطأ غير متوقع أثناء رفع الشقة",
          errors: [e.toString()],
        ),
      );
    }
  }
  Future<Either<Failure, Property>> getPropertyDetails({
    required String token,
    required int id,
  }) async {
    try {
      print("hna getProperty ");
      final response = await _dio.get(
        '/Property/$id',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      print("✅ [DEBUG] getProperty API Response: ${response.data}");

      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        final property = Property.fromJson(response.data);
        return Right(property);
      } else {
        return Left(
          ServiceFailure(
            errorMessage: "فشل في جلب بيانات الشقة: استجابة غير متوقعة",
            errors: [response.data.toString()],
          ),
        );
      }
    } on DioException catch (e) {
      print("❌ [DEBUG] Dio Error (getProperty): $e");
      return Left(ServiceFailure.fromDioError(e));
    } catch (e) {
      print("❗️ [DEBUG] Unexpected Error in getProperty: $e");
      return Left(
        ServiceFailure(
          errorMessage: "حدث خطأ غير متوقع أثناء جلب  بيانات الشقة",
          errors: [e.toString()],
        ),
      );
    }
  }
  Future<Either<Failure, List<Property>>> getProperties({
    required String token,
    required int index,
    String? id,
  }) async {
    try {
      print("hna getProperty $index");
      final response = await _dio.get(
        index == 0
            ? 'https://sakaniapi1.runasp.net/api/Profile/Get-Property'
        // ? id != null
        //     ? 'https://sakaniapi1.runasp.net/api/Property/$id'
        //     : 'https://sakaniapi1.runasp.net/api/Property'
            : 'https://sakaniapi1.runasp.net/api/Property/pending',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      print("✅ [DEBUG] getProperty API Response: ${response.data}");

      if (response.statusCode == 200
      // && response.data is Map<String, dynamic>
      ) {
        print("hna data image ${response.data} ");
        final property = Property.fromJsonList(
          index == 0 ? response.data['ownedProperties'] : response.data,
          index,
        );
        return Right(property);
      } else {
        return Left(
          ServiceFailure(
            errorMessage: "فشل في جلب بيانات الشقة: استجابة غير متوقعة",
            errors: [response.data.toString()],
          ),
        );
      }
    } on DioException catch (e) {
      print("❌ [DEBUG] Dio Error (getProperty): $e");
      return Left(ServiceFailure.fromDioError(e));
    } catch (e) {
      print("❗️ [DEBUG] Unexpected Error in getProperty: $e");
      return Left(
        ServiceFailure(
          errorMessage: "حدث خطأ غير متوقع أثناء جلب  بيانات الشقة",
          errors: [e.toString()],
        ),
      );
    }
  }
  Future<Either<Failure, List<Rate>>> getRates(String token, {int? id}) async {
    // try {
    print("hna in rates 2");
    final response = await _dio.get(
      id != null
          ? 'https://sakaniapi1.runasp.net/api/Rating/property/$id'
          : 'https://sakaniapi1.runasp.net/api/Rating/all',
      // queryParameters: {'session_id': sessionId},
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("hna in right getRates ${response}");
      return Right(Rate.fromJsonList(response.data));
    } else {
      print("hna in right else ${response.statusCode}");
      return Left(
        ServiceFailure(
          errorMessage: "استجابة غير صحيحة من الخادم",
          errors: [response.data.toString()],
        ),
      );
    }
    // } on DioException catch (e) {
    //   return Left(ServiceFailure.fromDioError(e));
    // } catch (e) {
    //   return Left(
    //     ServiceFailure(
    //       errorMessage: "حدث خطأ غير متوقع أثناء رفع الشقة",
    //       errors: [e.toString()],
    //     ),
    //   );
    // }
  }
  Future<Either<Failure, String>> addRate(RateParam rate, String token) async {
    try {
      print("hna in rates 2 add rate");
      final response = await _dio.post(
        'https://sakaniapi1.runasp.net/api/Rating/add',
        data: {
          'propertyId': rate.propertyId,
          'stars': rate.stars,
          'comment': rate.comment,
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      print("hna in right add comment ${response}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("hna in right add comment ${response.data[0]['ratingId']}");
        return Right(response.data[0]['ratingId'].toString());
      } else {
        print("hna in right else ${response.statusCode}");
        return Left(
          ServiceFailure(
            errorMessage: "استجابة غير صحيحة من الخادم",
            errors: [response.data.toString()],
          ),
        );
      }
    } on DioException catch (e) {
      return Left(ServiceFailure.fromDioError(e));
    } catch (e) {
      return Left(
        ServiceFailure(
          errorMessage: "حدث خطأ غير متوقع أثناء رفع الشقة",
          errors: [e.toString()],
        ),
      );
    }
  }
  Future<Either<Failure, String>> deleteRate(int id, String token) async {
    try {
      print("hna in rates 2");
      final response = await _dio.delete(
        'https://sakaniapi1.runasp.net/api/Rating/delete/$id',

        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      print("hna in right delete ${response}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(response.data['message']);
      } else {
        print("hna in right else ${response.statusCode}");
        return Left(
          ServiceFailure(
            errorMessage: "استجابة غير صحيحة من الخادم",
            errors: [response.data.toString()],
          ),
        );
      }
    } on DioException catch (e) {
      return Left(ServiceFailure.fromDioError(e));
    } catch (e) {
      return Left(
        ServiceFailure(
          errorMessage: "حدث خطأ غير متوقع أثناء رفع الشقة",
          errors: [e.toString()],
        ),
      );
    }
  }


}
