import 'dart:convert';
import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;
  const Failure(this.errorMessage);
}

class ServiceFailure extends Failure {
  final int? statusCode;
  final List<String> errors;

  ServiceFailure({
    required String errorMessage,
    this.statusCode,
    required this.errors,
  }) : super(errorMessage);

  factory ServiceFailure.fromDioError(DioException e) {
    String message = "حدث خطأ أثناء الاتصال بالخادم";
    List<String> errorsList = [];
    int? statusCode = e.response?.statusCode;

    // ✅ التحقق من عدم وجود إنترنت
    if (e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.unknown) {
      message = "لا يوجد اتصال بالإنترنت، يرجى التحقق من الشبكة";
      return ServiceFailure(
        errorMessage: message,
        statusCode: null,
        errors: [message],
      );
    }

    dynamic data = e.response?.data;

    if (data is String) {
      try {
        data = jsonDecode(data);
      } catch (_) {
        message = data;
      }
    }

    if (data is Map<String, dynamic>) {
      print("📦 [DEBUG] Dio Response Data: $data");

      if (data.containsKey("message") &&
          data["message"] is String &&
          data["message"].isNotEmpty) {
        message = data["message"];
      }

      if (data.containsKey("errors")) {
        final errorsData = data["errors"];

        if (errorsData is List) {
          errorsList = errorsData.map((e) => e.toString()).toList();
        } else if (errorsData is Map) {
          errorsList = errorsData.entries
              .map((e) => "${e.key}: ${e.value}")
              .toList();
        } else if (errorsData is String) {
          errorsList = [errorsData];
        }
      }
    }

    if (message == "حدث خطأ أثناء الاتصال بالخادم" && errorsList.isNotEmpty) {
      message = "• " + errorsList.join("\n• ");
    }

    print("📦 [DEBUG] Extracted Message: $message");
    print("📦 [DEBUG] Extracted Errors List: $errorsList");

    return ServiceFailure(
      errorMessage: message,
      statusCode: statusCode,
      errors: errorsList,
    );
  }
}
