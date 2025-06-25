import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/images.dart';
import 'package:peron_project/core/widgets/custom_arrow_back.dart';
import 'package:peron_project/features/advertisements/presentation/widgets/property_form.dart';
import 'package:peron_project/core/helper/fonts.dart';

class AddPropertyScreen extends StatelessWidget {
  const AddPropertyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const CustomArrowBack(),
          centerTitle: true,
          title: Text(
            "اضافة عقار",
            style: TextStyle(
              fontFamily: Fonts.primaryFontFamily,
              fontWeight: FontWeight.w700,
              fontSize: screenWidth * 0.05,
              height: 15.27 / 20,
              letterSpacing: 0,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: screenHeight * 0.02,
          ),
          child: Column(
            children: [
              Container(
                height: 1,
                width: double.infinity,
                color: const Color(0xFFE1E1E1),
              ),
              SizedBox(height: screenHeight * 0.03),
              Center(
                child: SvgPicture.asset(
                  Images.addPropertyTitle,
                  width: screenWidth * 0.4,
                  height: screenHeight * 0.05,
                ),
              ),

              SizedBox(height: screenHeight * 0.02),

              const PropertyForm(),
            ],
          ),
        ),
      ),
    );
  }
}
