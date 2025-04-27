import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peron_project/core/helper/colors.dart';

class DottedBorderBox extends StatelessWidget {
  final double screenHeight;

  const DottedBorderBox({super.key, required this.screenHeight});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: Colors.grey,
      strokeWidth: 1,
      borderType: BorderType.RRect,
      radius: const Radius.circular(8),
      dashPattern: [6, 3],
      child: Container(
        width: double.infinity,
        height: screenHeight * 0.25,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.file_upload_outlined, color: Colors.black54),
              const SizedBox(height: 8),
              const Text('قم بسحب الصور هنا',
                  style: TextStyle(color: Colors.black54)),
              const Text('أو', style: TextStyle(color: Colors.black54)),
              const Text('باختيار ملف', style: TextStyle(color: Colors.black54)),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () {
                  ImagePicker().pickImage(source: ImageSource.gallery).then((image) {
                    if (image != null) {
                      print("تم اختيار الصورة: ${image.path}");
                      // ممكن تبعتيها لـ Bloc أو تخزنيها حسب المطلوب
                    }
                  });
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.primaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                ),
                child: Text(
                  'تصفح',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
