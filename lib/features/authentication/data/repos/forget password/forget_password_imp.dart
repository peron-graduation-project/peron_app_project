import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/api_service.dart';
import 'forget_password_repo.dart';

class ForgetPasswordImp implements ForgetPasswordRepo {
  final ApiService apiService;

  ForgetPasswordImp({required this.apiService});

  @override
  Future<Either<Failure, String>> forgotPassword({required String email}) async {
    try {
      final response = await apiService.forgotPassword(email: email);

      return response.fold(
            (failure) {
          print("❌ [DEBUG] API Failure: $failure");
          return Left(failure);
        },
            (data) {
          print("✅ [DEBUG] API Response: $data");

          if (data.containsKey("message")) {
            return Right(data["message"]);
          } else {
            return Left(ServiceFailure(
              errorMessage: "الاستجابة لا تحتوي على الرسالة",
              errors: ["لم يتم العثور على المفتاح 'message'"],
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
