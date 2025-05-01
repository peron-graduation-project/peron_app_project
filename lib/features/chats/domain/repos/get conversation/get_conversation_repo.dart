import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../../data/models/message_model.dart';

abstract class GetConversationRepo {
  Future<Either<Failure, List<Message>>> getconversation({required String id});

}