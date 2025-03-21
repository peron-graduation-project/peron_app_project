import 'package:flutter/material.dart' ;
import 'package:peron_project/features/splash/presentation/view/views/splash_body.dart' ;

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SplashBody(),
    );
  }
}
