import 'package:flutter/material.dart';

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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: widget.padding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  'عرض الكل',
                  style: TextStyle(
                    color: const Color(0xff0F7757),
                    fontWeight: FontWeight.bold,
                    fontSize: widget.smallFontSize,
                  ),
                ),
              ),
              Text(
                'مقترح لك',
                style: TextStyle(
                  fontSize: widget.fontSize * 1.2,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 180, // Further reduced height
          child: ListView(
            scrollDirection: Axis.horizontal,
            reverse: true, // RTL direction
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
              const SizedBox(width: 12),
              _buildPropertyCard(
                context,
                index: 1,
                imagePath: 'assets/images/appartment2.jpg',
                propertyType: 'شقة سكنية',
                location: 'توريل',
                price: '2200.00',
              ),
              const SizedBox(width: 12),
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
      ],
    );
  }

  Widget _buildPropertyCard(BuildContext context,
      {required int index,
      required String imagePath,
      required String propertyType,
      required String location,
      required String price}) {
    bool isFavorite = _favoriteIndices.contains(index);

    return Container(
      width: 140, // Smaller width for the card
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Property Image with Favorite button
          Container(
            margin: const EdgeInsets.all(
                8), // Increased space between image and border
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    imagePath,
                    height: 90, // Reduced image height more
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
          // Property Details
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Property Type
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      propertyType,
                      style: TextStyle(
                        fontSize: widget.smallFontSize * 0.85,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.home,
                      color: Colors.grey,
                      size: 14,
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                // Location
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      location,
                      style: TextStyle(
                        fontSize: widget.smallFontSize * 0.75,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.location_on,
                      color: Colors.grey,
                      size: 14,
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                // Price
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'ج.م',
                      style: TextStyle(
                        fontSize: widget.smallFontSize * 0.75,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff0F7757),
                      ),
                    ),
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: widget.smallFontSize * 0.75,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff0F7757),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'السعر:',
                      style: TextStyle(
                        fontSize: widget.smallFontSize * 0.75,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.monetization_on,
                      color: Colors.grey,
                      size: 14,
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
