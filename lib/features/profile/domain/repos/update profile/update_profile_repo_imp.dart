import 'package:dartz/dartz.dart';
import 'package:peron_project/features/profile/domain/repos/get%20profile/get_profile_repo.dart'; // استيراد Repo جلب البروفايل
import 'package:peron_project/features/profile/domain/repos/update%20profile/update_profile_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/network/api_service.dart';
import '../get profile/get_profile_repo_imp.dart';

class UpdateProfileRepoImp implements UpdateProfileRepo {
  final ApiService apiService;
  final ProfileRepoImp profileRepoImp; // إضافة instance من ProfileRepoImp
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  UpdateProfileRepoImp(this.apiService, this.profileRepoImp); // تعديل الكونستركتور

  Future<void> _saveProfileData({
    required String fullName,
    String? profilePicture,
  }) async {
    final prefs = await _prefs;
    await prefs.setString('fullName', fullName);
    if (profilePicture != null) {
      await prefs.setString('profilePicture', profilePicture);
    } else {
      await prefs.remove('profilePicture');
    }
    print("💾 [DEBUG] Profile data saved to SharedPreferences");
  }

  @override
  Future<Either<Failure, String>> updateProfile({
    required String fullName,
    String? profilePicture,
  }) async {
    try {
      final prefs = await _prefs;
      final token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        return Left(ServiceFailure(
          errorMessage: "لا يوجد توكين مسجل لتغيير كلمة المرور",
          errors: ["التوكين غير موجود"],
        ));
      }

      final response = await apiService.updateProfile(token: token, fullName: fullName, profilePicturePath: profilePicture);

      print("✅ [DEBUG] update profile repo Response: $response");

      return response.fold(
            (failure) {
          print("❌ [DEBUG] Failure in Repo: $failure");
          return Left(failure);
        },
            (data) async { // جعلنا الدالة async
          if (data is Map<String, dynamic>) {
            if (data.containsKey("message")) {
              _saveProfileData(fullName: fullName, profilePicture: profilePicture);

              // مسح كاش البروفايل بعد التحديث الناجح
              profileRepoImp.clearCachedProfile();
              print("🗑️ [DEBUG] Profile cache cleared after update");

              return Right(data["message"].toString());
            } else {
              return Left(ServiceFailure(
                errorMessage: "الاستجابة لا تحتوي على المفتاح 'message'",
                errors: ["لم يتم العثور على المفتاح 'message' في الاستجابة"],
              ));
            }
          } else {
            return Left(ServiceFailure(
              errorMessage: "الاستجابة غير صحيحة",
              errors: ["البيانات المستلمة ليست من النوع المناسب"],
            ));
          }
        },
      );
    } catch (e) {
      print("❗ [DEBUG] Unexpected Error in update profileRepoImp: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء تعديل البروفايل",
        errors: [e.toString()],
      ));
    }
  }
}