import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:peron_project/features/authentication/data/repos/verify%20otp/verify_otp_repo.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/api_service.dart';

class VerifyOtpRepoImpl implements VerifyOtpRepo {
  final ApiService apiService;

  VerifyOtpRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, bool>> verifyOtp({
    required String email,
    required String otpCode,
  }) async {
    try {
      print("🔵 بدء عملية التحقق من OTP...");
      final result = await apiService.verifyOtp(email: email, otpCode: otpCode);
      print("🟢 تم التحقق من OTP بنجاح: $result");
      return result;
    } on DioException catch (e) {
      print("🔴 خطأ Dio أثناء التحقق من OTP: ${e.message}");
      return Left(ServiceFailure.fromDioError(e));
    } catch (e) {
      print("🔴 خطأ غير متوقع أثناء التحقق من OTP: $e");
      return Left(ServiceFailure(
        errorMessage: e.toString(),
        errors: [e.toString()],
      ));
    }
  }

}
