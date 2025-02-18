import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peron_project/core/helper/images.dart';
import 'package:peron_project/features/splash/presentation/view/widgets/sliding_text.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation <Offset> slidingAnimation;

  @override
  void initState() {
    super.initState();
    initSlidingAnimation();
    // navigateToHome();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SvgPicture.asset(
          Images.kLogo,
        ),
        SlidingText(slidingAnimation: slidingAnimation),
      ],
    );
  }

  Future<void> initSlidingAnimation() async {
    animationController =
        AnimationController(vsync: this, duration: const Duration(
            seconds: 5
        ));
    slidingAnimation =
        Tween<Offset>(begin: const Offset(0, 2), end: const Offset(0, 0))
            .animate(animationController);
    animationController.forward();
  }

  void navigateToHome() {
    Future.delayed(const Duration(seconds: 2), () {});
  }
}