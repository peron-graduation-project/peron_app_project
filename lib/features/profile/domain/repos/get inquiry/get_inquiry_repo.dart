import 'package:dartz/dartz.dart';
import 'package:peron_project/features/profile/data/models/inquiry_model.dart';
import '../../../../../core/error/failure.dart';

abstract class GetInquiryRepo {
  Future<Either<Failure, List<InquiryModel>>> getInquiry();
}
