import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peron_project/core/utils/property_model.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/widgets/circleFeature.dart';
import 'package:peron_project/core/helper/fonts.dart';

class AdditionalFeatures extends StatelessWidget {
  final double screenWidth;
  final double padding;
  final double fontSize;
  final Property property;

  AdditionalFeatures({
    Key? key,
    required this.property,
    required this.screenWidth,
    required this.padding,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ميزات اضافية',
            style: TextStyle(
              color: Colors.black,
              fontSize: fontSize * 1.2,
              fontWeight: FontWeight.w500,
              fontFamily: Fonts.primaryFontFamily,
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(height: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (property.hasInternet!=null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.wifi, size: 22),
                    const SizedBox(width: 8),
                    Text(
                      "يوجد إنترنت",
                      style: TextStyle(
                        color: Colors.grey[700],
                        height: 1.5,
                        fontWeight: FontWeight.normal,
                        fontSize: 17,
                        fontFamily: Fonts.primaryFontFamily,
                      ),
                    ),
                  ],
                ),

              SizedBox(height: 5),
            if(property.allowsPets!=null)
             Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    "assets/icons/pet.svg",
                    width: 20,
                    height: 20,
                  ),
                  SizedBox(width: 8),

                  Text(
                    "مسموح بالحيوانات الاليفة",
                    style: TextStyle(
                      color: Colors.grey[700],
                      height: 1.5,
                      fontWeight: FontWeight.normal,
                      fontSize: 17,
                      fontFamily: Fonts.primaryFontFamily,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
