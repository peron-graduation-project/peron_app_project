import 'package:dio/dio.dart';

bool isSuccessResponse(Response response) {
  if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
    return true;
  }

  if (response.data is Map<String, dynamic>) {
    String message = response.data["message"]?.toString().toLowerCase() ?? "";
    return message.contains("تم بنجاح") || message.contains("otp sent") || message.contains("success");
  }

  return false;
}
