import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/features/favourite/data/repos/removeFavorite/removeFavorite_repo.dart';
import 'package:peron_project/features/favourite/presentation/manager/deleteFavorite/deleteFavorite_state.dart';

class DeletefavoriteCubit extends Cubit<DeletefavoriteState> {
  final DeletefavoriteRepo deletefavoriteRepo;

  DeletefavoriteCubit(this.deletefavoriteRepo) : super(DeleteFavoriteInitial());

  Future<void> deleteFavorite({ required int id}) async {
    try {
      emit(DeleteFavoriteLoading()); 

      
      final result = await deletefavoriteRepo.deleteFavorite(id);

      
      result.fold(
        (failure) {
          
          emit(DeleteFavoriteFailuer(failure.errorMessage));
        },
        (message) {
          
          emit(DeleteFavoriteSuccess(message));
        },
      );
    } catch (e) {
      
      emit(DeleteFavoriteFailuer("حدث خطأ غير متوقع: ${e.toString()}"));
    }
  }
}
