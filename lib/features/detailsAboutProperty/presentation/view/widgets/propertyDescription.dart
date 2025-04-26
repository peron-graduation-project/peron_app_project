import 'package:flutter/material.dart';

class PropertyDescription extends StatelessWidget {
  final double standardPadding;
  final double smallPadding;
  final double regularFontSize;
  final double smallFontSize;
  final Function toggleExtendedDetails;
  final bool showExtendedDetails;

  const PropertyDescription({
    Key? key,
    required this.standardPadding,
    required this.smallPadding,
    required this.regularFontSize,
    required this.smallFontSize,
    required this.toggleExtendedDetails,
    required this.showExtendedDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            standardPadding,
            standardPadding,
            standardPadding,
            smallPadding,
          ),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              'وصف الشقة',
              style: TextStyle(
                fontSize: regularFontSize * 1.2,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: standardPadding),
          child: Text(
            'النوع: شقة مميزة في موقع هادي وسكني راقي، تطل على شارع واسع. تتكون من 3 غرف نوم رئيسية، غرفتين حمام، مطبخ، ومغلقة كلياً في الدور الثالث في عمارة حديثة مزودة بأساسنسير. العمارة نظيفة وآمنة.\n\nالمساحة: مساحة واسعة تبلغ 150 م\n\nالتشطيب: سوبر لوكس',
            style: TextStyle(
              color: Colors.grey[700],
              height: 1.5,
              fontSize: regularFontSize,
            ),
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
          ),
        ),
        if (!showExtendedDetails)
          Padding(
            padding: EdgeInsets.fromLTRB(
              standardPadding,
              smallPadding,
              standardPadding,
              standardPadding,
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => toggleExtendedDetails(),
                child: Text(
                  'اقرأ المزيد...',
                  style: TextStyle(
                    color: const Color(0xff0F7757),
                    fontWeight: FontWeight.bold,
                    fontSize: smallFontSize,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
