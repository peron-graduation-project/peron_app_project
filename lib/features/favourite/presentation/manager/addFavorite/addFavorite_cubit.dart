import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/features/favourite/data/repos/addFavorite/addFavorite_repo.dart';
import 'package:peron_project/features/favourite/presentation/manager/addFavorite/addFavorite_state.dart';

class AddfavoriteCubit extends Cubit<AddfavoriteState> {
  final AddfavoriteRepo addfavoriteRepo;

  AddfavoriteCubit(this.addfavoriteRepo) : super(AddFavoriteInitial());

  Future<void> addFavorite({ required int id}) async {
    try {
      emit(AddFavoriteLoading()); 

      
      final result = await addfavoriteRepo.addFavorite(id);

      
      result.fold(
        (failure) {
          
          emit(AddFavoriteFailuer(failure.errorMessage));
        },
        (message) {
          
          emit(AddFavoriteSuccess(message));
        },
      );
    } catch (e) {
      
      emit(AddFavoriteFailuer("حدث خطأ غير متوقع: ${e.toString()}"));
    }
  }
}
