import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repos/get profile/get_profile_repo.dart';
import 'get_profile_state.dart';

class GetProfileCubit extends Cubit<GetProfileState> {
  final ProfileRepo getProfileRepo;

  GetProfileCubit(this.getProfileRepo) : super(GetProfileInitial());

  Future<void> getProfile() async {
    print('GetProfileCubit: About to emit GetProfileLoading');
    emit(GetProfileLoading());
    print('GetProfileCubit: Emitted GetProfileLoading');

    final result = await getProfileRepo.getProfile();
    result.fold(
          (failure) {
        emit(GetProfileError(message: failure.errorMessage));
        print('GetProfileCubit: Emitted GetProfileError with error: ${failure.errorMessage}');
      },
          (profile) {
        if (profile != null) {
          print('GetProfileCubit: Profile data received - Name: ${profile.fullName}, URL: ${profile.profilePictureUrl}'); // <---- Print عند النجاح
          emit(GetProfileLoaded(profile: profile));
          print('GetProfileCubit: Emitted GetProfileLoaded with profile: ${profile.fullName}, URL: ${profile.profilePictureUrl}');
        } else {
          emit(GetProfileError(message: 'بيانات البروفايل غير متوفرة'));
          print('GetProfileCubit: Emitted GetProfileError with error: بيانات البروفايل غير متوفرة');
        }
      },
    );
  }
}