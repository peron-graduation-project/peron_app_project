import 'package:flutter/material.dart';
import 'package:peron_project/features/main/presentation/view/widgets/property_image.dart';
import 'package:peron_project/features/main/presentation/view/widgets/property_location.dart';
import 'package:peron_project/features/main/presentation/view/widgets/property_rating.dart';
import 'package:peron_project/features/main/presentation/view/widgets/property_status.dart';
import 'package:peron_project/features/main/presentation/view/widgets/property_title.dart';

import 'custom_favourite_icon.dart';
import 'custom_price_widget.dart';

class MostRentPropertyDetails extends StatelessWidget {
  final Map<String, dynamic> property;
 final double iconSize;
 final double textSize;
 final double paddingSize;
 final double itemWidth;
  const MostRentPropertyDetails({super.key, required this.property, required this.iconSize, required this.textSize, required this.paddingSize, required this.itemWidth});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            PropertyImage(image: property['image'], itemWidth: itemWidth)   ,
            CustomFavouriteIcon(iconSize: iconSize,),
            CustomPriceWidget(propertyPrice: property['price'],),
          ],
        ),
        SizedBox(height: paddingSize),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              PropertyTitle(title: property['title'],),
              SizedBox(height: paddingSize * 0.5),
              PropertyRating(rating: property['rating'],iconSize: iconSize,),
              SizedBox(height: paddingSize * 0.5),
              PropertyLocation(location: property['location'], iconSize: iconSize),
              const Divider(),
              PropertyStats(property: property,iconSize: iconSize,textSize: textSize,),
            ],
          ),
        ),
      ],
    );
  }
}
