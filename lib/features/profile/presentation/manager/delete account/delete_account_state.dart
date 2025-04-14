abstract class DeleteAccountState {}

class DeleteAccountInitial extends DeleteAccountState {}

class DeleteAccountLoading extends DeleteAccountState {}

class DeleteAccountSuccess extends DeleteAccountState {
  final String message;

  DeleteAccountSuccess(this.message);
}

class DeleteAccountFailure extends DeleteAccountState {
  final String errorMessage;

  DeleteAccountFailure(this.errorMessage);
}
