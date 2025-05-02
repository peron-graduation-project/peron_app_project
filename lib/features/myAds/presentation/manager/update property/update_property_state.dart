abstract class UpdatePropertyState {}

class UpdatePropertyStateInitial extends UpdatePropertyState {}

class UpdatePropertyStateLoading extends UpdatePropertyState {}

class UpdatePropertyStateSuccess extends UpdatePropertyState {
  final String message;

  UpdatePropertyStateSuccess(this.message);
}

class UpdatePropertyStateFailure extends UpdatePropertyState {
  final String errorMessage;

  UpdatePropertyStateFailure(this.errorMessage);
}
