import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;
  const Failure(this.errorMessage);
}

class ServiceFailure extends Failure {
  final int? statusCode;
  final List<String> errors;

  ServiceFailure({required String errorMessage, this.statusCode, required this.errors})
      : super(errorMessage);

  factory ServiceFailure.fromDioError(DioException e) {
    String message = "حدث خطأ أثناء الاتصال بالخادم";
    List<String> errorsList = [];
    int? statusCode = e.response?.statusCode;

    if (e.response?.data is Map<String, dynamic>) {
      final data = e.response!.data as Map<String, dynamic>;

      if (data.containsKey("message") && data["message"] is String && data["message"].isNotEmpty) {
        message = data["message"];
      }

      if (data.containsKey("errors") && data["errors"] is List) {
        errorsList = List<String>.from(data["errors"].map((e) => e.toString()));
      }
    }

    if (message == "حدث خطأ أثناء الاتصال بالخادم" && errorsList.isNotEmpty) {
      message = errorsList.join("\n• ");
    }

    return ServiceFailure(
      errorMessage: message,
      statusCode: statusCode,
      errors: errorsList,
    );
  }
}
