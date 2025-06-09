import 'package:dartz/dartz.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../data/chat_pot_model.dart';

abstract class GetChatBotRepo {
  Future<Either<Failure, List<ChatBotMessage>>>getMessages();
  Future<Either<Failure, Map<String, dynamic>>> sendMessage(String message);
}
