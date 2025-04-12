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
    double responsivePadding = itemWidth * 0.05;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            PropertyImage(image: property['image'], itemWidth: itemWidth),
            CustomFavouriteIcon(property: property, category: "recommended"),
          ],
        ),
        SizedBox(height: 5),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: responsivePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              RecommendedPropertyInfoDetails(
                icon: Symbols.home,
                iconColor: Color(0xff818181),
                title: 'النوع',
                label: property['title'],
              ),
              SizedBox(height: 5),
              RecommendedPropertyInfoDetails(
                icon: Icons.location_on,
                title: 'الموقع',
                label: property['location'],
              ),
              SizedBox(height:5),
              RecommendedPropertyInfoDetails(
                icon: Symbols.shoppingmode,
                title: 'السعر',
                iconColor: Color(0xff818181),
                label: property['price'],
              ),
            ],
          ),
        ),
      ],
    );
  }
}