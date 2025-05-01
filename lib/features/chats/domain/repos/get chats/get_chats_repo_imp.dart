import 'package:dartz/dartz.dart';
import 'package:peron_project/features/chats/data/models/chat_model.dart';
import 'package:peron_project/features/chats/domain/repos/get%20chats/get_chats_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../../../core/network/api_service.dart';



class GetChatsRepoImp implements GetChatsRepo {
  final ApiService apiService;

  GetChatsRepoImp(this.apiService);
  @override
  Future<Either<Failure, List<ChatModel>>> getChats() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        return Left(ServiceFailure(
          errorMessage: "لا يوجد توكين مسجل لجلب المحادثات",
          errors: ["التوكين غير موجود"],
        ));
      }

      final Either<Failure, List<ChatModel>> response = await apiService
          .getChats(token: token, );

      print("✅ [DEBUG] GetChatsRepoImp Response: $response");

      return response.fold(
            (failure) {
          print("❌ [DEBUG] Failure in GetChatsImp Repo: $failure");
          return Left(failure);
        },
            (conversations) {
          print(
              "✅✅✅ [DEBUG] GetChatsRepoImp received from ApiService: $conversations");
          return Right(conversations);
        },
      );
    } catch (e) {
      print("❗ [DEBUG] Unexpected Error in get Chats RepoImp: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء جلب المحادثات",
        errors: [e.toString()],
      ));
    }
  }
}