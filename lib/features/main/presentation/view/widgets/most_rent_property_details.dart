import 'package:flutter/material.dart';
import 'package:peron_project/features/main/data/models/recommended_property.dart';
import 'package:peron_project/features/main/presentation/view/widgets/property_image.dart';
import 'package:peron_project/features/main/presentation/view/widgets/property_location.dart';
import 'package:peron_project/features/main/presentation/view/widgets/property_rating.dart';
import 'package:peron_project/features/main/presentation/view/widgets/property_status.dart';
import 'package:peron_project/features/main/presentation/view/widgets/property_title.dart';
import 'custom_price_widget.dart';

class MostRentPropertyDetails extends StatelessWidget {
  final RecommendedProperty property;
  final double itemWidth;

  const MostRentPropertyDetails({
    super.key,
    required this.property,
    required this.itemWidth,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double paddingSize = screenWidth * 0.05;
        double iconSize = screenWidth > 400 ? 22.0 : 18.0;
        double textSize = screenWidth > 400 ? 16.0 : 14.0;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                PropertyImage(
                  imageUrl: property.images.isNotEmpty ? property.images[0] : null,
                  itemWidth: itemWidth,
                ),
                CustomPriceWidget(propertyPrice: property.price),
              ],
            ),
            SizedBox(height: paddingSize),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  PropertyTitle(title: 'شقة سكنية ${property.title}'),
                  SizedBox(height: paddingSize * 0.5),
                  PropertyRating(rating: property.averageRating??0.0, iconSize: iconSize),
                  SizedBox(height: paddingSize * 0.5),
                  PropertyLocation(location: property.title, iconSize: iconSize),
                  const Divider(),
                  PropertyStats(
                    property: property,
                    iconSize: iconSize,
                    textSize: textSize,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
