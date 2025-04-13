// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:peron_project/features/favourite/data/repos/removeFavorite/removeFavorite_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/api_service.dart';


class DeletefavImp implements DeletefavoriteRepo {
  final ApiService apiService;

  DeletefavImp(this.apiService);
  
  @override
  Future<Either<Failure, String>> deleteFavorite(int propertyId) async{
        try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        return Left(ServiceFailure(
          errorMessage: "لا يوجد توكين مسجل لاضافة المفضله",
          errors: ["التوكين غير موجود"],
        ));
      }

      final response = await apiService.deleteFavorite(token: token,id: propertyId);

      print("✅ [DEBUG] DeleteFavoriteRepoImp Response: $response");

      return response.fold(
            (failure) {
          print("❌ [DEBUG] Failure in Repo: $failure");
          return Left(failure);
        },
            (data) {
          if (data.containsKey("message")) {
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
      print("❗ [DEBUG] Unexpected Error in DeleteFavoriteRepoImp: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء حذف شقه من المفضلة",
        errors: [e.toString()],
      ));
    }
  }
}

  
