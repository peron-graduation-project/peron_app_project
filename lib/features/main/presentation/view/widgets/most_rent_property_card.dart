import 'package:flutter/material.dart';
import 'package:peron_project/features/main/presentation/view/widgets/most_rent_property_details.dart';
import 'package:peron_project/features/main/presentation/view/widgets/property_border.dart';
import 'package:peron_project/features/main/presentation/view/widgets/custom_favourite_icon.dart';

class MostRentPropertyCard extends StatefulWidget {
  final Map<String, dynamic> property;
  const MostRentPropertyCard({super.key, required this.property});

  @override
  _MostRentPropertyCardState createState() => _MostRentPropertyCardState();
}

class _MostRentPropertyCardState extends State<MostRentPropertyCard> {
  @override
  Widget build(BuildContext context) {
    final property = widget.property;
    var screenWidth = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        double itemWidth = constraints.maxWidth > 0 ? constraints.maxWidth : screenWidth * 0.45;
        double paddingSize = itemWidth * 0.05;

        return PropertyBorder(
          paddingSize: paddingSize,
          child: Stack(
            children: [
              MostRentPropertyDetails(
                property: property,
                itemWidth: itemWidth,
              ),
              Positioned(
                top: 8,
                left: 8,
                child: CustomFavouriteIcon(
                  property: property,
                  category: "most_rent",
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
