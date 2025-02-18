import 'package:flutter/material.dart';
import 'package:peron_project/core/navigator/page_routes_name.dart';
import 'package:peron_project/features/splash/presentation/view/views/splash_view.dart';
class RoutesGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PageRouteName.initialRoute:
        return MaterialPageRoute(
          builder: (context) => const SplashView(), settings: settings,
        );
      // case PageRouteName.login:
      //   return MaterialPageRoute(
      //     builder: (context) => const LoginView(), settings: settings,);
      default:
        return MaterialPageRoute(
          builder: (context) => const SplashView(), settings: settings,
        );
    }
  }
}