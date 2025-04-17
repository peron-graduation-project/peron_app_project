import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';

abstract class AppRatingRepo {
  Future<Either<Failure, String>> sendAppRating({
    required int star,
  });
}
