import 'package:dartz/dartz.dart';
import 'package:peron_project/core/utils/property_model.dart';
import '../../../../../core/error/failure.dart';

abstract class GetNearestRepo {
  Future<Either<Failure, List<Property>>> getNearest({
    required double lat,
    required double lon,
    int? maxResults = 10,
  });
}
