import 'package:shared_preferences/shared_preferences.dart';

class OnboardingLocalDataSource {
  static const String onboardingKey = 'onboarding_seen';

  Future<void> cacheOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(onboardingKey, true);
  }

  Future<bool> isOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(onboardingKey) ?? false;
  }
}
