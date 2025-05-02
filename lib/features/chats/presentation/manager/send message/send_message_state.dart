import 'package:equatable/equatable.dart';

abstract class SendMessageState extends Equatable {

  const SendMessageState();

  @override
  List<Object?> get props => [];
}

class SendMessageStateInitial extends SendMessageState {
  const SendMessageStateInitial();
}

class SendMessageStateLoading extends SendMessageState {
  const SendMessageStateLoading();
}

class SendMessageStateSuccess extends SendMessageState {
  const SendMessageStateSuccess();
}

class SendMessageStateFailure extends SendMessageState {
  final String errorMessage;

  const SendMessageStateFailure({
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorMessage,];
}
