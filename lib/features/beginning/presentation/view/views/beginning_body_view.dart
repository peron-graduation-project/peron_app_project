import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/fonts.dart';
import 'package:peron_project/core/helper/images.dart';
import 'package:peron_project/core/widgets/custom_button.dart';

class BeginningBodyView extends StatelessWidget {
  const BeginningBodyView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(flex: 1),
          Center(
            child: Text(
              'اهلاً بك',
              style: theme.titleLarge?.copyWith(
                fontFamily: Fonts.kpoppins,
                fontSize: 34,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
          Image.asset(
            Images.beginning,
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              'هل أنت مؤجر أم مستثمر؟',
              style: theme.titleLarge?.copyWith(
                fontSize: 22, // حجم ثابت
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 31),
          CustomButton(
            textColor: Colors.white,
            text: 'مستثمر',
            backgroundColor: AppColors.primaryColor,
          ),
          const SizedBox(height: 16),
          CustomButton(
            textColor: Colors.black,
            text: 'مؤجر',
            backgroundColor: Colors.white,
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
