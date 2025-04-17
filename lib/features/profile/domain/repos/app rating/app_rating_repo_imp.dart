import 'package:dartz/dartz.dart';
import 'package:peron_project/features/profile/domain/repos/app%20rating/app_rating_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/api_service.dart';


class AppRatingRepoImp implements AppRatingRepo {
  final ApiService apiService;

  AppRatingRepoImp(this.apiService);

  @override
  Future<Either<Failure, String>> sendAppRating(
      {
        required int star,
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

      final response = await apiService.appRating(token: token,star: star);

      print("✅ [DEBUG] appRatingImp Response: $response");

      return response.fold(
            (failure) {
          print("❌ [DEBUG] Failure in Repo: $failure");
          return Left(failure);
        },
            (data) {
          return Right(data);
        },
      );

    } catch (e) {
      print("❗ [DEBUG] Unexpected Error in appRatingImp: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء إرسال تقييم التطبيق",
        errors: [e.toString()],
      ));
    }
  }
}


