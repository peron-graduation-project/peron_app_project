import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../../core/utils/property_model.dart';
import 'edit_property_repo.dart';


class UpdatePropertyRepoImp implements EditPropertyRepo {
  final ApiService apiService;

  UpdatePropertyRepoImp(this.apiService);

  @override
  Future<Either<Failure, String>> editProperty({
    required Property property,
    required int id,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token == null || token.isEmpty) {
        return Left(ServiceFailure(
          errorMessage: "لا يوجد توكين مسجل لتعديل بيانات العقار",
          errors: ["التوكين غير موجود"],
        ));
      }

      final response = await apiService.updateProperty(
        token: token,
        property: property,
        id: id,
      );

      print("✅ [DEBUG] updateProperty Response: $response");

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
      print("❗ [DEBUG] Unexpected Error in updatePropertyRepoImp: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء تعديل بيانات العقار",
        errors: [e.toString()],
      ));
    }
  }
}
