abstract class DeletefavoriteState {}

class DeleteFavoriteInitial extends DeletefavoriteState {}

class DeleteFavoriteLoading extends DeletefavoriteState {}

class DeleteFavoriteSuccess extends DeletefavoriteState {
  final String message;

  DeleteFavoriteSuccess(this.message);
}

class DeleteFavoriteFailuer extends DeletefavoriteState {
  final String errorMessage;

  DeleteFavoriteFailuer(this.errorMessage);
}
