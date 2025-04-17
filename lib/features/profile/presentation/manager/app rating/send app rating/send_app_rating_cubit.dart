import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/features/profile/domain/repos/app%20rating/app_rating_repo_imp.dart';
import 'package:peron_project/features/profile/presentation/manager/app%20rating/send%20app%20rating/send_app_rating_state.dart';

class SendAppRatingCubit extends Cubit<SendAppRatingState> {
  final AppRatingRepoImp sendAppRatingRepoImp;

  SendAppRatingCubit(this.sendAppRatingRepoImp) : super(SendAppRatingStateInitial());

  Future<void> sendAppRating({
    required int star,
    }) async {
    try {
      emit(SendAppRatingStateInitial());


      final result = await sendAppRatingRepoImp.sendAppRating(
         star: star
      );
      result.fold(
            (failure) {

          emit(SendAppRatingStateFailure(failure.errorMessage));
        },
            (message) {

          emit(SendAppRatingStateSuccess(message));
        },
      );
    } catch (e) {

      emit(SendAppRatingStateFailure("حدث خطأ غير متوقع: ${e.toString()}"));
    }
  }
}
