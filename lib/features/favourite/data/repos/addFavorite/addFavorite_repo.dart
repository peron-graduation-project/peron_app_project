import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';

abstract class AddfavoriteRepo {
  Future<Either<Failure, String>> addFavorite(int propertyId);
}
