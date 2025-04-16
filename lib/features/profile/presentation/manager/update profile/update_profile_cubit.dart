import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/features/profile/domain/repos/update%20profile/update_profile_repo.dart';
import 'package:peron_project/features/profile/presentation/manager/update%20profile/update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final UpdateProfileRepo updateProfileRepo;

  UpdateProfileCubit(this.updateProfileRepo) : super(UpdateProfileStateInitial());

  Future<void> updateProfile({
    String? profilePicture,
    required String fullName,
  }) async {
    emit(UpdateProfileStateLoading());
    print('updateProfileCubit: Emitted updateProfileLoading');

    final result = await updateProfileRepo.updateProfile (profilePicture: profilePicture, fullName: fullName,);
    print('updateProfileCubit: updateProfileCubitRepo.updateProfileCubit() completed');

    result.fold(
          (failure) {
        emit(UpdateProfileStateFailure(failure.errorMessage));
        print('updateProfileCubit: Emitted updateProfileFailure with error: ${failure.errorMessage}');
      },
          (message) {
        emit(UpdateProfileStateSuccess(message));
        print('updateProfileCubit: Emitted updateProfileSuccess with message: $message');
      },
    );
  }
}