import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';

abstract class PropertyConfirmRepo {
  Future<Either<Failure, String>> propertyConfirm({required String sessionId});
}
