import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/fonts.dart';

class PropertyDescription extends StatelessWidget {
  final double standardPadding;
  final double smallPadding;
  final double regularFontSize;
  final double smallFontSize;
  final Function toggleExtendedDetails;
  final bool showExtendedDetails;
  final String description;

  const PropertyDescription({
    super.key,
    required this.description,
    required this.standardPadding,
    required this.smallPadding,
    required this.regularFontSize,
    required this.smallFontSize,
    required this.toggleExtendedDetails,
    required this.showExtendedDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 10
            
          ),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              'وصف الشقة',
              style: TextStyle(
                fontSize: regularFontSize * 1.2,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontFamily: Fonts.primaryFontFamily,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
          description,
            style: TextStyle(
              color: const Color.fromARGB(255, 143, 143, 143),
              height: 1.5,
              fontWeight: FontWeight.normal,
              fontSize: 17,
              fontFamily: Fonts.primaryFontFamily,
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
            child: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => toggleExtendedDetails(),
                  child: Text(
                    'اقرأ المزيد...',
                    style: TextStyle(
                      color: Color(0xff0F7757),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      fontFamily: Fonts.primaryFontFamily,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
