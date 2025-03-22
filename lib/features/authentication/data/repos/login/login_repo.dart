import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../models/user_model.dart';

abstract class LoginRepo {
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
    required bool rememberMe,
  });
}
