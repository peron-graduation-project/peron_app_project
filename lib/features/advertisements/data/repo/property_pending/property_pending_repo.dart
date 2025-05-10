import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../property_model.dart';

abstract class PropertyPendingRepo {
  Future<Either<Failure, String>> postPropertyPending({
    required PropertyFormData property,
  });
}