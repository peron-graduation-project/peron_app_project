import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';

abstract class ForgetPasswordRepo {
  Future<Either<Failure, String>> forgotPassword({
    required String email,
  });
}
