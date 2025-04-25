import 'package:dartz/dartz.dart';
import 'package:peron_project/features/main/data/models/recommended_property.dart';
import 'package:peron_project/features/main/domain/repo/get%20most%20area/get_most_area_repo.dart';
import 'package:peron_project/features/main/domain/repo/get%20recommended/get_recommended_repo.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../../../core/network/api_service.dart';



class GetMostAreaRepoImp implements GetMostAreaRepo {
  final ApiService apiService;

  GetMostAreaRepoImp(this.apiService);


  @override
  Future<Either<Failure, List<RecommendedProperty>>> getMostAreaProperties({int top=10}) async {
    try {
      final Either<Failure, List<RecommendedProperty>> response = await apiService.getMostAreaProperty(top: top);

      print("✅ [DEBUG] getMostAreaPropertiesRepoImp Response: $response");

      return response.fold(
            (failure) {
          print("❌ [DEBUG] Failure in getMostAreaProperties Repo: $failure");
          return Left(failure);
        },
            (properties) {
          print("✅✅✅ [DEBUG] getMostAreaProperties received from ApiService: $properties");
          return Right(properties);
        },
      );
    } catch (e) {
      print("❗ [DEBUG] Unexpected Error MostAreaPropertiesRepoImp: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء جلب الشقق الأكبر مساحة",
        errors: [e.toString()],
      ));
    }
  }
}