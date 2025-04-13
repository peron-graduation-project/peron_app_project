abstract class AddfavoriteState {}

class AddFavoriteInitial extends AddfavoriteState {}

class AddFavoriteLoading extends AddfavoriteState {}

class AddFavoriteSuccess extends AddfavoriteState {
  final String message;

  AddFavoriteSuccess(this.message);
}

class AddFavoriteFailuer extends AddfavoriteState {
  final String errorMessage;

  AddFavoriteFailuer(this.errorMessage);
}
