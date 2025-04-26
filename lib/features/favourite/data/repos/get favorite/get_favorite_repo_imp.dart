import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:peron_project/features/favourite/data/repos/get%20favorite/get_favorite_repo.dart';
import 'package:peron_project/features/main/data/models/recommended_property.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../../../core/network/api_service.dart';

class GetFavoriteRepoImp implements GetFavoriteRepo {
  final ApiService apiService;

  GetFavoriteRepoImp(this.apiService);

  @override
  Future<Either<Failure, List<RecommendedProperty>>> getFavoriteProperties() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        return Left(ServiceFailure(
          errorMessage: "لا يوجد توكين مسجل لجلب الإشعارات",
          errors: ["التوكين غير موجود"],
        ));
      }

      final cachedList = prefs.getStringList('favorite_properties');
      if (cachedList != null && cachedList.isNotEmpty) {
        final properties = cachedList
            .map((e) => RecommendedProperty.fromJson(jsonDecode(e)))
            .toList();
        print("📦 [DEBUG] Loaded favorite properties from SharedPreferences");
        return Right(properties);
      }

      print("🌐 [DEBUG] No local cache found. Fetching from API...");

      final Either<Failure, List<RecommendedProperty>> response =
      await apiService.getFavoriteProperties(token: token);

      return await response.fold(
            (failure) async {
          print("❌ [DEBUG] Failure in getFavoriteProperties Repo: $failure");
          return Left(failure);
        },
            (properties) async {
          if (properties.isEmpty) {
            print("⚠️ [DEBUG] API returned no favorite properties. Clearing cache...");
            await prefs.remove('favorite_properties');
          } else {
            print("✅ [DEBUG] getFavoriteProperties received from ApiService: $properties");
            final encodedList = properties.map((e) => jsonEncode(e.toJson())).toList();
            await prefs.setStringList('favorite_properties', encodedList);
            print("📦 [DEBUG] Favorite properties saved to SharedPreferences");
          }

          return Right(properties);
        },
      );
    } catch (e) {
      print("❗ [DEBUG] Unexpected Error in getFavoritePropertiesRepoImp: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء جلب الشقق المفضلة",
        errors: [e.toString()],
      ));
    }
  }
}
