import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';

abstract class ChangePasswordRepo {
  Future<Either<Failure, String>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  });
}
