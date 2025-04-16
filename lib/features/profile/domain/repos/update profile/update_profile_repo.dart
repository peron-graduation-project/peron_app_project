import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';

abstract class UpdateProfileRepo {
  Future<Either<Failure, String>> updateProfile({
    required String fullName,
    String? profilePicture,
  });
}