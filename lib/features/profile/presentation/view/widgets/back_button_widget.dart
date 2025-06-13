// lib/features/settings/presentation/views/widgets/back_button_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peron_project/core/helper/images.dart';
class BackButtonWidget extends StatelessWidget {
  final double screenWidth;

  const BackButtonWidget({super.key, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(
        Images.backIcon,
        width: screenWidth * 0.06,
        height: screenWidth * 0.06,
      ),
      onPressed: () => Navigator.pop(context),
    );
  }
}
