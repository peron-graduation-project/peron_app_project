
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';

abstract class SendVerificationCodeRepo{
  Future<Either<Failure,String>> sendVerificationCode(String phoneNumber);
}