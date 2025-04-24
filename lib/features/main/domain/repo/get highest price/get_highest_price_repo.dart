import 'package:dartz/dartz.dart';
import 'package:peron_project/features/main/data/models/recommended_property.dart';
import '../../../../../core/error/failure.dart';

abstract class GetHighestPriceRepo {
  Future<Either<Failure, List<RecommendedProperty>>> getHighestPrice();
}
