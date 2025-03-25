import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:peron_project/features/authentication/data/repos/resend%20otp/resend_otp_repo.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/api_service.dart';

class ResendOtpRepoImp implements ResendOtpRepo {
  final ApiService apiService;

  ResendOtpRepoImp({required this.apiService});

  @override
  Future<Either<Failure, String>> resendOtp({required String email}) async {
    try {
      print("🔵 بدء عملية إعادة إرسال OTP...");
      final result = await apiService.sendOtp(email);
      print("🟢 تم إرسال OTP بنجاح: $result");
      return result;
    } on DioException catch (e) {
      print("🔴 خطأ Dio أثناء إرسال OTP: ${e.message}");
      return Left(ServiceFailure.fromDioError(e));
    } catch (e) {
      print("🔴 خطأ غير متوقع أثناء إرسال OTP: $e");
      return Left(ServiceFailure(
        errorMessage: e.toString(),
        errors: [e.toString()],
      ));
    }
  }
}
