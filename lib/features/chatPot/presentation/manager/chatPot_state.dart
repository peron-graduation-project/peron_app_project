import 'package:equatable/equatable.dart';

import '../../data/chat_pot_model.dart';

abstract class ChatBotState extends Equatable {
  const ChatBotState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatBotState {}

class ChatLoading extends ChatBotState {}

class ChatLoaded extends ChatBotState {
  final List<ChatBotMessage> messages;

  const ChatLoaded(this.messages);

  @override
  List<Object> get props => [messages];
}

class ChatError extends ChatBotState {
  final String errorMessage;

  const ChatError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

  String get error => errorMessage;  
}
