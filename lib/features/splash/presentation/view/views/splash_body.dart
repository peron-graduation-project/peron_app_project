import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/images.dart';

import '../../../../../core/navigator/page_routes_name.dart';
import '../../../../onboarding/data/onboarding_data_source.dart';
import '../../../../onboarding/data/onboarding_view_model.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  _SplashBodyState createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody>
    with SingleTickerProviderStateMixin<SplashBody> {
  late AnimationController _controller;
  late Animation<double> _greenCircleAnimation;
  late Animation<double> _bottomGreenCircleAnimation;
  late Animation<double> _whiteCircleAnimation;
  late Animation<double> _logoOpacityAnimation;
  late Animation<double> _logoScaleAnimation;
  late OnboardingViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 6),
    )..repeat();

    _greenCircleAnimation = Tween<double>(begin: 0.1, end: 2.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.35, curve: Curves.easeInOut),
      ),
    );

    _bottomGreenCircleAnimation = Tween<double>(begin: 0.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.35, 0.55, curve: Curves.easeInOut),
      ),
    );

    _logoOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.3, 0.85, curve: Curves.easeIn),
      ),
    );

    _logoScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.3, 0.85, curve: Curves.easeInOutBack),
      ),
    );

    _whiteCircleAnimation = Tween<double>(begin: 0.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.60, 1.0, curve: Curves.easeInOut),
      ),
    );

    _controller.forward();
    _controller.addStatusListener((status) {
      _viewModel = OnboardingViewModel(OnboardingLocalDataSource());

      if (status == AnimationStatus.completed) {
        _checkOnboarding();


      }
    });
  }

  void _checkOnboarding() async {
    bool seen = await _viewModel.checkIfOnboardingSeen();
    if (seen) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        PageRouteName.signup,
            (route) => false,
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        PageRouteName.onBoarding,
            (route) => false,
      );    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                painter: CircleRevealPainter(
                  _greenCircleAnimation.value,
                  AppColors.primaryColor,
                  Alignment.topCenter,
                ),
                child: Container(),
              ),
              CustomPaint(
                painter: CircleRevealPainter(
                  _bottomGreenCircleAnimation.value,
                  AppColors.primaryColor,
                  Alignment.bottomCenter,
                ),
                child: Container(),
              ),
              Opacity(
                opacity: _logoOpacityAnimation.value,
                child: Transform.scale(
                  scale: _logoScaleAnimation.value,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        Images.whiteLogo,
                        width: MediaQuery.of(context).size.width * 0.4,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "بيرون",
                        style: theme.titleLarge?.copyWith(
                          fontSize: 37,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              CustomPaint(
                painter: CircleRevealPainter(
                  _whiteCircleAnimation.value,
                  Colors.white,
                  Alignment.bottomCenter,
                ),
                child: Container(),
              ),
              if (_whiteCircleAnimation.value >
                  1.5) // When white background appears
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      Images.kLogo,
                      width: MediaQuery.of(context).size.width * 0.4,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "بيرون",
                      style: theme.titleLarge?.copyWith(fontSize: 37),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }
}

class CircleRevealPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Alignment alignment;

  CircleRevealPainter(this.progress, this.color, this.alignment);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    double maxRadius = size.width * 1.5;
    double radius = maxRadius * progress;
    Offset center =
        alignment == Alignment.topCenter
            ? Offset(size.width / 2, 0)
            : Offset(size.width / 2, size.height);
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(CircleRevealPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}
