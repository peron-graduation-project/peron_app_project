import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/api_service.dart';
import 'check_otp_repo.dart';

class CheckOtpRepoImpl implements CheckOtpRepo {
  final ApiService apiService;

  CheckOtpRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, bool>> checkOtp({
    required String email,
    required String otpCode,
  }) async {
    try {
      print("🔵 بدء عملية التحقق من OTP...");
      final result = await apiService.checkOtp(email: email, otpCode: otpCode);
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





