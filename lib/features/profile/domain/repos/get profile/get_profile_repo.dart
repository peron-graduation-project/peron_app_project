import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../data/models/profile_model.dart';

abstract class ProfileRepo {
  Future<Either<Failure, ProfileModel>> getProfile();
}