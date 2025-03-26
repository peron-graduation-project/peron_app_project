import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/api_service.dart';
import 'logout_repo.dart';

class LogoutRepoImp implements LogoutRepo {
  final ApiService apiService;

  LogoutRepoImp(this.apiService);

  @override
  Future<Either<Failure, String>> logout() async {
    try {
      final response = await apiService.logout();

      print("✅ [DEBUG] LogoutRepoImp Response: $response");

      return response.fold(
            (failure) {
          print("❌ [DEBUG] Failure in Repo: $failure");
          return Left(failure);
        },
            (data) {
          if (data.containsKey("message")) {
            return Right(data["message"].toString());
          } else {
            return Left(ServiceFailure(
              errorMessage: "الاستجابة لا تحتوي على الرسالة",
              errors: ["لم يتم العثور على المفتاح 'message' في الاستجابة"],
            ));
          }
        },
      );
    } catch (e) {
      print("❗ [DEBUG] Unexpected Error in LogoutRepoImp: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع",
        errors: [e.toString()],
      ));
    }
  }
}
