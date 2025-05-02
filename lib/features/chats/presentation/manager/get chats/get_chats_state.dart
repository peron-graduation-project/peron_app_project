import 'package:equatable/equatable.dart';
import 'package:peron_project/features/chats/data/models/chat_model.dart';

abstract class GetChatsState extends Equatable {
  const GetChatsState();

  @override
  List<Object?> get props => [];
}

class GetChatsStateInitial extends GetChatsState {}

class GetChatsStateLoading extends GetChatsState {}

class GetChatsStateSuccess extends GetChatsState {
  final List<ChatModel> chats;

  const GetChatsStateSuccess({required this.chats});

  @override
  List<Object?> get props => [chats];
}

class GetChatsStateFailure extends GetChatsState {
  final String errorMessage;

  const GetChatsStateFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
