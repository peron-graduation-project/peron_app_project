import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/colors.dart';

class PropertyCard extends StatefulWidget {
  final Map<String, dynamic> property;
  const PropertyCard({super.key, required this.property});

  @override
  _PropertyCardState createState() => _PropertyCardState();
}

class _PropertyCardState extends State<PropertyCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    final property = widget.property;
    double screenWidth = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        double itemWidth = constraints.maxWidth > 0 ? constraints.maxWidth : screenWidth * 0.45;
        debugPrint("Item Width: $itemWidth");

        double iconSize = itemWidth * 0.1;
        double textSize = itemWidth * 0.08;
        double paddingSize = itemWidth * 0.05;

        return Container(
          padding: EdgeInsets.all(paddingSize),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xff7F7F7F66)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // يجعل الكارد يأخذ الطول المناسب للمحتوى
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.asset(
                      property["image"],
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: itemWidth * 0.6,
                          color: Colors.grey[300],
                          child: const Center(child: Icon(Icons.image_not_supported, size: 50)),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? AppColors.primaryColor : Colors.white,
                        size: iconSize,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.primaryColor,
                      ),
                      child: Text(
                        "${property["price"]} ج.م",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: textSize,
                        ),
                      ),
                    ),
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
                    Text(
                      property["title"],
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: textSize),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: paddingSize * 0.5),
                    Row(
                      children: [
                        Text("(${property["rating"]})", style: TextStyle(fontSize: textSize * 0.8)),
                        ...List.generate(
                          5,
                              (i) => Icon(
                            Icons.star,
                            size: iconSize * 0.8,
                            color: i < property["rating"] ? const Color(0xFF0F7757) : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: paddingSize * 0.5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.location_on, color: AppColors.primaryColor, size: iconSize * 0.8),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            property['location'],
                            style: theme.bodySmall!.copyWith(color: const Color(0xff282929)),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        buildPropertyInfoRow(Icons.chair, "${property["rooms"]} غرف", iconSize, textSize),
                        buildPropertyInfoRow(Icons.bathtub, "${property["bathrooms"]} حمام", iconSize, textSize),
                        buildPropertyInfoRow(Icons.bed, "${property["beds"]} سرير", iconSize, textSize),
                        buildPropertyInfoRow(Icons.square_foot, "${property["area"]} م²", iconSize, textSize),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildPropertyInfoRow(IconData icon, dynamic value, double iconSize, double textSize) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 4,
      children: [
        Icon(icon, size: iconSize, color: Colors.grey),
        Text("$value", style: TextStyle(fontSize: textSize * 0.8)),
      ],
    );
  }
}
