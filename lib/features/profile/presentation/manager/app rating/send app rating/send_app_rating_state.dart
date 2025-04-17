abstract class SendAppRatingState {}

class SendAppRatingStateInitial extends SendAppRatingState {}

class SendAppRatingStateLoading extends SendAppRatingState {}

class SendAppRatingStateSuccess extends SendAppRatingState {
  final String message;

  SendAppRatingStateSuccess(this.message);
}

class SendAppRatingStateFailure extends SendAppRatingState {
  final String errorMessage;

  SendAppRatingStateFailure(this.errorMessage);
}
