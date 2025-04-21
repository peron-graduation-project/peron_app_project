import 'package:dartz/dartz.dart';
import 'package:peron_project/core/utils/property_model.dart';
import 'package:peron_project/features/main/data/models/recommended_property.dart';
import 'package:peron_project/features/main/domain/repo/get%20recommended/get_recommended_repo.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../../../core/network/api_service.dart';



class GetRecommendedRepoImp implements GetRecommendedRepo {
  final ApiService apiService;

  GetRecommendedRepoImp(this.apiService);


  @override
  Future<Either<Failure, List<RecommendedProperty>>> getRecommendedProperties() async {
    try {
      final Either<Failure, List<RecommendedProperty>> response = await apiService.getRecommendedProperty();

      print("✅ [DEBUG] getRecommendedPropertiesRepoImp Response: $response");

      return response.fold(
            (failure) {
          print("❌ [DEBUG] Failure in getRecommendedProperties Repo: $failure");
          return Left(failure);
        },
            (properties) {
          print("✅✅✅ [DEBUG] getRecommendedProperties received from ApiService: $properties");
          return Right(properties);
        },
      );
    } catch (e) {
      print("❗ [DEBUG] Unexpected Error in getRecommendedPropertiesRepoImp: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء جلب الشقق المقترجة",
        errors: [e.toString()],
      ));
    }
  }
}