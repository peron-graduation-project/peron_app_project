import 'package:dartz/dartz.dart';
import 'package:peron_project/features/advertisements/data/repo/property_pending/property_pending_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/network/api_service.dart';
import '../../property_model.dart';

class PropertyPendingRepoImp implements PropertyPendingRepo {
  final ApiService apiService;

  PropertyPendingRepoImp(this.apiService);

  @override
  Future<Either<Failure, String>> postPropertyPending({
    required PropertyFormData property,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        return Left(ServiceFailure(
          errorMessage: "لا يوجد توكين مسجل لرفع الشقة",
          errors: ["التوكين غير موجود"],
        ));
      }

      final response = await apiService.postPropertyPending(
        token: token,
        property: property,
      );

      print("✅ [DEBUG] PropertyPendingRepoImp Response: $response");

      return response.fold(
            (failure) {
          print("❌ [DEBUG] Failure in Repo: $failure");
          return Left(failure);
        },
            (data) {
          if (data is Map<String, dynamic> && data.containsKey("paypalurl")) {
            final url = data["paypalurl"];
            if (url is String) {
              return Right(url);
            } else {
              return Left(ServiceFailure(
                errorMessage: "رابط الدفع ليس من النوع String",
                errors: ["نوع البيانات غير متوقع في المفتاح 'paypalurl'"],
              ));
            }
          } else {
            return Left(ServiceFailure(
              errorMessage: "الاستجابة لا تحتوي على المفتاح 'paypalurl'",
              errors: ["لم يتم العثور على المفتاح 'paypalurl' في الاستجابة"],
            ));
          }
        },
      );
    } catch (e) {
      print("❗ [DEBUG] Unexpected Error in PropertyPendingRepoImp: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء رفع الشقة",
        errors: [e.toString()],
      ));
    }
  }
}
