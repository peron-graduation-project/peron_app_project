import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repos/get profile/get_profile_repo.dart';
import 'get_profile_state.dart';

class GetProfileCubit extends Cubit<GetProfileState> {
  final ProfileRepo getProfileRepo;

  GetProfileCubit(this.getProfileRepo) : super(GetProfileInitial());

  Future<void> getProfile() async {
    _log('Start fetching profile...');
    emit(GetProfileLoading());
    _log('State emitted: GetProfileLoading');

    final result = await getProfileRepo.getProfile();

    result.fold(
          (failure) {
        emit(GetProfileError(message: failure.errorMessage));
        _log('State emitted: GetProfileError - ${failure.errorMessage}');
      },
          (profile) {
        if (profile != null) {
          emit(GetProfileLoaded(profile: profile));
          _log(
            'State emitted: GetProfileLoaded - Name: ${profile.fullName}, Image: ${profile.profilePictureUrl}',
          );
        } else {
          final errorMsg = 'بيانات البروفايل غير متوفرة';
          emit(GetProfileError(message: errorMsg));
          _log('State emitted: GetProfileError - $errorMsg');
        }
      },
    );
  }

  String? get getName {
    if (state is GetProfileLoaded) {
      return (state as GetProfileLoaded).profile.email;
    }
    return null;
  }

  void _log(String message) {
    print('[GetProfileCubit] $message');
  }
}
