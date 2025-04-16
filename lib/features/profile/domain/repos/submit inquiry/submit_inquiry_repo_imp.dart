import 'package:dartz/dartz.dart';
import 'package:peron_project/features/profile/domain/repos/submit%20inquiry/submit_inquiry_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/api_service.dart';


class SubmitInquiryRepoImp implements SubmitInquiryRepo {
  final ApiService apiService;

  SubmitInquiryRepoImp(this.apiService);

  @override
  Future<Either<Failure, String>> submitInquiry(
  {
    required String name,
    required String email,
    required String phone,
    required String message,
}
      ) async{
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        return Left(ServiceFailure(
          errorMessage: "لا يوجد توكين مسجل لاضافة المفضله",
          errors: ["التوكين غير موجود"],
        ));
      }

      final response = await apiService.submitInquiry(token: token,name: name,message: message,phone: phone,email: email);

      print("✅ [DEBUG] submitInquiryImp Response: $response");

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
              errorMessage: "الاستجابة لا تحتوي على المفتاح 'message'",
              errors: ["لم يتم العثور على المفتاح 'message' في الاستجابة"],
            ));
          }
        },
      );
    } catch (e) {
      print("❗ [DEBUG] Unexpected Error in submitInquiryImp: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء إرسال الإستفسار",
        errors: [e.toString()],
      ));
    }
  }
}


