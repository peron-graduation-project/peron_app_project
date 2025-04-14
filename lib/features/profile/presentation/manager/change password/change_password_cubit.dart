import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/features/profile/domain/repos/change%20password/change_password_repo.dart';
import 'package:peron_project/features/profile/presentation/manager/change%20password/change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordRepo changePasswordRepo;

  ChangePasswordCubit(this.changePasswordRepo) : super(ChangePasswordStateInitial());

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,


  }) async {
    emit(ChangePasswordStateLoading());
    print('changePasswordCubit: Emitted changePasswordCubitLoading');

    final result = await changePasswordRepo.changePassword (oldPassword: oldPassword, newPassword: newPassword, confirmPassword: confirmPassword);
    print('changePasswordCubit: changePasswordCubitRepo.changePasswordCubit() completed');

    result.fold(
          (failure) {
        emit(ChangePasswordStateFailure(failure.errorMessage));
        print('changePasswordCubit: Emitted changePasswordFailure with error: ${failure.errorMessage}');
      },
          (message) {
        emit(ChangePasswordStateSuccess(message));
        print('changePasswordCubit: Emitted changePasswordSuccess with message: $message');
      },
    );
  }
}