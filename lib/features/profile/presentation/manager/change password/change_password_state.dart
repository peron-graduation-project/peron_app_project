abstract class ChangePasswordState {}

class ChangePasswordStateInitial extends ChangePasswordState {}

class ChangePasswordStateLoading extends ChangePasswordState {}

class ChangePasswordStateSuccess extends ChangePasswordState {
  final String message;

  ChangePasswordStateSuccess(this.message);
}

class ChangePasswordStateFailure extends ChangePasswordState {
  final String errorMessage;

  ChangePasswordStateFailure(this.errorMessage);
}
