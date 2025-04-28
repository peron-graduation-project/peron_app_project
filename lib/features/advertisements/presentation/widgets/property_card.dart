import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peron_project/core/helper/fonts.dart';
import 'package:peron_project/features/myAds/presentation/view/views/modifyProperty.dart';

class PropertyCard extends StatefulWidget {
  const PropertyCard({Key? key}) : super(key: key);

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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.grey.withOpacity(0.3),
              width: 1.5,
            ),
           
          ),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 180,
                          child: PageView.builder(
                            itemCount: _imagesPaths.length,
                            onPageChanged: (index) {
                              setState(() {
                                _currentImageIndex = index;
                              });
                            },
                            itemBuilder: (context, index) {
                              return Image.asset(
                                _imagesPaths[index],
                                width: double.infinity,
                                height: 180,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: GestureDetector(
                            onTap:(){
                              Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditPropertyScreen()),
                    );
                            } ,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFF0F8E65),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child:  Text(
                                'تعديل',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                              fontFamily: Fonts.primaryFontFamily,
                            
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 0,
                          left: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              _imagesPaths.length,
                              (index) => Container(
                                width: _currentImageIndex == index ? 24 : 8,
                                height: 8,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                decoration: BoxDecoration(
                                  color: _currentImageIndex == index
                                      ? const Color(0xFF0F8E65)
                                      : Colors.white.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                           Expanded(
                            child: Text(
                              'شقة سكنية بقناة السويس',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.black,            fontFamily: Fonts.primaryFontFamily,

                                  ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Text(
                              '20,222 جنيه',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 22,
                                              fontFamily: Fonts.primaryFontFamily,

                                  ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: const Color(0xFF0F8E65),
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              'شارع قناة السويس بجانب مشاوي المحمدي',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 69, 69, 69),
                                  fontSize: 15,fontWeight: FontWeight.w100,            fontFamily: Fonts.primaryFontFamily,

                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildPropertyInfoRow(Icons.chair, 3),
                          SizedBox(
                            width: 10,
                          ),
                          buildPropertyInfoRow(Icons.bathtub, 5),
                          SizedBox(
                            width: 10,
                          ),
                          buildPropertyInfoRow(Icons.bed, 2),
                          SizedBox(
                            width: 10,
                          ),
                          buildPropertyInfoRow(Icons.swap_horiz, 150),
                          SizedBox(
                            width: 10,
                          ),
                          const Spacer(),
                          Text(
                            'نُشرت في: 25/2/2025',
                            style: TextStyle(
                                color: const Color.fromARGB(255, 171, 171, 171),
                                fontSize: 12,
                                fontWeight: FontWeight.w100,            fontFamily: Fonts.primaryFontFamily,

                                ),
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

  Widget _buildDetailItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget buildPropertyInfoRow(IconData icon, int value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color.fromARGB(255, 195, 194, 194)),
        SizedBox(width: 2),
        Text("$value",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w100,
              color: Colors.grey
            )),
      ],
    );
  }
}