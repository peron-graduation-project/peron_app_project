import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';

abstract class LogoutRepo {
  Future<Either<Failure, String>> logout();
}
