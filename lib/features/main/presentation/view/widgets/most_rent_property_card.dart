import 'package:flutter/material.dart';
import 'package:peron_project/features/main/presentation/view/widgets/most_rent_property_details.dart';
import 'package:peron_project/features/main/presentation/view/widgets/property_border.dart';


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
        debugPrint("Item Width: $itemWidth");
        double iconSize = itemWidth * 0.1;
        double textSize = itemWidth * 0.08;
        double paddingSize = itemWidth * 0.05;
        return PropertyBorder(
          paddingSize: paddingSize,
          child: MostRentPropertyDetails(property: property,iconSize:iconSize,textSize:textSize,paddingSize:paddingSize,itemWidth:itemWidth),
        );
      },
    );
  }

}
