import 'package:dartz/dartz.dart';
import 'package:peron_project/core/utils/property_model.dart';

import '../../../../../core/error/failure.dart';

abstract class GetSearchRepo {
Future<Either<Failure, List<Property>>> getSearchProperties(String location);
}
