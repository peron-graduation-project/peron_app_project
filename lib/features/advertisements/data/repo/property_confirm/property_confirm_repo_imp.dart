import 'package:dartz/dartz.dart';
import 'package:peron_project/features/advertisements/data/property_model.dart';
import 'package:peron_project/features/advertisements/data/repo/property_confirm/property_confirm_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/api_service.dart';

class PropertyConfirmRepoImp implements PropertyConfirmRepo {
  final ApiService apiService;

  PropertyConfirmRepoImp(this.apiService);

  @override
  Future<Either<Failure, String>> propertyConfirm({
    required String sessionId,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        return Left(ServiceFailure(
          errorMessage: "لا يوجد توكين مسجل لعملية الدفع",
          errors: ["التوكين غير موجود"],
        ));
      }

      final response = await apiService.getStripeCheckoutSession(
        token: token,
        sessionId: sessionId,
      );

      print("✅ [DEBUG] PropertyConfirmRepoImp Response: $response");

      return response.fold(
            (failure) {
          print("❌ [DEBUG] Failure in Repo: $failure");
          return Left(failure);
        },
            (data) {
          final status = data["status"];
          final message = data["message"];

          if (status == "paid") {
            return Right(message ?? "تم الدفع بنجاح");
          } else {
            return Left(ServiceFailure(
              errorMessage: "عملية الدفع لم تكتمل بعد",
              errors: ["Status: $status", "Message: ${message ?? 'غير متوفر'}"],
            ));
          }
        },
      );
    } catch (e) {
      print("❗ [DEBUG] Unexpected Error in PropertyConfirmRepoImp: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء عملية الدفع",
        errors: [e.toString()],
      ));
    }
  }

  @override
  Future<Either<Failure, String>> propertyCreate({
    required PropertyFormData property,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        return Left(ServiceFailure(
          errorMessage: "لا يوجد توكين مسجل لعملية الدفع",
          errors: ["التوكين غير موجود"],
        ));
      }

      final response = await apiService.postPropertyCreate(
        token: token,
        property: property,
      );

      print("✅ [DEBUG] PropertyCreateRepoImp Response: $response");

      return response.fold(
            (failure) {
          print("❌ [DEBUG] Failure in Repo: $failure");
          return Left(failure);
        },
            (data) {
          if (data is String) {
            return Right(data);
          } else {
            return Left(ServiceFailure(
              errorMessage: "الاستجابة غير صحيحة",
              errors: ["البيانات المستلمة ليست من النوع المناسب"],
            ));
          }
        },
      );
    } catch (e) {
      print("❗ [DEBUG] Unexpected Error in PropertyConfirmRepoImp: $e");
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ غير متوقع أثناء عملية الدفع",
        errors: [e.toString()],
      ));
    }
  }
}
