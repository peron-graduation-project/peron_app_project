import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/features/profile/domain/repos/delete%20account/delete_account_repo.dart';
import 'package:peron_project/features/profile/presentation/manager/delete%20account/delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  final DeleteAccountRepo deleteAccountRepo;

  DeleteAccountCubit(this.deleteAccountRepo) : super(DeleteAccountInitial());

  Future<void> deleteAccount() async {
    emit(DeleteAccountLoading());
    print('DeleteAccountCubit: Emitted DeleteAccountLoading'); // إضافة Log

    final result = await deleteAccountRepo.deleteAccount ();
    print('DeleteAccountCubit: deleteAccountRepo.deleteAccount() completed'); // إضافة Log

    result.fold(
          (failure) {
        emit(DeleteAccountFailure(failure.errorMessage));
        print('DeleteAccountCubit: Emitted DeleteAccountFailure with error: ${failure.errorMessage}'); // إضافة Log
      },
          (message) {
        emit(DeleteAccountSuccess(message));
        print('DeleteAccountCubit: Emitted DeleteAccountSuccess with message: $message'); // إضافة Log
      },
    );
  }
}