import 'package:bloc/bloc.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/views/cubit/rate_state.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/views/models/rate_param.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/views/review_repo/review_repo.dart';

class RateCubit extends Cubit<RateState> {
  final ReviewRepo repo;
  RateCubit(this.repo) : super(RateState(status: RateStatus.initial));

  Future<void> addRate(RateParam rate) async {
    emit(state.copyWith(status: RateStatus.addRate));
    // print("hna in rates 0");
    final response = await repo.addRate(rate);
    // print("hna in rates 3 $response");
    response.fold(
      (l) => emit(
        state.copyWith(
          status: RateStatus.failure,
          errorMessage: l.errorMessage,
        ),
      ),
      (r) => emit(state.copyWith(status: RateStatus.addedRate, rateId: r)),
    );
  }

  Future<void> deleteRate(int id) async {
    emit(state.copyWith(status: RateStatus.deleteRate));
    // print("hna in rates 0");
    final response = await repo.deleteRate(id);
    // print("hna in rates 3 $response");
    response.fold(
      (l) => emit(
        state.copyWith(
          status: RateStatus.failure,
          errorMessage: l.errorMessage,
        ),
      ),
      (r) => emit(
        state.copyWith(status: RateStatus.deletedRate, deletedMessage: r),
      ),
    );
  }

  void storeRate(int rate) => emit(state.copyWith(stars: rate));
  void resetRate() {
    emit(state.copyWith(stars: 0));
    print("");
  }

  int? get getRate => state.stars;
}
