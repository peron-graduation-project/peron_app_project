import 'package:equatable/equatable.dart';
import '../../../data/models/message_model.dart';

abstract class GetConversationState extends Equatable {
  const GetConversationState();

  @override
  List<Object?> get props => [];
}

class GetConversationStateInitial extends GetConversationState {}

class GetConversationStateLoading extends GetConversationState {}

class GetConversationStateSuccess extends GetConversationState {
  final List<Message> conversations;

  const GetConversationStateSuccess({required this.conversations});

  @override
  List<Object?> get props => [conversations];
}

class GetConversationStateFailure extends GetConversationState {
  final String errorMessage;

  const GetConversationStateFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
