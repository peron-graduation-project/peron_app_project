import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';

abstract class SignupRepo {
  Future<Either<Failure, Map<String,dynamic>>> signUp({required Map<String, dynamic> body});
  Future<Either<Failure, String>> sendOtp(String email);
}
