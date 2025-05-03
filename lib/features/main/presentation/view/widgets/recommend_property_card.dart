import 'package:flutter/material.dart';
import 'package:peron_project/core/utils/property_model.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/views/property_details.dart';
import 'package:peron_project/features/main/data/models/recommended_property.dart';
import 'package:peron_project/features/main/presentation/view/widgets/custom_favourite_icon.dart';
import 'package:peron_project/features/main/presentation/view/widgets/property_border.dart';
import 'package:peron_project/features/main/presentation/view/widgets/recommended_property_details.dart';

class RecommendedPropertyCard extends StatefulWidget {
  final RecommendedProperty property;
  const RecommendedPropertyCard({super.key, required this.property});

  @override
  _RecommendedPropertyCardState createState() =>
      _RecommendedPropertyCardState();
}

class _RecommendedPropertyCardState extends State<RecommendedPropertyCard> {
  @override
  Widget build(BuildContext context) {
    final property = widget.property;
    var screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PropertyDetailScreen(propertyId: property.propertyId,)),
        );
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          double itemWidth =
              constraints.maxWidth > 0
                  ? constraints.maxWidth
                  : screenWidth * 0.45;
          print(
            "RecommendedPropertyCard - constraints.maxWidth: ${constraints.maxWidth}, itemWidth: $itemWidth",
          );
          double iconSize = itemWidth * 0.1;
          double textSize = itemWidth * 0.08;
          double paddingSize = itemWidth * 0.05;
          return PropertyBorder(
            paddingSize: paddingSize,
            child: Stack(
              children: [
                RecommendedPropertyDetails(
                  property: property,
                  iconSize: iconSize,
                  textSize: textSize,
                  paddingSize: paddingSize,
                  itemWidth: itemWidth,
                ),
                CustomFavouriteIcon(
                  property: property,
                  category: 'recommendation',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
