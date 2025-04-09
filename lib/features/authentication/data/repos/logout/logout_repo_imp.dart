import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/api_service.dart';
import 'logout_repo.dart';

class LogoutRepoImp implements LogoutRepo {
  final ApiService apiService;

  LogoutRepoImp(this.apiService);

  @override
  Future<Either<Failure, String>> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        return Left(ServiceFailure(
          errorMessage: "لا يوجد توكين مسجل لتسجيل الخروج",
          errors: ["التوكين غير موجود"],
        ));
      }

      final response = await apiService.logout(token: token);

      print("✅ [DEBUG] LogoutRepoImp Response: $response");

      return response.fold(
            (failure) {
          print("❌ [DEBUG] Failure in Repo: $failure");
          return Left(failure);
        },
            (data) {
          if (data is Map<String, dynamic>) {
            if (data.containsKey("message")) {
              return Right(data["message"].toString()); // إعادة رسالة النجاح
            } else {
              return Left(ServiceFailure(
                errorMessage: "الاستجابة لا تحتوي على المفتاح 'message'",
                errors: ["لم يتم العثور على المفتاح 'message' في الاستجابة"],
              ));
            }
          } else {
            return Left(ServiceFailure(
              errorMessage: "الاستجابة غير صحيحة",
              errors: ["البيانات المستلمة ليست من النوع المناسب"],
            ));
          }
        },
      );
    } catch (e) {
      print("❗ [DEBUG] Unexpected Error in LogoutRepoImp: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء تسجيل الخروج",
        errors: [e.toString()],
      ));
    }
  }
}
