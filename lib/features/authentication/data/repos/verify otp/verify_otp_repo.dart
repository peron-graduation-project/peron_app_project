import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';

abstract class VerifyOtpRepo {
  Future<Either<Failure, bool>> verifyOtp({required String email, required String otpCode});
}
