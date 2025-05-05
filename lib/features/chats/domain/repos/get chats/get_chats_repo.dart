import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:peron_project/features/chats/data/models/chat_model.dart';

import '../../../../../core/error/failure.dart';

abstract class GetChatsRepo {
  Future<Either<Failure, List<ChatModel>>> getChats();
  void addNewChat(ChatModel chat);
  void clearChatsCache();
  ValueNotifier<List<ChatModel>> get chatsNotifier;


}