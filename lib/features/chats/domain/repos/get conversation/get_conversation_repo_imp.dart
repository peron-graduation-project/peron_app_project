import 'package:dartz/dartz.dart';
import '../../../data/models/message_model.dart';
import 'package:peron_project/features/chats/domain/repos/get%20conversation/get_conversation_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../../../core/network/api_service.dart';



class GetConversationRepoImp implements GetConversationRepo {
  final ApiService apiService;

  GetConversationRepoImp(this.apiService);
@override
  Future<Either<Failure, List<Message>>> getconversation(
      {required String id}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        return Left(ServiceFailure(
          errorMessage: "لا يوجد توكين مسجل لجلب المحادثة",
          errors: ["التوكين غير موجود"],
        ));
      }

      final Either<Failure, List<Message>> response = await apiService
          .getChatConversation(token: token, id: id);

      print("✅ [DEBUG] GetConversationRepoImp Response: $response");

      return response.fold(
            (failure) {
          print("❌ [DEBUG] Failure in GetConversation Repo: $failure");
          return Left(failure);
        },
            (conversations) {
          print(
              "✅✅✅ [DEBUG] GetConversationRepoImp received from ApiService: $conversations");
          return Right(conversations);
        },
      );
    } catch (e) {
      print("❗ [DEBUG] Unexpected Error in get conversations nRepoImp: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء جلب المحادثات",
        errors: [e.toString()],
      ));
    }
  }
}