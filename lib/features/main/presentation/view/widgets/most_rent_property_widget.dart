import 'package:flutter/material.dart';
import 'most_rent_property_card.dart';

class MostRentPropertyWidget extends StatefulWidget {
  const MostRentPropertyWidget({super.key});

  @override
  State<MostRentPropertyWidget> createState() => _MostRentPropertyWidgetState();
}

class _MostRentPropertyWidgetState extends State<MostRentPropertyWidget> {
  final List<Map<String, dynamic>> properties = [
    {"id": 1, "price": "200", "image": "assets/images/appartment4.jpg", "title": "شقه سكنيه شارع قناة السويس", "rating": 5, "location": "شارع قناه السويس بجانب مشاوي المحمدي.", "rooms": 3, "bathrooms": 3, "area": 130, "beds": 6},
    {"id": 2, "price": "150", "image": "assets/images/appartment5.jpg", "title": "شقه سكنيه بحي الجامعه - جيهان", "rating": 4, "location": "شارع قناه السويس بجانب مشاوي المحمدي.", "rooms": 2, "bathrooms": 2, "area": 150, "beds": 4},
    {"id": 3, "price": "180", "image": "assets/images/appartment6.jpg", "title": "شقه سكنيه بحي الجامعه - الجلاء", "rating": 4.5, "location": "شارع قناه السويس بجانب مشاوي المحمدي.", "rooms": 4, "bathrooms": 3, "area": 140, "beds": 8},
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;

        final itemWidth = screenWidth > 600 ? screenWidth * 0.3 : screenWidth * 0.5;
        final itemHeight = itemWidth * 1.5;

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
                    child: MostRentPropertyCard(property: properties[index]),
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
