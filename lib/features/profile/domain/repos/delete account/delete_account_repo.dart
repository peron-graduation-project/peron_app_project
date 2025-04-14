import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';

abstract class DeleteAccountRepo {
  Future<Either<Failure, String>> deleteAccount();
}
