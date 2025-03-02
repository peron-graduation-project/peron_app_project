import 'package:dio/dio.dart';

abstract class Failure {
  String errorMessage;
  Failure({required this.errorMessage});
}

class ServiceFailure extends Failure {
  ServiceFailure({required super.errorMessage});

  factory ServiceFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServiceFailure(errorMessage: 'انتهت مهلة الاتصال بالخادم');
      case DioExceptionType.sendTimeout:
        return ServiceFailure(errorMessage: 'انتهت مهلة الإرسال إلى الخادم');
      case DioExceptionType.receiveTimeout:
        return ServiceFailure(errorMessage: 'انتهت مهلة الاستقبال من الخادم');
      case DioExceptionType.badCertificate:
        return ServiceFailure(errorMessage: 'الشهادة غير صالحة');
      case DioExceptionType.badResponse:
        return ServiceFailure.fromResponse(
          dioError.response?.statusCode ?? 0,
          dioError.response?.data,
        );
      case DioExceptionType.cancel:
        return ServiceFailure(errorMessage: 'تم إلغاء الطلب');
      case DioExceptionType.connectionError:
        return ServiceFailure(errorMessage: 'خطأ في الاتصال بالخادم');
      case DioExceptionType.unknown:
        if (dioError.message?.contains('SocketException') ?? false) {
          return ServiceFailure(errorMessage: 'لا يوجد اتصال بالإنترنت');
        }
        return ServiceFailure(errorMessage: 'حدث خطأ غير متوقع، برجاء المحاولة لاحقًا');
    }
  }

  factory ServiceFailure.fromResponse(int statusCode, dynamic response) {
    print("Response Status Code: $statusCode");
    print("Response Data: $response");
    print("Response Type: ${response.runtimeType}");

    String errorMessage = 'حدث خطأ غير متوقع، برجاء المحاولة لاحقًا';

    if (response is Map) {
      if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
        errorMessage = response['error']?['message'] ?? response['message'] ?? 'خطأ في البيانات المدخلة';
      } else if (statusCode == 404) {
        errorMessage = 'المستخدم غير موجود';
      } else if (statusCode == 500) {
        errorMessage = 'خطأ في الخادم، برجاء المحاولة لاحقًا';
      }
    } else if (response is String) {
      errorMessage = response;
    }

    return ServiceFailure(errorMessage: errorMessage);
  }
}
