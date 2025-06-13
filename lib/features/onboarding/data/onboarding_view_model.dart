
import 'package:peron_project/features/onboarding/data/onboarding_data_source.dart';

class OnboardingViewModel {
  final OnboardingLocalDataSource _localDataSource;

  OnboardingViewModel(this._localDataSource);

  Future<void> setOnboardingSeen() async {
    await _localDataSource.cacheOnboardingSeen();
  }

  Future<bool> checkIfOnboardingSeen() async {
    return await _localDataSource.isOnboardingSeen();
  }
}
