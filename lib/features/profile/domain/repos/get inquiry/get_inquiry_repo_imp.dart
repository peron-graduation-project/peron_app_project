import 'package:dartz/dartz.dart';
import 'package:peron_project/features/profile/data/models/inquiry_model.dart';
import 'package:peron_project/features/profile/domain/repos/get%20inquiry/get_inquiry_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../../../core/network/api_service.dart';



class GetInquiryRepoImp implements GetInquiryRepo {
  final ApiService apiService;

  GetInquiryRepoImp(this.apiService);


  @override
  Future<Either<Failure, List<InquiryModel>>> getInquiry() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        return Left(ServiceFailure(
          errorMessage: "لا يوجد توكين مسجل لجلب الإشعارات",
          errors: ["التوكين غير موجود"],
        ));
      }

      final Either<Failure, List<InquiryModel>> response = await apiService.getInquiry(
          token: token,
      );

      print("✅ [DEBUG] getInquiry Imp Response: $response");

      return response.fold(
            (failure) {
          print("❌ [DEBUG] Failure in getInquiry Repo: $failure");
          return Left(failure);
        },
            (inquires) {
          print("✅✅✅ [DEBUG] getInquiry received from ApiService: $inquires");
          return Right(inquires);
        },
      );
    } catch (e) {
      print("❗ [DEBUG] Unexpected Error in getInquiryRepoImp: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء جلب رد تحتاج الي مساعدة",
        errors: [e.toString()],
      ));
    }
  }
}