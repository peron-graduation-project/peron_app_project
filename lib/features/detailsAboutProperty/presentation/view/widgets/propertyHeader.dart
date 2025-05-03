import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peron_project/core/helper/fonts.dart';
import 'package:peron_project/core/utils/property_model.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/widgets/ratingDialog.dart';

import '../views/review.dart';

class PropertyHeader extends StatelessWidget {
  final double standardPadding;
  final double titleFontSize;
  final double priceFontSize;
  final double smallPadding;
  final double regularFontSize;
  final double smallFontSize;
  final double smallIconSize;
  final double smallCircleSize;
  final Property property;

  const PropertyHeader({
    super.key,
    required this.property,
    required this.standardPadding,
    required this.titleFontSize,
    required this.priceFontSize,
    required this.smallPadding,
    required this.regularFontSize,
    required this.smallFontSize,
    required this.smallIconSize,
    required this.smallCircleSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: standardPadding),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.rtl,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.rtl,
                  children: [
                    Text(
                      "شقة سكنية  ${property.title??""}",
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontFamily: Fonts.primaryFontFamily,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      textDirection: TextDirection.rtl,
                      children: [
                        Text(
                          property.price.toString(),
                          style: TextStyle(
                            fontSize: priceFontSize,
                            color: Color(0xff0F7757),
                            fontWeight: FontWeight.w900,
                            fontFamily: Fonts.primaryFontFamily,
                          ),
                        ),
                        SizedBox(width: smallPadding * 0.2),
                        Text(
                          "ج.م",
                          style: TextStyle(
                            fontSize: priceFontSize,
                            color: Color(0xff0F7757),
                            fontWeight: FontWeight.w900,
                            fontFamily: Fonts.primaryFontFamily,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: smallPadding * 0.4),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      textDirection: TextDirection.rtl,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/star.svg',
                          width: 15,
                          height: 15,
                        ),

                        SizedBox(width: smallPadding * 0.8),
                        Text(
                          property.ratings??'No Rating',
                          style: TextStyle(
                            fontSize: regularFontSize,
                            // fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            fontFamily: Fonts.primaryFontFamily,
                          ),
                        ),

                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        width: smallCircleSize,
                        height: smallCircleSize,
                        decoration: BoxDecoration(
                          color: Color(0xff0F7757),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/heart.svg',
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              )])  );
  }
}
