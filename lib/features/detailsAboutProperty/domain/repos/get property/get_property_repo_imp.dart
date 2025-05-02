import 'package:dartz/dartz.dart';
import 'package:peron_project/core/utils/property_model.dart';
import 'package:peron_project/features/detailsAboutProperty/domain/repos/get%20property/get_property_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../../../core/network/api_service.dart';



class GetPropertyRepoImp implements GetPropertyRepo {
  final ApiService apiService;

  GetPropertyRepoImp(this.apiService);
  @override
  Future<Either<Failure, Property>> getProperty({required int id}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        return Left(ServiceFailure(
          errorMessage: "لا يوجد توكين مسجل لجلب المحادثات",
          errors: ["التوكين غير موجود"],
        ));
      }

      final Either<Failure, Property> response = await apiService
          .getProperty(token: token,id: id );

      print("✅ [DEBUG] GetPropertyRepoImp Response: $response");

      return response.fold(
            (failure) {
          print("❌ [DEBUG] Failure in GetPropertyRepoImp Repo: $failure");
          return Left(failure);
        },
            (conversations) {
          print(
              "✅✅✅ [DEBUG] GetPropertyRepoImp received from ApiService: $conversations");
          return Right(conversations);
        },
      );
    } catch (e) {
      print("❗ [DEBUG] Unexpected Error in Get Property Repo Imp: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء جلب بيانات الشقة",
        errors: [e.toString()],
      ));
    }
  }
}