import 'package:flutter/material.dart';
import 'package:peron_project/core/navigator/page_routes_name.dart';
import 'package:peron_project/features/authentication/presentation/view/views/login_view.dart';
import 'package:peron_project/features/authentication/presentation/view/views/new_password_view.dart';
import 'package:peron_project/features/authentication/presentation/view/views/sign_up_view.dart';
import 'package:peron_project/features/beginning/presentation/view/views/beginning_view.dart';
import 'package:peron_project/features/home/presentation/view/views/home_view.dart';
import 'package:peron_project/features/notification/presentation/view/views/notification.dart';
import 'package:peron_project/features/onboarding/presentation/view/views/on_boarding.dart';
import 'package:peron_project/features/profile/presentation/view/view/help_screen.dart';
import 'package:peron_project/features/profile/presentation/view/view/login_screen.dart';
import 'package:peron_project/features/profile/presentation/view/view/privacy_policy_screen.dart';
import 'package:peron_project/features/profile/presentation/view/view/settings_screen.dart';
import 'package:peron_project/features/search/presentation/view/views/search_view.dart';
import 'package:peron_project/features/splash/presentation/view/views/splash_view.dart';

import '../../features/authentication/presentation/view/views/verification_view.dart';
class RoutesGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PageRouteName.initialRoute:
        return MaterialPageRoute(
          builder: (context) => const SplashView(), settings: settings,
        );
      case PageRouteName.onBoarding:
        return MaterialPageRoute(
          builder: (context) => const OnBoarding(), settings: settings,);
      case PageRouteName.beginning:
        return MaterialPageRoute(
          builder: (context) => const BeginningView(), settings: settings,);
      case PageRouteName.signup:
        return MaterialPageRoute(
          builder: (context) => const SignupView(), settings: settings,);
      case PageRouteName.login:
        return MaterialPageRoute(
          builder: (context) => const LoginView(), settings: settings,);
      case PageRouteName.home:
        return MaterialPageRoute(
          builder: (context) => const HomeView(), settings: settings,);
      // case PageRouteName.forgetPassword:
      //   return MaterialPageRoute(
      //     builder: (context) => const ForgotPasswordScreen(), settings: settings,);
      case PageRouteName.verificationOtp:
        final email = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => VerificationScreen(email: email),
          settings: settings,
        );

      case PageRouteName.newPass:
        return MaterialPageRoute(
          builder: (context) => const NewPasswordScreen(), settings: settings,);
      case PageRouteName.notification:
        return MaterialPageRoute(
          builder: (context) => const NotificationView(), settings: settings,);
      case PageRouteName.search:
        return MaterialPageRoute(
          builder: (context) => const SearchView(), settings: settings,);
           case PageRouteName.loginScreen:
  return MaterialPageRoute(builder: (_) => LoginScreen());
case PageRouteName.privacyPolicyScreen:
  return MaterialPageRoute(builder: (_) => PrivacyPolicyScreen());
case PageRouteName.helpScreen:
  return MaterialPageRoute(builder: (_) => HelpScreen());
case PageRouteName.settingsScreen:
  return MaterialPageRoute(builder: (_) => Settings());

      default:
        return MaterialPageRoute(
          builder: (context) => const SplashView(), settings: settings,
        );
    }
  }
}