import 'package:flutter/material.dart';
import 'package:peron_project/core/navigator/page_routes_name.dart';
import 'package:peron_project/features/authentication/presentation/view/views/login_view.dart';
import 'package:peron_project/features/authentication/presentation/view/views/sign_up_view.dart';
import 'package:peron_project/features/beginning/presentation/view/views/beginning_view.dart';
import 'package:peron_project/features/home/presentation/view/views/home_view.dart';
import 'package:peron_project/features/onboarding/presentation/view/views/on_boarding.dart';
import 'package:peron_project/features/splash/presentation/view/views/splash_view.dart';
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
          builder: (context) => const Login(), settings: settings,);
      case PageRouteName.home:
        return MaterialPageRoute(
          builder: (context) => const HomeView(), settings: settings,);
      default:
        return MaterialPageRoute(
          builder: (context) => const SplashView(), settings: settings,
        );
    }
  }
}