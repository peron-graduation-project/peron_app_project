import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/fonts.dart';
import 'package:peron_project/core/utils/property_model.dart';

class PropertyInformation extends StatelessWidget {
  final double screenWidth;
  final double padding;
  final double fontSize;
  final Property property;

  const PropertyInformation({
    super.key,
    required this.property,
    required this.screenWidth,
    required this.padding,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 0),
          Text(
            property.description??"",
            style: TextStyle(
              color: const Color.fromARGB(255, 143, 143, 143),
              // height: 1.5,
              fontWeight: FontWeight.normal,
              fontSize: 17,
              fontFamily: Fonts.primaryFontFamily,
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(height: 5),
          Text(
            property.description??"",
            style: TextStyle(
              color: const Color.fromARGB(255, 143, 143, 143),
              height: 1.5,
              fontWeight: FontWeight.normal,
              fontSize: 17,
              fontFamily: Fonts.primaryFontFamily,
            ),
            textAlign: TextAlign.right,
          ),
            SizedBox(height: 5),
          Text(
            'المساحه: ${property.area}   ',
            style: TextStyle(
              color: const Color.fromARGB(255, 143, 143, 143),
              height: 1.5,
              fontWeight: FontWeight.normal,
              fontSize: 17,
              fontFamily: Fonts.primaryFontFamily,
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(height: 5),
        
          Text(
            'الطابق: ${property.floor}   ',
            style: TextStyle(
              color: const Color.fromARGB(255, 143, 143, 143),
              height: 1.5,
              fontWeight: FontWeight.normal,
              fontSize: 17,
              fontFamily: Fonts.primaryFontFamily,
            ),
            textAlign: TextAlign.right,
          ),
            Text(
            'الموقع: ${property.location}   ',
            style: TextStyle(
              color: const Color.fromARGB(255, 143, 143, 143),
              height: 1.5,
              fontWeight: FontWeight.normal,
              fontSize: 17,
              fontFamily: Fonts.primaryFontFamily,
            ),
            textAlign: TextAlign.right,
          ),
            
          
        ],
      ),
    );
  }
}
