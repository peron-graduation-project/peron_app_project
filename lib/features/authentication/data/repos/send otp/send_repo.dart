import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';

abstract class SendOtpRepo {
  Future<Either<Failure, String>> sendOtp(String email);
}
