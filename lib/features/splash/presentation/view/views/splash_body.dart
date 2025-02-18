import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peron_project/core/helper/images.dart';
import 'package:peron_project/features/splash/presentation/view/widgets/sliding_text.dart';
import '../../../../../core/navigator/page_routes_name.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;

  @override
  void initState() {
    super.initState();
    initSlidingAnimation();
    navigateToOnBoarding();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SvgPicture.asset(
          Images.kLogo,
          width: MediaQuery.of(context).size.width * 0.5,
        ),
        const SizedBox(height: 20),
        SlideTransition(
          position: slidingAnimation,
          child:  SlidingText(slidingAnimation: slidingAnimation,),
        ),
      ],
    );
  }

  Future<void> initSlidingAnimation() async {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    slidingAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));
    animationController.forward();
  }


  void navigateToOnBoarding() {
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          PageRouteName.onBoarding,
              (route) => false,
        );
      }
    });
  }
}
