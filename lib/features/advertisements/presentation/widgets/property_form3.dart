import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/fonts.dart';
import 'package:peron_project/core/helper/images.dart';
import 'package:peron_project/core/widgets/custom_button.dart';
import 'package:peron_project/features/advertisements/data/api_service.dart' ;
import 'package:peron_project/features/advertisements/data/property_model.dart';
import 'package:peron_project/features/advertisements/presentation/widgets/custom_alert_dialog.dart';
import 'package:peron_project/features/payment/presentation/view/views/paymentMethods.dart';

class PropertyForm3 extends StatefulWidget {
  final PropertyFormData formData;
  const PropertyForm3({Key? key, required this.formData}) : super(key: key);

  @override
  State<PropertyForm3> createState() => _PropertyForm3State();
}

class _PropertyForm3State extends State<PropertyForm3> {
  List<File> images = [];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => images.add(File(image.path)));
    }
  }

  void _showPaymentAlert(BuildContext context) {
    if (images.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('❌ يرجى إضافة صورة واحدة على الأقل')),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (context) => CustomAlertDialog(
        iconPath: 'assets/images/alert.svg',
        title: 'لنشر الإعلان يجب الدفع',
        description: 'قم بالدفع لنشر اعلانك',
        confirmText: 'دفع',
        cancelText: 'إلغاء',
       onConfirm: () {
  Navigator.pop(context);
  widget.formData.images = images;
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PaymentMethodScreen(
        formData: widget.formData,
      ),
    ),
  );
},

        onCancel: () => Navigator.pop(context),
      ),
    );
  }

  Future<void> _submitProperty() async {
    widget.formData.images = images;
    try {
      final api = await ApiService.create();
      await api.createProperty(widget.formData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ تم نشر العقار بنجاح')),
      );
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ فشل في النشر: $e')),
      );
    }
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
        textAlign: TextAlign.right,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                width: screenWidth * 0.88,
                height: screenHeight * 0.28,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: images.isEmpty
                    ? _buildEmptyUploadBox(screenWidth, screenHeight)
                    : _buildImageGrid(screenWidth),
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
                  onPressed: () => _showPaymentAlert(context),
                ),
              ),
              SizedBox(width: screenWidth * 0.04),
              Expanded(
                child: CustomButton(
                  text: 'السابق',
                  backgroundColor: Colors.white,
                  textColor: AppColors.primaryColor,
                  borderColor: AppColors.primaryColor,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyUploadBox(double screenWidth, double screenHeight) {
    final iconSize = screenWidth * 0.064;
    final textFontSize = screenWidth * 0.032;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
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
            Text('قم بسحب الصوره هنا', style: _textStyle(textFontSize)),
            Text('او', style: _textStyle(textFontSize)),
            Text('باختيار ملف', style: _textStyle(textFontSize)),
            SizedBox(height: screenHeight * 0.015),
            SizedBox(
              width: screenWidth * 0.314,
              height: screenHeight * 0.06,
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(screenWidth * 0.025),
                  side: BorderSide(color: AppColors.primaryColor),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: _pickImage,
                child: Text('تصفح', style: TextStyle(
                  fontFamily: Fonts.primaryFontFamily,
                  fontSize: screenWidth * 0.037,
                  color: AppColors.primaryColor,
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageGrid(double screenWidth) {
    final iconSize = screenWidth * 0.064;
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: images.length + 1,
      itemBuilder: (_, i) {
        if (i == images.length) {
          return GestureDetector(
            onTap: _pickImage,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.add, size: iconSize, color: AppColors.primaryColor),
            ),
          );
        }
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(images[i], fit: BoxFit.cover),
        );
      },
    );
  }

  TextStyle _textStyle(double size) {
    return TextStyle(
      fontFamily: Fonts.primaryFontFamily,
      fontWeight: FontWeight.w500,
      fontSize: size,
      color: Colors.grey.shade600,
    );
  }
}
