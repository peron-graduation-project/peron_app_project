import 'package:dartz/dartz.dart';
import 'package:peron_project/core/error/failure.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/views/models/rate.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/views/models/rate_param.dart';

abstract class ReviewRepo {
  Future<Either<Failure, List<Rate>>> getRates(int? id);
  Future<Either<Failure, String>> addRate(RateParam rate);
  Future<Either<Failure, String>> deleteRate(int id);
}
