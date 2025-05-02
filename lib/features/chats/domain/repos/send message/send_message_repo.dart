import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';

abstract class SendMessageRepo{
  Future<Either<Failure, bool>> sendMessage({required String receiverId,required String message});

}