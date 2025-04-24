import 'package:dartz/dartz.dart';
import 'package:peron_project/features/main/data/models/recommended_property.dart';
import 'package:peron_project/features/main/domain/repo/get%20lowest%20price/get_lowest_price_repo.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../../../core/network/api_service.dart';



class GetLowestPriceRepoImp implements GetLowestPriceRepo {
  final ApiService apiService;

  GetLowestPriceRepoImp(this.apiService);


  @override
  Future<Either<Failure, List<RecommendedProperty>>> getLowestPrice() async {
    try {
      final Either<Failure, List<RecommendedProperty>> response = await apiService.getLowestPriceProperty();

      print("✅ [DEBUG] GetLowestPriceRepoImpPropertiesRepoImp Response: $response");

      return response.fold(
            (failure) {
          print("❌ [DEBUG] Failure in GetLowestPriceRepoImpProperties Repo: $failure");
          return Left(failure);
        },
            (properties) {
          print("✅✅✅ [DEBUG] GetLowestPriceRepoImpProperties received from ApiService: $properties");
          return Right(properties);
        },
      );
    } catch (e) {
      print("❗ [DEBUG] Unexpected Error GetLowestPriceRepoImpPropertiesRepoImp: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء جلب الشقق الأقل في السعر",
        errors: [e.toString()],
      ));
    }
  }
}