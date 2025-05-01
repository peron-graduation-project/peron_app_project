import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/fonts.dart';
import 'package:peron_project/core/widgets/custom_button.dart';
import 'package:peron_project/features/advertisements/presentation/views/add_property_screen2.dart';
import 'package:peron_project/features/advertisements/presentation/widgets/custom_dropdown.dart';
import 'package:peron_project/features/advertisements/presentation/widgets/custom_text_field2.dart';

class PropertyForm extends StatefulWidget {
  const PropertyForm({super.key});

  @override
  _PropertyFormState createState() => _PropertyFormState();
}

class _PropertyFormState extends State<PropertyForm> {
  String? selectedPlace;
  bool isWhatsapp = false;
  bool isEmailChecked = false;

  final List<String> mansouraPlaces = [
    'حي الجامعة',
    'توريل',
    'عبدالسلام عارف',
    'قناة السويس',
    'المشاية',
    'الجلاء',
    'الترعة',
    'الصنيه',
    'الاتوبيس'
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
          buildLabel('نوع العقار', screenWidth),
          const SizedBox(height: 8),
          const CustomTextField(hintText: 'اكتب نوع العقار'),

          buildLabel('المكان', screenWidth),
          const SizedBox(height: 8),
          CustomDropdown(
            label: 'اختر المكان',
            value: selectedPlace,
            items: mansouraPlaces,
            onChanged: (value) {
              setState(() {
                selectedPlace = value;
              });
            },
          ),

          buildLabel('تفاصيل الاعلان/مميزات الاعلان', screenWidth),
          const SizedBox(height: 8),
          const CustomTextField(hintText: '', maxLines: 4),

          buildLabel('رابط الفيديو يوتيوب', screenWidth),
          const SizedBox(height: 8),
          const CustomTextField(hintText: ''),

          const SizedBox(height: 12),
          Padding(
            padding: EdgeInsets.only(top: screenWidth * 0.015),
            child: RichText(
              text: TextSpan(
                text: 'اذا اردت تفعيل رقم الهاتف لزوار الاعلان اذهب الى ',
                style: TextStyle(
                  fontFamily: Fonts.primaryFontFamily,
                  fontSize: screenWidth * 0.031,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: 'الملف الشخصى',
                    style: TextStyle(
                      fontFamily: Fonts.primaryFontFamily,
                      fontSize: screenWidth * 0.031,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFDADADA), width: 1),
              ),
              child: IntlPhoneField(
                decoration: InputDecoration(
                  hintText: '',
                  hintStyle: TextStyle(
                    fontFamily: Fonts.primaryFontFamily,
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF818181),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.03,
                    vertical: screenHeight * 0.015,
                  ),
                ),
                initialCountryCode: 'EG',
                dropdownIconPosition: IconPosition.leading,
                textAlign: TextAlign.right,
                onChanged: (phone) {
                  print(phone.completeNumber);
                },
              ),
            ),
          ),

          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'الرقم يحتوي علي واتس اب',
                  style: TextStyle(
                    fontFamily: Fonts.primaryFontFamily,
                    fontSize: screenWidth * 0.035,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              Switch(
                value: isWhatsapp,
                activeColor: AppColors.primaryColor,
                onChanged: (value) {
                  setState(() {
                    isWhatsapp = value;
                  });
                },
              ),
            ],
          ),

          const SizedBox(height: 4),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Checkbox(
                value: isEmailChecked,
                activeColor: AppColors.primaryColor,
                onChanged: (value) {
                  setState(() {
                    isEmailChecked = value!;
                  });
                },
              ),
              Expanded(
                child: Text(
                  'تواصل معي عن طريق البريد الالكتروني',
                  style: TextStyle(
                    fontFamily: Fonts.primaryFontFamily,
                    fontSize: screenWidth * 0.035,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),


          SizedBox(height: screenHeight * 0.04),
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              text: 'متابعه',
              textColor: AppColors.labelMediumColor,
              backgroundColor: AppColors.primaryColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddPropertyScreen2(),
                  ),
                );
              },
            ),
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
          height: 1,
          color: AppColors.titleSmallColor,
        ),
      ),
    );
  }
}