import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/images.dart';
import 'package:peron_project/core/widgets/custom_button.dart';
import 'package:peron_project/features/onboarding/data/page_model.dart';

import '../../../../../core/navigator/page_routes_name.dart';
import '../widgets/custom_smooth_page_indicator.dart';

class OnBoardingBody extends StatefulWidget {
  const OnBoardingBody({super.key});

  @override
  State<OnBoardingBody> createState() => _OnBoardingBodyState();
}

class _OnBoardingBodyState extends State<OnBoardingBody> {
  late PageController _controller;
  int index = 0;

  final List<Pages> pagesList = [
    Pages(
      image: Images.onBoarding1,
      title: 'شقتك تستاهل المستأجر المثالي!',
      subTitle: 'اعرض شقتك للإيجار بسهولة ووصلها لأكبر عدد من الباحثين عن سكن.',
    ),
    Pages(
      image: Images.onBoarding2,
      title: 'دور على شقتك بسهولة',
      subTitle: 'استكشف أفضل الشقق للإيجار، تواصل مباشرة مع المالك، واختر المكان المناسب لك بكل ثقة وسهولة.',
    ),
    Pages(
      image: Images.onBoarding3,
      title: 'تجربة تأجير ذكية وآمنة',
      subTitle: 'ابحث، تواصل، واتفق بكل راحة. احصل على أفضل الفرص سواء كنت مالكًا أو مستأجرًا، وابدأ رحلتك معنا اليوم',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  void navigateToHome() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      PageRouteName.signup,
          (route) => false,
    );
  }

  void goToNextPage() {
    if (index < pagesList.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      navigateToHome();
    }
  }

  Widget buildButtons() {
    return index == pagesList.length - 1
        ? CustomButton(
      textColor: Colors.white,
      text: 'ابدأ',
      backgroundColor: AppColors.primaryColor,
      onPressed: navigateToHome,
    )
        : Column(
      children: [
        CustomButton(
          textColor: Colors.white,
          text: 'التالي',
          backgroundColor: AppColors.primaryColor,
          onPressed: goToNextPage,
        ),
        const SizedBox(height: 16),
        CustomButton(
          textColor: AppColors.primaryColor,
          text: 'تخطي',
          backgroundColor: Colors.white,
          decoration: TextDecoration.underline,
          onPressed: navigateToHome,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        itemCount: pagesList.length,
        onPageChanged: (value) => setState(() => index = value),
        itemBuilder: (context, index) => Stack(
          children: [
            Image.asset(
              width: double.infinity,
              pagesList[index].image,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ClipPath(
                clipper: CurveClipper(),
                child: Container(
                  height: screenSize.height * 0.55,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.07,
                      vertical: screenSize.height * 0.08,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          pagesList[index].title,
                          style: theme.titleSmall?.copyWith(
                            fontSize: screenSize.width * 0.06,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          pagesList[index].subTitle,
                          maxLines: 2,
                          style: theme.bodySmall?.copyWith(
                            fontSize: screenSize.width * 0.04,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 28),
                        CustomSmoothPageIndicator(
                          controller: _controller,
                          pagesList: pagesList,
                        ),
                        const SizedBox(height: 32),
                        buildButtons(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 50);
    path.quadraticBezierTo(size.width / 2, 0, size.width, 50);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
