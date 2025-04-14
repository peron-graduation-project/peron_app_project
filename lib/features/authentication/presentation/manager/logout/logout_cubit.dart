import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/features/authentication/data/repos/logout/logout_repo.dart';
import 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final LogoutRepo logoutRepo;

  LogoutCubit(this.logoutRepo) : super(LogoutInitial());

  Future<void> logout() async {
    emit(LogoutLoading());

    final result = await logoutRepo.logout ();

    result.fold(
          (failure) {
        emit(LogoutFailure(failure.errorMessage));
      },
          (message) {
        emit(LogoutSuccess(message));
      },
    );
  }
}
