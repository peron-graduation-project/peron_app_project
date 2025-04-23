import 'package:dartz/dartz.dart';
import 'package:peron_project/core/utils/property_model.dart';
import 'package:peron_project/features/main/domain/repo/get%20search/get_search_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../../../core/network/api_service.dart';
class GetSearchRepoImp implements GetSearchRepo {
  final ApiService apiService;
  GetSearchRepoImp(this.apiService);
  @override
  Future<Either<Failure, List<Property>>> getSearchProperties(String location) async {
  try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        return Left(ServiceFailure(
          errorMessage: "لا يوجد توكين مسجل لجلب البحث",
          errors: ["التوكين غير موجود"],
        ));
      }

      final Either<Failure, List<Property>> response = await apiService.getSearchProperty(location,token); 

      print("✅ [DEBUG] SearchRepoImp Response: $response");

      return response.fold(
            (failure) {
          print("❌ [DEBUG] Failure in Search Repo: $failure");
          return Left(failure);
        },
            (notifications) {
          print("✅✅✅ [DEBUG] Search received from ApiService: $notifications");
          return Right(notifications);
        },
      );
    } catch (e) {
      print("❗️ [DEBUG] Unexpected Error in SearchRepoImp: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء  البحث",
        errors: [e.toString()],
      ));
    }
  }
}