import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/fonts.dart';
import 'package:peron_project/core/widgets/custom_button.dart';
import 'package:peron_project/features/advertisements/data/property_model.dart';
import 'package:peron_project/features/advertisements/presentation/views/add_property_screen2.dart';
import 'package:peron_project/features/advertisements/presentation/widgets/custom_dropdown.dart';
import 'package:peron_project/features/advertisements/presentation/widgets/custom_text_field2.dart';

class PropertyForm extends StatefulWidget {
  const PropertyForm({super.key});

  @override
  _PropertyFormState createState() => _PropertyFormState();
}

class _PropertyFormState extends State<PropertyForm> {
  final _formKey = GlobalKey<FormState>();

  final titleController   = TextEditingController();
  final detailsController = TextEditingController();
  final areaController    = TextEditingController();
  final priceController   = TextEditingController();
  final phoneController   = TextEditingController();

  late FocusNode phoneFocusNode;

  String? selectedPlace;
  bool allowPets = false;

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
  void initState() {
    super.initState();
    phoneFocusNode = FocusNode();
  }

  @override
  void dispose() {
    titleController.dispose();
    detailsController.dispose();
    areaController.dispose();
    priceController.dispose();
    phoneController.dispose();
    phoneFocusNode.dispose();
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildLabel('نوع العقار', screenWidth),
            const SizedBox(height: 8),
            CustomTextField(
              controller: titleController,
              hintText: 'أدخل نوع العقار',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'هذا الحقل مطلوب';
                }
                return null;
              },
            ),

            buildLabel('المكان', screenWidth),
            const SizedBox(height: 8),
            CustomDropdown(
              label: 'اختر المكان',
              value: selectedPlace,
              items: mansouraPlaces,
              onChanged: (val) => setState(() => selectedPlace = val),
              validator: (val) => val == null ? 'يرجى اختيار المكان' : null,
            ),

            buildLabel('تفاصيل الإعلان/مميزات العقار', screenWidth),
            const SizedBox(height: 8),
            CustomTextField(
              controller: detailsController,
              hintText: 'أدخل تفاصيل ومميزات العقار',
              maxLines: 4,
              validator: (_) => null,
            ),

            buildLabel('الهاتف', screenWidth),
            const SizedBox(height: 8),
            Directionality(
              textDirection: TextDirection.ltr,
              child: IntlPhoneField(
                focusNode: phoneFocusNode,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: const Color(0xFFDADADA), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.03,
                    vertical: screenHeight * 0.015,
                  ),
                ),
                initialCountryCode: 'EG',
                keyboardType: TextInputType.phone,
                dropdownIconPosition: IconPosition.leading,
                textAlign: TextAlign.right,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (phone) {
                  if (phone == null || phone.number.isEmpty) {
                    return 'يرجى إدخال رقم الهاتف';
                  }
                  return null;
                },
                onSaved: (phone) {
                  phoneController.text = phone?.completeNumber ?? '';
                },
              ),
            ),

            buildLabel('المساحة (بالمتر)', screenWidth),
            const SizedBox(height: 8),
            CustomTextField(
              controller: areaController,
              hintText: 'أدخل المساحة',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'يرجى إدخال المساحة';
                }
                if (int.tryParse(value) == null) {
                  return 'يرجى إدخال رقم صحيح';
                }
                return null;
              },
            ),

            buildLabel('السعر - جنيه', screenWidth),
            const SizedBox(height: 8),
            CustomTextField(
              controller: priceController,
              hintText: 'أدخل السعر',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'يرجى إدخال السعر';
                }
                if (double.tryParse(value) == null) {
                  return 'يرجى إدخال الرقم';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'السماح بوجود حيوانات أليفة',
                    style: TextStyle(
                      fontFamily: Fonts.primaryFontFamily,
                      fontSize: screenWidth * 0.035,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                Switch(
                  value: allowPets,
                  activeColor: AppColors.primaryColor,
                  onChanged: (value) => setState(() => allowPets = value),
                ),
              ],
            ),

            SizedBox(height: screenHeight * 0.04),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: 'متابعة',
                textColor: AppColors.labelMediumColor,
                backgroundColor: AppColors.primaryColor,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    final data = PropertyFormData()..rentType= titleController.text
                      ..title       = titleController.text
                      ..description = detailsController.text
                      ..location    = selectedPlace ?? ''
                      ..area        = int.tryParse(areaController.text) ?? 0
                      ..price       = double.tryParse(priceController.text) ?? 0.0
                      ..phone       = phoneController.text
                      ..allowsPets  = allowPets;

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddPropertyScreen2(data: data),
                      ),
                    );
                  }
                },
              ),
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
          height: 1,
          color: AppColors.titleSmallColor,
        ),
        textAlign: TextAlign.right,
      ),
    );
  }
}
