import 'package:flutter/material.dart';
import 'package:peron_project/features/onboarding/presentation/view/views/on_boarding_body.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardingBody(),
    );
  }
}
