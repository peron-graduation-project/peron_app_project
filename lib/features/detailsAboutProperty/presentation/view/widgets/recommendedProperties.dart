import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:peron_project/core/helper/fonts.dart';

class RecommendedProperties extends StatefulWidget {
  final double screenWidth;
  final double padding;
  final double fontSize;
  final double smallFontSize;

  const RecommendedProperties({
    Key? key,
    required this.screenWidth,
    required this.padding,
    required this.fontSize,
    required this.smallFontSize,
  }) : super(key: key);

  @override
  State<RecommendedProperties> createState() => _RecommendedPropertiesState();
}

class _RecommendedPropertiesState extends State<RecommendedProperties> {
  final Set<int> _favoriteIndices = {};

  void _toggleFavorite(int index) {
    setState(() {
      if (_favoriteIndices.contains(index)) {
        _favoriteIndices.remove(index);
      } else {
        _favoriteIndices.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(thickness: 0.3),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: widget.padding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'مقترح به لك',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  fontFamily: Fonts.primaryFontFamily,
                ),
                textAlign: TextAlign.right,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'عرض الكل',
                  style: TextStyle(
                    color: const Color(0xff0F7757),
                    fontFamily: Fonts.primaryFontFamily,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Directionality(
          textDirection: TextDirection.rtl,
          child: SizedBox(
            height: 180,
            child: ListView(
              scrollDirection: Axis.horizontal,
              // تم إزالة reverse: true لجعل التمرير من اليمين لليسار
              padding: EdgeInsets.symmetric(horizontal: widget.padding),
              children: [
                _buildPropertyCard(
                  context,
                  index: 0,
                  imagePath: 'assets/images/appartment.jpg',
                  propertyType: 'شقة سكنية',
                  location: 'توريل',
                  price: '2200.00',
                ),
                SizedBox(width: 12),
                _buildPropertyCard(
                  context,
                  index: 1,
                  imagePath: 'assets/images/appartment2.jpg',
                  propertyType: 'شقة سكنية',
                  location: 'توريل',
                  price: '2200.00',
                ),
                SizedBox(width: 12),
                _buildPropertyCard(
                  context,
                  index: 2,
                  imagePath: 'assets/images/appartment3.jpg',
                  propertyType: 'شقة سكنية',
                  location: 'توريل',
                  price: '2200.00',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPropertyCard(
    BuildContext context, {
    required int index,
    required String imagePath,
    required String propertyType,
    required String location,
    required String price,
  }) {
    bool isFavorite = _favoriteIndices.contains(index);

    return Container(
      width: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 12),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      imagePath,
                      height: 90,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 5,
                    left: 5,
                    child: GestureDetector(
                      onTap: () => _toggleFavorite(index),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.home, color: Colors.grey, size: 14),
                    SizedBox(width: 4),
                    Text(
                      "النوع",
                      style: TextStyle(
                        fontSize: widget.smallFontSize * 0.75,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 225, 223, 223),
                        fontFamily: Fonts.primaryFontFamily,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      propertyType,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: widget.smallFontSize * 0.85,
                        fontWeight: FontWeight.normal,
                        fontFamily: Fonts.primaryFontFamily,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on, color: Colors.grey, size: 14),
                    Text(
                      "الموقع",
                      style: TextStyle(
                        fontSize: widget.smallFontSize * 0.75,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 225, 223, 223),
                        fontFamily: Fonts.primaryFontFamily,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      location,
                      style: TextStyle(
                        fontSize: widget.smallFontSize * 0.75,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontFamily: Fonts.primaryFontFamily,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.monetization_on, color: Colors.grey, size: 14),
                    SizedBox(width: 4),
                    Text(
                      'السعر:',
                      style: TextStyle(
                        fontSize: widget.smallFontSize * 0.75,
                        color: const Color.fromARGB(255, 225, 223, 223),
                        fontWeight: FontWeight.normal,
                        fontFamily: Fonts.primaryFontFamily,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: widget.smallFontSize * 0.75,
                        fontWeight: FontWeight.w200,
                        color: Color(0xff0F7757),
                        fontFamily: Fonts.primaryFontFamily,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      'ج.م',
                      style: TextStyle(
                        fontSize: widget.smallFontSize * 0.75,
                        fontWeight: FontWeight.w200,
                        color: Color(0xff0F7757),
                        fontFamily: Fonts.primaryFontFamily,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}