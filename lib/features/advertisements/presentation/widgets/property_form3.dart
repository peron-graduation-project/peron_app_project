import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/fonts.dart';
import 'package:peron_project/core/helper/images.dart';
import 'package:peron_project/core/widgets/custom_button.dart';
import 'package:peron_project/features/advertisements/presentation/widgets/custom_alert_dialog.dart';
import 'package:peron_project/features/advertisements/presentation/widgets/custom_dropdown.dart';
import 'package:peron_project/features/advertisements/presentation/widgets/custom_multi_select_dropdown.dart';
import 'package:peron_project/features/advertisements/presentation/widgets/custom_text_field2.dart';
import 'package:peron_project/features/payment/presentation/view/views/paymentMethods.dart';

class PropertyForm3 extends StatefulWidget {
  const PropertyForm3({super.key});

  @override
  State<PropertyForm3> createState() => _PropertyForm3State();
}

class _PropertyForm3State extends State<PropertyForm3> {
  File? _selectedImage;

  final List<String> statusOptions = ['مجهزه', 'مجهزه جزئيا', 'غير مجهزه'];
  final List<String> featuresOptions = [
    'مصعد',
    'برج',
    'بلكونه',
    'واي فاي',
    'تدفئه مركزيه',
    'حراسه/امان',
  ];

  String? selectedStatus;
  List<String> selectedFeatures = [];

  final TextEditingController addressController = TextEditingController();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  void _showPaymentAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.4),
      builder:
          (context) => CustomAlertDialog(
            iconPath: 'assets/images/alert.svg',
            title: 'لنشر الإعلان يجب الدفع',
            description: 'قم بالدفع لنشر اعلانك',
            confirmText: 'دفع',
            cancelText: 'إلغاء',
            onConfirm: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PaymentMethodScreen()),
              );
            },
            onCancel: () {
              Navigator.pop(context);
            },
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
          letterSpacing: 0,
          color: AppColors.titleSmallColor,
        ),
        textAlign: TextAlign.right,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final double boxWidth = screenWidth * 0.88;
    final double boxHeight = screenHeight * 0.28;
    final double iconSize = screenWidth * 0.064;
    final double textFontSize = screenWidth * 0.032;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildLabel('الحاله', screenWidth),
          const SizedBox(height: 8),
          CustomDropdown(
            label: 'اختر',
            value: selectedStatus,
            items: statusOptions,
            onChanged: (value) {
              setState(() {
                selectedStatus = value;
              });
            },
          ),

          buildLabel('عنوان العقار', screenWidth),
          const SizedBox(height: 8),
        //  CustomTextField(controller: addressController),

          buildLabel('مواصفات أخرى', screenWidth),
          const SizedBox(height: 8),
          CustomMultiSelectDropdown(
            label: 'اختر',
            items: featuresOptions,
            selectedValues: selectedFeatures,
            onChanged: (newSelected) {
              setState(() {
                selectedFeatures = newSelected;
              });
            },
          ),

          buildLabel('أضف صور العقار', screenWidth),
          SizedBox(height: screenHeight * 0.02),

          Center(
            child: DottedBorder(
              color: const Color(0xFFDADADA),
              strokeWidth: 1,
              dashPattern: const [6, 4],
              borderType: BorderType.RRect,
              radius: const Radius.circular(8),
              child: Container(
                width: boxWidth,
                height: boxHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child:
                    _selectedImage == null
                        ? Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  Images.uploadIcon,
                                  width: iconSize,
                                  height: iconSize,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: screenHeight * 0.015),
                                Text(
                                  'قم بسحب الصوره هنا',
                                  style: TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontWeight: FontWeight.w500,
                                    fontSize: textFontSize,
                                    height: 1.0,
                                    color: Colors.grey.shade600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  'او',
                                  style: TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontWeight: FontWeight.w500,
                                    fontSize: textFontSize,
                                    height: 1.0,
                                    color: Colors.grey.shade600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  'باختيار ملف',
                                  style: TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontWeight: FontWeight.w500,
                                    fontSize: textFontSize,
                                    height: 1.0,
                                    color: Colors.grey.shade600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: screenHeight * 0.015),
                                SizedBox(
                                  width: screenWidth * 0.314,
                                  height: screenHeight * 0.06,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.all(
                                        screenWidth * 0.025,
                                      ),
                                      side: BorderSide(
                                        color: AppColors.primaryColor,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    onPressed: _pickImage,
                                    child: Text(
                                      'تصفح',
                                      style: TextStyle(
                                        fontFamily: Fonts.primaryFontFamily,
                                        fontSize: screenWidth * 0.037,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        : ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            _selectedImage!,
                            width: boxWidth,
                            height: boxHeight,
                            fit: BoxFit.cover,
                          ),
                        ),
              ),
            ),
          ),

          SizedBox(height: screenHeight * 0.04),

          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'نشر',
                  backgroundColor: AppColors.primaryColor,
                  textColor: Colors.white,
                  onPressed: () {
                    _showPaymentAlert(context);
                  },
                ),
              ),
              SizedBox(width: screenWidth * 0.04),
              Expanded(
                child: CustomButton(
                  text: 'السابق',
                  backgroundColor: Colors.white,
                  textColor: AppColors.primaryColor,
                  borderColor: AppColors.primaryColor,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
