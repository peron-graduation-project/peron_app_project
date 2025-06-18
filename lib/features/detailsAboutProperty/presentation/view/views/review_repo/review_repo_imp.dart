import 'package:dartz/dartz.dart';
import 'package:peron_project/core/error/failure.dart';
import 'package:peron_project/core/network/api_service.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/views/models/rate.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/views/models/rate_param.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/views/review_repo/review_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewRepoImp implements ReviewRepo {
  final ApiService apiService;

  ReviewRepoImp(this.apiService);

  @override
  Future<Either<Failure, List<Rate>>> getRates(int? id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        return Left(
          ServiceFailure(
            errorMessage: "لا يوجد توكين مسجل لعملية الدفع",
            errors: ["التوكين غير موجود"],
          ),
        );
      }
      print("hna in rates 1");
      final response = await apiService.getRates(token, id: id);
      print("hna in rates 1 $response");

      return response.fold((l) => Left(l), (r) => Right(r));
    } catch (e) {
      print("❗ [DEBUG] Unexpected Error in PropertyConfirmRepoImp: $e");
      return Left(
        ServiceFailure(
          errorMessage: "حدث خطأ غير متوقع أثناء عملية الدفع",
          errors: [e.toString()],
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String>> addRate(RateParam rate) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        return Left(
          ServiceFailure(
            errorMessage: "لا يوجد توكين مسجل لعملية الدفع",
            errors: ["التوكين غير موجود"],
          ),
        );
      }
      print("hna in rates 1");
      final response = await apiService.addRate(rate, token);
      print("hna in rates 1 $response");

      return response.fold((l) => Left(l), (r) => Right(r));
    } catch (e) {
      print("❗ [DEBUG] Unexpected Error in PropertyConfirmRepoImp: $e");
      return Left(
        ServiceFailure(
          errorMessage: "حدث خطأ غير متوقع أثناء عملية الدفع",
          errors: [e.toString()],
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String>> deleteRate(int id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        return Left(
          ServiceFailure(
            errorMessage: "لا يوجد توكين مسجل لعملية الدفع",
            errors: ["التوكين غير موجود"],
          ),
        );
      }
      print("hna in rates 1");
      final response = await apiService.deleteRate(id, token);
      print("hna in rates 1 $response");

      return response.fold((l) => Left(l), (r) => Right(r));
    } catch (e) {
      print("❗ [DEBUG] Unexpected Error in PropertyConfirmRepoImp: $e");
      return Left(
        ServiceFailure(
          errorMessage: "حدث خطأ غير متوقع أثناء عملية الدفع",
          errors: [e.toString()],
        ),
      );
    }
  }
}
