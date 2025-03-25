import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';

abstract class CheckOtpRepo {
  Future<Either<Failure, bool>> checkOtp({required String email, required String otpCode});
}
