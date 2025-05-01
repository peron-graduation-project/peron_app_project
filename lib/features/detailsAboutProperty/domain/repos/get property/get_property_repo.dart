import 'package:dartz/dartz.dart';
import 'package:peron_project/core/utils/property_model.dart';

import '../../../../../core/error/failure.dart';

abstract class GetPropertyRepo {
  Future<Either<Failure, Property>> getProperty({required int id});

}