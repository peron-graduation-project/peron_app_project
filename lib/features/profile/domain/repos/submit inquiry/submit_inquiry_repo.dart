import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';

abstract class SubmitInquiryRepo {
  Future<Either<Failure, String>> submitInquiry({
    required String name,
    required String email,
    required String phone,
    required String message,
  });
}
