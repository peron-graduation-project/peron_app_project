import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/features/profile/presentation/manager/update%20profile/update_profile_state.dart';
import '../../../domain/repos/update profile/update_profile_repo.dart';
import '../get profile/get_profile_cubit.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final UpdateProfileRepo updateProfileRepo;
  final GetProfileCubit getProfileCubit;

  UpdateProfileCubit(this.updateProfileRepo, this.getProfileCubit)
      : super(UpdateProfileStateInitial());

  Future<void> updateProfile({
    String? profilePicture,
    required String fullName,
  }) async {
    emit(UpdateProfileStateLoading());
    print('[UpdateProfileCubit] Emitting: UpdateProfileStateLoading');

    final result = await updateProfileRepo.updateProfile(
      profilePicture: profilePicture,
      fullName: fullName,
    );

    result.fold(
          (failure) {
        emit(UpdateProfileStateFailure(failure.errorMessage));
        print('[UpdateProfileCubit] Failure: ${failure.errorMessage}');
      },
          (message) {
        emit(UpdateProfileStateSuccess(message));
        print('[UpdateProfileCubit] Success: $message');

        getProfileCubit.getProfile();
      },
    );
  }
}
