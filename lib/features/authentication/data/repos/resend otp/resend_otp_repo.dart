import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';

abstract class ResendOtpRepo{
  Future<Either<Failure, String>> resendOtp({required String email});

}