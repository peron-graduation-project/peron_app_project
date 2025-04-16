import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/api_service.dart';
import '../../../data/models/profile_model.dart';
import 'get_profile_repo.dart';

class ProfileRepoImp implements ProfileRepo {
  final ApiService apiService;
  final SharedPreferences? sharedPreferences;

  ProfileRepoImp(this.apiService, [this.sharedPreferences]);

  Future<Either<Failure, ProfileModel?>> getCachedProfile() async {
    if (sharedPreferences == null) {
      return const Right(null);
    }
    try {
      final cachedProfile = sharedPreferences!.getString('cached_profile');
      if (cachedProfile != null) {
        final json = jsonDecode(cachedProfile) as Map<String, dynamic>;
        return Right(ProfileModel.fromJson(json));
      } else {
        return const Right(null);
      }
    } catch (e) {
      return Left(ServiceFailure(errorMessage: 'فشل في جلب بيانات البروفايل المحفوظة', errors: []));
    }
  }

  Future<bool> _cacheProfile(ProfileModel profile) async {
    if (sharedPreferences == null) {
      return false;
    }
    try {
      final jsonString = jsonEncode(profile.toJson());
      return await sharedPreferences!.setString('cached_profile', jsonString);
    } catch (e) {
      print("❗ [DEBUG] Error caching profile: $e");
      return false;
    }
  }

  @override
  Future<Either<Failure, ProfileModel>> getProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        return Left(ServiceFailure(
          errorMessage: "لا يوجد توكين مسجل لجلب بيانات البروفايل",
          errors: ["التوكين غير موجود"],
        ));
      }

      final response = await apiService.getProfile(token: token);

      print("✅ [DEBUG] ProfileRepoImp Response: $response");

      return response.fold(
            (failure) {
          print("❌ [DEBUG] Failure in Profile Repo: $failure");
          return Left(failure);
        },
            (data) {
          print("✅ [DEBUG] Data before conversion: $data");
          try {
            _cacheProfile(data);
            return Right(data);
          } catch (e) {
            return Left(ServiceFailure(
              errorMessage: "فشل في تحويل بيانات البروفايل",
              errors: [e.toString(), data.toString()],
            ));
          }
        },
      );
    } catch (e) {
      print("❗ [DEBUG] Unexpected Error in ProfileRepoImp: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء جلب بيانات البروفايل",
        errors: [e.toString()],
      ));
    }
  }

  Future<void> clearCachedProfile() async {
    if (sharedPreferences != null) {
      await sharedPreferences!.remove('cached_profile');
      print("🗑️ [DEBUG] Profile cache cleared");
    }
  }
}