import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/fonts.dart';
import 'package:peron_project/core/widgets/custom_button.dart';
import 'package:peron_project/features/advertisements/presentation/widgets/custom_dropdown.dart';
import 'package:peron_project/features/advertisements/presentation/widgets/custom_text_field.dart';

import '../views/add_property_screen3.dart';

class PropertyForm2 extends StatefulWidget {
  const PropertyForm2({super.key});

  @override
  _PropertyForm2State createState() => _PropertyForm2State();
}

class _PropertyForm2State extends State<PropertyForm2> {
  String? selectedView;

  final List<String> viewOptions = [
    'شارع رئيسي',
    'شارع فرعي',
    'ناصيه',
    'خلفي',
    'اخرى'
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildLabel('المساحه (بالمتر)', screenWidth),
          const SizedBox(height: 8),
         // const CustomTextField(),

          buildLabel('السعر - جنيه', screenWidth),
          const SizedBox(height: 8),
       //   const CustomTextField(),

          buildLabel('تطل على', screenWidth),
          const SizedBox(height: 8),
          CustomDropdown(
            label: 'اختر',
            value: selectedView,
            items: viewOptions,
            onChanged: (value) {
              setState(() {
                selectedView = value;
              });
            },
          ),

          buildLabel('الغرف', screenWidth),
          const SizedBox(height: 8),
       //   const CustomTextField(),

          buildLabel('الحمامات', screenWidth),
          const SizedBox(height: 8),
         // const CustomTextField(),

          buildLabel('الطابق', screenWidth),
          const SizedBox(height: 8),
          //const CustomTextField(),

          buildLabel('المطبخ', screenWidth),
          const SizedBox(height: 8),
          //const CustomTextField(),

          SizedBox(height: screenHeight * 0.04),

          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'متابعة',
                  textColor: AppColors.labelMediumColor,
                  backgroundColor: AppColors.primaryColor,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddPropertyScreen3(),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomButton(
                  text: 'السابق',
                  textColor: AppColors.primaryColor,
                  backgroundColor: Colors.white,
                  borderColor: AppColors.primaryColor,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),

          SizedBox(height: screenHeight * 0.04),
        ],
      ),
    );
  }

  Widget buildLabel(String text, double screenWidth) {
    return Padding(
      padding: EdgeInsets.only(top: screenWidth * 0.03),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: screenWidth * 0.04,
          fontFamily: Fonts.primaryFontFamily,
          color: AppColors.titleSmallColor,
        ),
      ),
    );
  }
}
