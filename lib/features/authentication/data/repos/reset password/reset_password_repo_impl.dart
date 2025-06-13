import 'package:dartz/dartz.dart';
import 'package:peron_project/features/authentication/data/repos/reset%20password/reset_password_repo.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/api_service.dart';

class ResetPasswordRepoImpl implements ResetPasswordRepo {
  final ApiService apiService;

  ResetPasswordRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, String>> resetPassword({
    required Map<String, dynamic> body
  }) async {
    try {
      final response = await apiService.resetPassword(body);
      print("body: $body");
      print("response : $response");

      return response.fold(
            (failure) {
          print("❌ [DEBUG] API Failure: $failure");
          return Left(failure);
        },
            (data) {
          print("✅ [DEBUG] API Response: $data");

          if (data.containsKey("message")) {
            return Right(data["message"].toString());
          }
          else {
            return Left(ServiceFailure(
              errorMessage: "الاستجابة لا تحتوي على الرسالة أو البيانات غير صحيحة",
              errors: ["لم يتم العثور على المفتاح 'message' في الاستجابة أو نوع البيانات غير Map"],
            ));
          }
        },

      );
    } catch (e) {
      print("❗ [DEBUG] Unexpected Error: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع",
        errors: [e.toString()],
      ));
    }
  }
}
