import 'package:bloc/bloc.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/views/cubit/review_state.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/views/models/rate_param.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/views/review_repo/review_repo.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final ReviewRepo repo;
  ReviewCubit(this.repo) : super(ReviewState(status: ReviewStatus.initial));

  Future<void> getRates(int? id) async {
    emit(state.copyWith(status: ReviewStatus.loading));
    print("hna in rates 0");
    final response = await repo.getRates(id);
    print("hna in rates 3 $response");
    response.fold(
      (l) => emit(
        state.copyWith(
          status: ReviewStatus.failure,
          errorMessage: l.errorMessage,
        ),
      ),
      (r) => emit(state.copyWith(status: ReviewStatus.success, rates: r)),
    );
  }

  // void inertRate(RateParam rate) {
  //   var rates = state.rates;
  //   rates.add(rate);
  // }
}
