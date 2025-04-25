import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:peron_project/features/favourite/data/repos/addFavorite/addFavorite_repo.dart';
import 'package:peron_project/features/main/data/models/recommended_property.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/api_service.dart';

class AddfavImp implements AddfavoriteRepo {
  final ApiService apiService;

  AddfavImp(this.apiService);

  @override
  Future<Either<Failure, String>> addFavorite(int propertyId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        return Left(ServiceFailure(
          errorMessage: "لا يوجد توكين مسجل لإضافة المفضلة",
          errors: ["التوكين غير موجود"],
        ));
      }

      final response = await apiService.addFavorite(token: token, id: propertyId);

      print("✅ [DEBUG] AddFavoriteRepoImp Response: $response");

      return response.fold(
            (failure) {
          print("❌ [DEBUG] Failure in Repo: $failure");
          return Left(failure);
        },
            (data) async {
          if (data.containsKey("message")) {
            if (data.containsKey("property")) {
              final newProperty = RecommendedProperty.fromJson(data["property"]);

              final List<String>? savedList = prefs.getStringList('favorite_properties');
              List<String> updatedList = savedList ?? [];

              updatedList.add(jsonEncode(newProperty.toJson()));

              await prefs.setStringList('favorite_properties', updatedList);

              print("📦 [DEBUG] Property added to SharedPreferences");
            }

            return Right(data["message"].toString());
          } else {
            return Left(ServiceFailure(
              errorMessage: "الاستجابة لا تحتوي على المفتاح 'message'",
              errors: ["لم يتم العثور على المفتاح 'message' في الاستجابة"],
            ));
          }
        },
      );
    } catch (e) {
      print("❗ [DEBUG] Unexpected Error in AddFavoriteRepoImp: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء إضافة المفضلة",
        errors: [e.toString()],
      ));
    }
  }
}
