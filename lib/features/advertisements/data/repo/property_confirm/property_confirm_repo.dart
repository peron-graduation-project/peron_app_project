import 'package:dartz/dartz.dart';
import 'package:peron_project/features/advertisements/data/property_model.dart';

import '../../../../../core/error/failure.dart';

abstract class PropertyConfirmRepo {
  Future<Either<Failure, String>> propertyConfirm({required String sessionId});
  Future<Either<Failure, String>> propertyCreate({
    required PropertyFormData property,
  });
}
