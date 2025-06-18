abstract class PropertyCreateState {}

class PropertyCreateStateInitial extends PropertyCreateState {}

class PropertyCreateStateLoading extends PropertyCreateState {}

class PropertyCreateStateSuccess extends PropertyCreateState {
  final String id;

  PropertyCreateStateSuccess(this.id);
}

class PropertyCreateStateFailure extends PropertyCreateState {
  final String errorMessage;

  PropertyCreateStateFailure(this.errorMessage);
}
