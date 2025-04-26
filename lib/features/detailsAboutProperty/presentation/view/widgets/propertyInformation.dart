import 'package:flutter/material.dart';

class PropertyInformation extends StatelessWidget {
  final double screenWidth;
  final double padding;
  final double fontSize;

  const PropertyInformation({
    Key? key,
    required this.screenWidth,
    required this.padding,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'الحالة: ممتازة',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: fontSize,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 10),
          Text(
            'الطابق: الثالث',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: fontSize,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 10),
          Text(
            'الموقع: على الطريق الدائري وبجوار المسجد الكبير',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: fontSize,
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}
