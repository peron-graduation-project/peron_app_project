import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/views/review.dart';
import 'package:url_launcher/url_launcher.dart';

class CurvedTopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, 60);
    path.quadraticBezierTo(size.width / 2, -20, size.width, 60);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class PropertyDetailScreen extends StatefulWidget {
  const PropertyDetailScreen({Key? key}) : super(key: key);

  @override
  State<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
  int _currentImageIndex = 0;

  // قائمة بعدة صور للعقار
  final List<String> _imagesPaths = [
    'assets/images/appartment.jpg',
    'assets/images/appartment2.jpg',
    'assets/images/appartment3.jpg',
  ];

  void _goToImage(int index) {
    if (index >= 0 && index < _imagesPaths.length) {
      setState(() {
        _currentImageIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    final imageHeight = screenHeight * 0.5;
    final iconSize = screenWidth * 0.045;
    final smallIconSize = iconSize * 0.8;

    final standardPadding = screenWidth * 0.04;
    final smallPadding = standardPadding * 0.5;

    final titleFontSize = screenWidth * 0.045;
    final priceFontSize = screenWidth * 0.05;
    final regularFontSize = screenWidth * 0.035;
    final smallFontSize = screenWidth * 0.03;

    final circleSize = screenWidth * 0.09;
    final smallCircleSize = screenWidth * 0.07;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    children: [
                      GestureDetector(
                        onHorizontalDragEnd: (details) {
                          if (details.primaryVelocity != null) {
                            if (details.primaryVelocity! > 0) {
                              _goToImage(_currentImageIndex - 1);
                            } else {
                              _goToImage(_currentImageIndex + 1);
                            }
                          }
                        },
                        child: Container(
                          height: imageHeight,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                _imagesPaths[_currentImageIndex],
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: imageHeight * 0.15,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: screenWidth * 0.015,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  _imagesPaths.length,
                                  (index) => Container(
                                    width: _currentImageIndex == index ? 24 : 8,
                                    height: 8,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          _currentImageIndex == index
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
                      Positioned(
                        top: screenHeight * 0.05,
                        right: standardPadding,
                        child: Container(
                          width: smallCircleSize,
                          height: smallCircleSize,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              Icons.chevron_right,
                              color: Colors.grey[800],
                              size: 25,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: ClipPath(
                          clipper: CurvedTopClipper(),
                          child: Container(height: 60, color: Colors.white),
                        ),
                      ),

                      // Favorite icon (heart)
                      // Positioned(
                      //   top: imageHeight - 30,
                      //   left: standardPadding,
                      //   child: Container(
                      //     width: circleSize,
                      //     height: circleSize,
                      //     decoration: BoxDecoration(
                      //       color: const Color(0xff0F7757),
                      //       shape: BoxShape.circle,
                      //       boxShadow: [
                      //         BoxShadow(
                      //           color: Colors.black.withOpacity(0.1),
                      //           blurRadius: 4,
                      //           offset: const Offset(0, 2),
                      //         ),
                      //       ],
                      //     ),
                      //     child: Icon(
                      //       Icons.favorite,
                      //       color: Colors.white,
                      //       size: iconSize,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: standardPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      textDirection: TextDirection.rtl,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            textDirection: TextDirection.rtl,
                            children: [
                              Text(
                                "شقة سكنية بقناة السويس",
                                style: TextStyle(
                                  fontSize: titleFontSize,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.right,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                textDirection: TextDirection.rtl,
                                children: [
                                  Text(
                                    "2500",
                                    style: TextStyle(
                                      fontSize: priceFontSize,
                                      color: const Color(0xff0F7757),
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  SizedBox(width: smallPadding * 0.2),
                                  Text(
                                    "ج.م",
                                    style: TextStyle(
                                      fontSize: priceFontSize,
                                      color: const Color(0xff0F7757),
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: smallPadding * 0.4),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                textDirection: TextDirection.rtl,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: const Color(0xff0F7757),
                                    size: smallIconSize,
                                  ),
                                  SizedBox(width: smallPadding * 0.8),
                                  Text(
                                    "  4",
                                    style: TextStyle(
                                      fontSize: regularFontSize,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        " (",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: const Color(0xff565656),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (context) => ReviewsScreen(),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          " تقييم ",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: const Color(0xff565656),
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        " 25",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: const Color(0xff565656),
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      Text(
                                        " ) ",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: const Color(0xff565656),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SvgPicture.asset("assets/icons/heart.svg"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        SizedBox(width: 75),
                        _buildFeatureItem('150', Icons.swap_horiz, screenWidth),
                        SizedBox(width: 20),
                        _buildFeatureItem('5', Icons.bed, screenWidth),
                        SizedBox(width: 20),
                        _buildFeatureItem('2', Icons.bathtub, screenWidth),
                        SizedBox(width: 20),
                        _buildFeatureItem('4', Icons.chair, screenWidth),
                        SizedBox(width: 0),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      standardPadding,
                      standardPadding,
                      standardPadding,
                      smallPadding,
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'وصف الشقة',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: standardPadding),
                    child: Text(
                      'النوع: شقة مميزة في موقع هادي وسكني راقي، تطل على شارع واسع. تتكون من 3 غرف نوم رئيسية، غرفتين حمام، مطبخ، ومغلقة كلياً في الدور الثالث في عمارة حديثة مزودة بأساسنسير. العمارة نظيفة وآمنة.\n\nالمساحة: مساحة واسعة تبلغ 150 م\n\nالتشطيب: سوبر لوكس',
                      style: TextStyle(
                        color: Colors.grey[700],
                        height: 1.5,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      standardPadding,
                      smallPadding,
                      standardPadding,
                      standardPadding,
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          'اقرأ المزيد...',
                          style: TextStyle(
                            color: const Color(0xff0F7757),
                            fontWeight: FontWeight.bold,
                            fontSize: smallFontSize,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: standardPadding,
              vertical: standardPadding * 0.75,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              textDirection: TextDirection.rtl,
              children: [
                SizedBox(width: standardPadding * 0.5),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      launchUrl(Uri.parse("mailto:example@email.com"));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade200,
                      padding: EdgeInsets.symmetric(
                        vertical: standardPadding * 0.8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'الايميل',
                          style: TextStyle(
                            fontSize: regularFontSize,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: smallPadding),
                        Icon(
                          Icons.email_outlined,
                          color: Colors.black54,
                          size: iconSize,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: standardPadding * 0.5),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      launchUrl(Uri.parse("tel:+123456789"));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade200,
                      padding: EdgeInsets.symmetric(
                        vertical: standardPadding * 0.8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'اتصال',
                          style: TextStyle(
                            fontSize: regularFontSize,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: smallPadding),
                        Icon(
                          Icons.phone,
                          color: Colors.black54,
                          size: iconSize,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: standardPadding * 0.5),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      launchUrl(Uri.parse("https://wa.me/123456789"));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen.shade100,
                      padding: EdgeInsets.symmetric(
                        vertical: standardPadding * 0.8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Icon(
                      Icons.chat,
                      color: Colors.green,
                      size: iconSize,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String text, IconData icon, double screenWidth) {
    // Responsive values for feature items
    final featureFontSize = screenWidth * 0.035;
    final featureIconSize = screenWidth * 0.04;
    final featurePadding = screenWidth * 0.03;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: featurePadding,
        vertical: featurePadding * 0.65,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: featureFontSize,
            ),
          ),
          SizedBox(width: featurePadding * 0.3),
          Icon(icon, size: featureIconSize, color: Colors.grey),
        ],
      ),
    );
  }
}
