import 'package:flutter/material.dart';
import 'package:peron_project/features/filter/models/property_model.dart';

class PropertyCard extends StatefulWidget {
  final PropertyModel property;
  final VoidCallback onTap;          

  const PropertyCard({
    Key? key,
    required this.property,
    required this.onTap,
  }) : super(key: key);

  @override
  State<PropertyCard> createState() => _PropertyCardState();
}

class _PropertyCardState extends State<PropertyCard> {
  int _currentImageIndex = 0;

  final List<String> _imagesPaths = [
    'assets/images/appartment.jpg',
    'assets/images/appartment2.jpg',
    'assets/images/appartment3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: widget.onTap,   
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.all(w * 0.02),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            margin: EdgeInsets.all(w * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      SizedBox(
                        height: h * 0.25,
                        width: double.infinity,
                        child: PageView.builder(
                          itemCount: _imagesPaths.length,
                          onPageChanged: (idx) => setState(() => _currentImageIndex = idx),
                          itemBuilder: (_, idx) => Image.asset(
                            _imagesPaths[idx],
                            width: double.infinity,
                            height: h * 0.25,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(_imagesPaths.length, (idx) {
                            final selected = idx == _currentImageIndex;
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: EdgeInsets.symmetric(horizontal: w * 0.005),
                              width: selected ? 24 : 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: selected
                                    ? const Color(0xFF0F8E65)
                                    : Colors.white.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),

                // بيانات العقار
                Padding(
                  padding: EdgeInsets.all(w * 0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // العنوان والسعر
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.property.title,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Cairo'),
                            ),
                          ),
                          Text(
                            '${widget.property.price} ج.م',
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cairo'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // المكان
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 16, color: Color(0xFF0F8E65)),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              widget.property.location,
                              style: TextStyle(color: Colors.grey[700], fontSize: 14),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      Row(
                        children: [
                          _buildInfo(Icons.chair, widget.property.bedrooms),
                          const SizedBox(width: 12),
                          _buildInfo(Icons.bathtub, widget.property.bathrooms),
                          const SizedBox(width: 12),
                          if (widget.property.area != null)
                            _buildInfo(Icons.square_foot, widget.property.area!),
                          const Spacer(),
                          Text(
                            'نُشرت في: ${widget.property.publishedDateFormatted}',
                            style: TextStyle(color: Colors.grey[600], fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfo(IconData icon, int value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey),
        const SizedBox(width: 4),
        Text('$value', style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}
