import 'package:dartz/dartz.dart';
import 'package:peron_project/features/main/data/models/recommended_property.dart';
import 'package:peron_project/features/main/domain/repo/get%20highest%20price/get_highest_price_repo.dart';
import 'package:peron_project/features/main/domain/repo/get%20most%20area/get_most_area_repo.dart';
import 'package:peron_project/features/main/domain/repo/get%20recommended/get_recommended_repo.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../../../core/network/api_service.dart';



class GetHighestPriceRepoImp implements GetHighestPriceRepo {
  final ApiService apiService;

  GetHighestPriceRepoImp(this.apiService);


  @override
  Future<Either<Failure, List<RecommendedProperty>>> getHighestPrice() async {
    try {
      final Either<Failure, List<RecommendedProperty>> response = await apiService.getHighestPriceProperty();

      print("✅ [DEBUG] getHighestPricePropertiesRepoImp Response: $response");

      return response.fold(
            (failure) {
          print("❌ [DEBUG] Failure in getHighestPriceProperties Repo: $failure");
          return Left(failure);
        },
            (properties) {
          print("✅✅✅ [DEBUG] getHighestPriceProperties received from ApiService: $properties");
          return Right(properties);
        },
      );
    } catch (e) {
      print("❗ [DEBUG] Unexpected Error getHighestPricePropertiesRepoImp: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء جلب الشقق الأعلى في السعر",
        errors: [e.toString()],
      ));
    }
  }
}