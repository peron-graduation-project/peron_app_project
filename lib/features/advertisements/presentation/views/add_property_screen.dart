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
    var theme = Theme.of(context).textTheme;


    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackgroundColor,
        appBar: AppBar(
        title: Text(
        'أضف عقار',
        style: theme.headlineMedium!.copyWith(fontSize: 20),
    )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.025,
                ),
                child: Container(
                  height: 1,
                  width: double.infinity,
                  color: const Color(0xFFE1E1E1),
                ),
              ),


              SizedBox(height: screenHeight * 0.03),


              Center(
                child: SvgPicture.asset(
                  Images.addPropertyTitle,
                  width: screenWidth * 0.4,
                  height: screenHeight * 0.05,
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.02,
                ),
                child: const PropertyForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
