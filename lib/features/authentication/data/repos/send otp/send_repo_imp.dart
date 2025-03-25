import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:peron_project/features/authentication/data/repos/send%20otp/send_repo.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/network/api_service.dart';

class SendOtpRepoImp implements SendOtpRepo {
  final ApiService apiService;

  SendOtpRepoImp({required this.apiService});

  @override
  Future<Either<Failure, String>> sendOtp(String email) async {
    try {
      return await apiService.sendOtp(email);
    } on DioException catch (e) {
      return Left(ServiceFailure.fromDioError(e));
    } catch (e) {
      return Left(ServiceFailure(
        errorMessage: "حدث خطأ أثناء إرسال OTP",
        errors: [e.toString()],
      ));
    }
  }
}
