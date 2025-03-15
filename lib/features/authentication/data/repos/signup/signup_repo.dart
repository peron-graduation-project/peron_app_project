import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';

abstract class SignupRepo {
  Future<Either<Failure, String>> signup({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
  });
}
