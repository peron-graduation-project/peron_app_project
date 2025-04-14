import 'package:dartz/dartz.dart';
import 'package:peron_project/features/profile/domain/repos/change%20password/change_password_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/api_service.dart';

class ChangePasswordRepoImp implements ChangePasswordRepo {
  final ApiService apiService;

  ChangePasswordRepoImp(this.apiService);

  @override
  Future<Either<Failure, String>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,



  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        return Left(ServiceFailure(
          errorMessage: "لا يوجد توكين مسجل لتغيير كلمة المرور",
          errors: ["التوكين غير موجود"],
        ));
      }

      final response = await apiService.changePassword(token: token, oldPassword: oldPassword,confirmPassword: confirmPassword,newPassword: newPassword);

      print("✅ [DEBUG] change password repo Response: $response");

      return response.fold(
            (failure) {
          print("❌ [DEBUG] Failure in Repo: $failure");
          return Left(failure);
        },
            (data) {
          if (data is Map<String, dynamic>) {
            if (data.containsKey("message")) {
              return Right(data["message"].toString());
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
      print("❗ [DEBUG] Unexpected Error in DeleteAccountRepoImp: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء تغيير كلمة المرور",
        errors: [e.toString()],
      ));
    }
  }
}
