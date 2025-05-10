abstract class PropertyConfirmState {}

class PropertyConfirmStateInitial extends PropertyConfirmState {}

class PropertyConfirmStateLoading extends PropertyConfirmState {}

class PropertyConfirmStateSuccess extends PropertyConfirmState {
  final String stripeUrl;

  PropertyConfirmStateSuccess(this.stripeUrl);
}

class PropertyConfirmStateFailure extends PropertyConfirmState {
  final String errorMessage;

  PropertyConfirmStateFailure(this.errorMessage);
}
