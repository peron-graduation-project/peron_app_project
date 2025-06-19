import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peron_project/core/helper/fonts.dart';
import 'package:peron_project/core/utils/property_model.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/widgets/ratingDialog.dart';

class PropertyHeader extends StatelessWidget {
  final double standardPadding;
  final double titleFontSize;
  final double priceFontSize;
  final double smallPadding;
  final double regularFontSize;
  final double smallFontSize;
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
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0,right: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "شقة سكنية ${property.title ?? ""}",
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontFamily: Fonts.primaryFontFamily,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      SvgPicture.asset(
                          'assets/icons/heart.svg',
                          width: 30,
                          height: 30,
                        ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
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
                    children: [
                      InkWell(
                        onTap:
                            () => showDialog(
                          context: context,
                          builder: (context) => RatingDialog(),
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/star.svg',
                          width: 15,
                        ),
                      ),
                      SizedBox(width: 12,),
                      Text(
                        property.ratings ?? 'لا يوجد تقييم',
                        style: TextStyle(
                          fontSize: regularFontSize,
                          color: Colors.black87,
                          fontFamily: Fonts.primaryFontFamily,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
