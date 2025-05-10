abstract class PropertyPendingState {}

class PropertyPendingStateInitial extends PropertyPendingState {}

class PropertyPendingStateLoading extends PropertyPendingState {}

class PropertyPendingStateSuccess extends PropertyPendingState {
  final String url;

  PropertyPendingStateSuccess(this.url);
}

class PropertyPendingStateFailure extends PropertyPendingState {
  final String errorMessage;

  PropertyPendingStateFailure(this.errorMessage);
}
