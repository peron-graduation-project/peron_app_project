
import 'package:dartz/dartz.dart';
import 'package:peron_project/core/error/failure.dart';
import 'package:peron_project/features/chats/domain/repos/send%20message/send_message_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/network/api_service.dart';

class SendMessageRepoImp extends SendMessageRepo{
  final ApiService apiService;
  SendMessageRepoImp(this.apiService);

  @override
  Future<Either<Failure, bool>> sendMessage({required String receiverId, required String message})async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        return Left(ServiceFailure(
          errorMessage: "لا يوجد توكين مسجل لإرسال رسالة",
          errors: ["التوكين غير موجود"],
        ));
      }

      final response = await apiService.sendMessage(token: token, id: receiverId,message: message);

      print("✅ [DEBUG] SendMessageRepoImp  Response: $response");

      return response.fold(
            (failure) {
          print("❌ [DEBUG] Failure in SendMessageRepoImp Repo: $failure");
          return Left(failure);
        },
            (success) {
          return const Right(true);
        },
      );
    } catch (e) {
      print("❗ [DEBUG] Unexpected Error in SendMessageRepoImp Repo: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء إرسال الرسالة",
        errors: [e.toString()],
      ));
    }
  }
}