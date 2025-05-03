import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/fonts.dart';
import 'package:peron_project/core/widgets/custom_button.dart';
import 'package:peron_project/features/advertisements/data/property_model.dart';
import 'package:peron_project/features/advertisements/presentation/views/add_property_screen3.dart';
import 'package:peron_project/features/advertisements/presentation/widgets/custom_multi_select_dropdown.dart';
import 'package:peron_project/features/advertisements/presentation/widgets/custom_text_field2.dart';

class PropertyForm2 extends StatefulWidget {
  final PropertyFormData formData;
  const PropertyForm2({Key? key, required this.formData}) : super(key: key);

  @override
  _PropertyForm2State createState() => _PropertyForm2State();
}

class _PropertyForm2State extends State<PropertyForm2> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController bedroomsController = TextEditingController();
  final TextEditingController bathsController    = TextEditingController();
  final TextEditingController addressController  = TextEditingController();

  final List<String> featuresOptions = [
    'مصعد',
    'برج',
    'بلكونه',
    'واي فاي',
    'تدفئه مركزيه',
    'حراسه/امان',
  ];
  List<String> selectedFeatures = [];

  @override
  void dispose() {
    bedroomsController.dispose();
    bathsController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth  = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildLabel('الغرف', screenWidth),
            const SizedBox(height: 8),
            CustomTextField(
              controller: bedroomsController,
              hintText: 'أدخل عدد الغرف',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'يرجى إدخال عدد الغرف';
                }
                if (int.tryParse(value) == null) {
                  return 'يرجى إدخال رقم صحيح';
                }
                return null;
              },
            ),

            buildLabel('الحمامات', screenWidth),
            const SizedBox(height: 8),
            CustomTextField(
              controller: bathsController,
              hintText: 'أدخل عدد الحمامات',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'يرجى إدخال عدد الحمامات';
                }
                if (int.tryParse(value) == null) {
                  return 'يرجى إدخال رقم صحيح';
                }
                return null;
              },
            ),

            buildLabel('عنوان العقار', screenWidth),
            const SizedBox(height: 8),
            CustomTextField(
              controller: addressController,
              hintText: 'أدخل العنوان الكامل',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'يرجى إدخال العنوان';
                }
                return null;
              },
            ),

            buildLabel('مواصفات أخرى', screenWidth),
            const SizedBox(height: 8),
            CustomMultiSelectDropdown(
              label: 'اختر',
              items: featuresOptions,
              selectedValues: selectedFeatures,
              onChanged: (newSelected) {
                setState(() => selectedFeatures = newSelected);
              },
            ),

            SizedBox(height: screenHeight * 0.04),

            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'متابعة',
                    textColor: AppColors.labelMediumColor,
                    backgroundColor: AppColors.primaryColor,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.formData
                          ..bedrooms        = int.tryParse(bedroomsController.text) ?? 0
                          ..bathrooms       = int.tryParse(bathsController.text) ?? 0
                          ..location        = addressController.text
                          ..selectedFeatures = selectedFeatures;

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddPropertyScreen3(
                              data: widget.formData,
                            ),
                          ),
                        );
                      }
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
