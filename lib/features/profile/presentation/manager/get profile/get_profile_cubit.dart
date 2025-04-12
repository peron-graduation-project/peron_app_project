
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repos/get_profile_repo.dart';
import 'get_profile_state.dart';

class GetProfileCubit extends Cubit<GetProfileState> {
  final ProfileRepo profileRepo;

  GetProfileCubit(this.profileRepo) : super(GetProfileInitial());

  Future<void> getProfile() async {
    emit(GetProfileLoading());

    final result = await profileRepo.getProfile();

    result.fold(
          (failure) {
        emit(GetProfileError(message: failure.errorMessage));
      },
          (profile) {
        print("✅ [DEBUG] Profile in Cubit: $profile");
        emit(GetProfileLoaded(profile: profile));
      },
    );
  }
}