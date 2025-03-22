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
    return _handleApiCall(
          () async => apiService.verifyOtp(email: email, otpCode: otpCode),
      "التحقق من OTP",
    );
  }

  @override
  Future<Either<Failure, String>> resendOtp({required String email}) async {
    return _handleApiCall(
          () async => apiService.sendOtp(email),
      "إعادة إرسال OTP",
    );
  }

  Future<Either<Failure, T>> _handleApiCall<T>(
      Future<Either<Failure, T>> Function() apiCall,
      String actionName,
      ) async {
    try {
      print("🔵 بدء عملية $actionName...");
      final response = await apiCall();

      return response.fold(
            (failure) {
          print("🔴 فشل في $actionName: ${failure.errorMessage}");
          return Left(failure);
        },
            (result) {
          print("🟢 نجاح في $actionName: $result");
          return Right(result);
        },
      );
    } on DioException catch (e) {
      print("🔴 خطأ Dio أثناء $actionName: ${e.message}");
      return Left(ServiceFailure.fromDioError(e));
    } catch (e) {
      print("🔴 خطأ غير متوقع أثناء $actionName: $e");
      return Left(ServiceFailure(errorMessage: e.toString(), errors: [e.toString()]));
    }
  }
}