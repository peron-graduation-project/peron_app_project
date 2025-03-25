import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';

abstract class ResetPasswordRepo {
  Future<Either<Failure, String>> resetPassword({
    required Map<String, dynamic> body
  });
}
