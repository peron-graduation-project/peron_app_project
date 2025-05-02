import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/utils/property_model.dart';

abstract class EditPropertyRepo {
  Future<Either<Failure, String>> editProperty({
    required Property property,
    required int id,
  });
}
