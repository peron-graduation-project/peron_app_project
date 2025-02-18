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

  List<Pages> pagesList = [
    Pages(
      image: Images.onBoarding1,
      title: 'ابحث عن شقتك بسهولة',
      subTitle:
      'استكشف مئات الشقق المعروضة للإيجار في مختلف المناطق بكل سهولة.',
    ),
    Pages(
      image: Images.onBoarding2,
      title: 'خيارات تناسب احتياجاتك',
      subTitle:
      'استخدم الفلاتر للبحث حسب السعر، الموقع، والمواصفات التي تناسبك.',
    ),
    Pages(
      image: Images.onBoarding3,
      title: 'تواصل واحجز فورًا',
      subTitle: 'تواصل مباشرة مع المالك أو الوسيط واحجز شقتك بكل سرعة وأمان.',
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

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.horizontal,
        controller: _controller,
        itemCount: pagesList.length,
        onPageChanged: (value) {
          setState(() {
            index = value;
          });
        },
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
                  height: MediaQuery.of(context).size.height * 0.55,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.07,
                      vertical: MediaQuery.of(context).size.height * 0.08,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          pagesList[index].title,
                          style: theme.titleSmall?.copyWith(
                            fontSize: MediaQuery.of(context).size.width * 0.06,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          pagesList[index].subTitle,
                          maxLines: 2,
                          style: theme.bodySmall?.copyWith(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                          ),
                          textAlign: TextAlign.center,
                          softWrap: true,
                        ),
                        const SizedBox(height: 28),
                        CustomSmoothPageIndicator(
                          controller: _controller,
                          pagesList: pagesList,
                        ),
                        const SizedBox(height: 32),

                        /// **هنا التعديل:** إذا كانت الصفحة الأخيرة، يظهر زر واحد فقط (ابدأ)
                        if (index == pagesList.length - 1)
                          CustomButton(
                            textColor: Colors.white,
                            text: 'ابدأ',
                            backgroundColor: AppColors.primaryColor,
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                PageRouteName.beginning,
                                    (route) => false,
                              );
                            },
                          )
                        else ...[
                          CustomButton(
                            textColor: Colors.white,
                            text: 'التالي',
                            backgroundColor: AppColors.primaryColor,
                            onPressed: () {
                              _controller.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          CustomButton(
                            textColor: AppColors.primaryColor,
                            text: 'تخطي',
                            backgroundColor: Colors.white,
                            decoration: TextDecoration.underline,
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                PageRouteName.beginning,
                                    (route) => false,
                              );
                            },
                          ),
                        ],
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
