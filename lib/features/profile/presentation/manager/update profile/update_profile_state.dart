abstract class UpdateProfileState {}

class UpdateProfileStateInitial extends UpdateProfileState {}

class UpdateProfileStateLoading extends UpdateProfileState {}

class UpdateProfileStateSuccess extends UpdateProfileState {
  final String message;

  UpdateProfileStateSuccess(this.message);
}

class UpdateProfileStateFailure extends UpdateProfileState {
  final String errorMessage;

  UpdateProfileStateFailure(this.errorMessage);
}
