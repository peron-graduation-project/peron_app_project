import 'package:flutter/material.dart';
import 'package:peron_project/features/main/presentation/view/widgets/recommend_property_card.dart';

class RecommendedPropertyWidget extends StatefulWidget {
  const RecommendedPropertyWidget({super.key});

  @override
  State<RecommendedPropertyWidget> createState() => _RecommendedPropertyWidgetState();
}

class _RecommendedPropertyWidgetState extends State<RecommendedPropertyWidget> {
  final List<Map<String, dynamic>> properties = [
    {
      "price": "500",
      "image": "assets/images/appartment4.jpg",
      "title": "شقه سكنية",
      "location": "توريل",
    },
    {
      "price": "500",
      "image": "assets/images/appartment4.jpg",
      "title": "شقه سكنية",
      "location": "توريل",
    },
    {
      "price": "500",
      "image": "assets/images/appartment4.jpg",
      "title": "شقه سكنية",
      "location": "توريل",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final itemWidth = screenWidth > 600 ? screenWidth * 0.3 : screenWidth * 0.5;
        final itemHeight = itemWidth * 1.26;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SizedBox(
            height: itemHeight,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: properties.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: itemWidth,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: RecommendedPropertyCard(property: properties[index]),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
