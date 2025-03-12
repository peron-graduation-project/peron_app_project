import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:peron_project/features/main/presentation/view/widgets/property_image.dart';
import 'package:peron_project/features/main/presentation/view/widgets/recommended_property_info_details.dart';
import 'custom_favourite_icon.dart';

class RecommendedPropertyDetails extends StatelessWidget {
  final Map<String, dynamic> property;
  final double iconSize;
  final double textSize;
  final double paddingSize;
  final double itemWidth;

  const RecommendedPropertyDetails({
    super.key,
    required this.property,
    required this.iconSize,
    required this.textSize,
    required this.paddingSize,
    required this.itemWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            PropertyImage(image: property['image'], itemWidth: itemWidth),
            Positioned(
              top: 8,
              left: 12,
              child: CustomFavouriteIcon(iconSize: iconSize),
            ),
          ],
        ),
        SizedBox(height: paddingSize),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              RecommendedPropertyInfoDetails(
                icon: Icons.home_filled,
                title: 'النوع',
                label: property['title'],
              ),
              SizedBox(height: paddingSize * 0.5),
              RecommendedPropertyInfoDetails(
                icon: Icons.location_on,
                title: 'الموقع',
                label: property['location'],
              ),
              SizedBox(height: paddingSize * 0.5),
              RecommendedPropertyInfoDetails(
                icon: Symbols.shoppingmode,
                title: 'السعر',
                label: property['price'],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

