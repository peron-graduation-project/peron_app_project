import 'package:dartz/dartz.dart';
import 'package:peron_project/core/utils/property_model.dart';
import 'package:peron_project/features/map/domain/repos/get%20nearest/get_nearest_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../../../core/network/api_service.dart';



class GetNearestRepoImp implements GetNearestRepo {
  final ApiService apiService;

  GetNearestRepoImp(this.apiService);


  @override
  Future<Either<Failure, List<Property>>> getNearest(
  {
    required double lat,
    required double lon,
    int? maxResults = 10,
}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        return Left(ServiceFailure(
          errorMessage: "لا يوجد توكين مسجل لجلب الإشعارات",
          errors: ["التوكين غير موجود"],
        ));
      }

      final Either<Failure, List<Property>> response = await apiService.getNearest(
          token: token,
        lat: lat,
        lon: lon,
        maxResults: maxResults
      );

      print("✅ [DEBUG] getNearestRepoImp Response: $response");

      return response.fold(
            (failure) {
          print("❌ [DEBUG] Failure in getNearest Repo: $failure");
          return Left(failure);
        },
            (properties) {
          print("✅✅✅ [DEBUG] getNearest received from ApiService: $properties");
          return Right(properties);
        },
      );
    } catch (e) {
      print("❗ [DEBUG] Unexpected Error in getNearestRepoImp: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء جلب الشقق القريبة",
        errors: [e.toString()],
      ));
    }
  }
}