import 'package:flutter/material.dart';
import 'package:peron_project/features/advertisements/presentation/views/add_property_screen.dart';

import '../../../../../core/helper/colors.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonSize = screenWidth * 0.15;

    return SizedBox(
      width: buttonSize.clamp(50, 90),
      height: buttonSize.clamp(50, 90),
      child: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        shape: const CircleBorder(),
        child: Icon(Icons.add, size: buttonSize * 0.5, color: Colors.white),
        onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const AddPropertyScreen()),
  );
},

      ),
    );
  }
}
