import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';

abstract class DeletefavoriteRepo {
  Future<Either<Failure, String>> deleteFavorite(int propertyId);
}
