import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';

abstract class LoginRepo {
  Future<Either<Failure, String>> login(String email, String password);
}
