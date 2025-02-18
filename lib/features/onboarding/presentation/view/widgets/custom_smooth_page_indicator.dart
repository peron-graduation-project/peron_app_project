import 'package:flutter/material.dart';
import 'package:peron_project/features/onboarding/data/page_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../core/helper/colors.dart';

class CustomSmoothPageIndicator extends StatelessWidget {
  const CustomSmoothPageIndicator({
    super.key,
    required PageController controller,
    required this.pagesList,
  }) : _controller = controller;

  final PageController _controller;
  final List<Pages> pagesList;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: _controller,
      count: pagesList.length,
      effect:  ExpandingDotsEffect(
        activeDotColor: AppColors.primaryColor,
        dotColor: AppColors.inActiveColor,
        dotHeight: 8,
        dotWidth: 8,
        expansionFactor: 3,
      ),
    );
  }
}
