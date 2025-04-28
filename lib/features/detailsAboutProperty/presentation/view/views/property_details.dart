import 'package:flutter/material.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/widgets/additionalFeatures.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/widgets/contactButtons.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/widgets/featureItem.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/widgets/locationMapWidget.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/widgets/propertyComponents.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/widgets/propertyDescription.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/widgets/propertyFeature.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/widgets/propertyHeader.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/widgets/propertyImageSlider.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/widgets/propertyInformation.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/recommendedProperties.dart';
import '../widgets/reviewsSection.dart';

class PropertyDetailScreen extends StatefulWidget {
  const PropertyDetailScreen({Key? key}) : super(key: key);

  @override
  State<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
  int _currentImageIndex = 0;
  bool _showExtendedDetails = false;

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

  void _toggleExtendedDetails() {
    setState(() {
      _showExtendedDetails = !_showExtendedDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    final imageHeight = screenHeight * 0.5;
    final iconSize = screenWidth * 0.055;
    final smallIconSize = iconSize * 0.9;

    final standardPadding = screenWidth * 0.03;
    final smallPadding = standardPadding * 0.3;

    final titleFontSize = screenWidth * 0.055;
    final priceFontSize = screenWidth * 0.06;
    final regularFontSize = screenWidth * 0.045;
    final smallFontSize = screenWidth * 0.04;

    final circleSize = screenWidth * 0.1;
    final smallCircleSize = screenWidth * 0.08;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PropertyImageSlider(
                    imagesPaths: _imagesPaths,
                    currentImageIndex: _currentImageIndex,
                    goToImage: _goToImage,
                    imageHeight: imageHeight,
                    standardPadding: standardPadding,
                    screenHeight: screenHeight,
                    smallCircleSize: smallCircleSize,
                  ),
                  PropertyHeader(
                    standardPadding: standardPadding,
                    titleFontSize: titleFontSize,
                    priceFontSize: priceFontSize,
                    smallPadding: smallPadding,
                    regularFontSize: regularFontSize,
                    smallFontSize: smallFontSize,
                    smallIconSize: smallIconSize,
                    smallCircleSize: smallCircleSize,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: smallPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FeatureItem(
                          text: '150',
                          icon: Icons.swap_horiz,
                          screenWidth: screenWidth,
                        ),
                        FeatureItem(
                          text: '5',
                          icon: Icons.bed,
                          screenWidth: screenWidth,
                        ),
                        FeatureItem(
                          text: '2',
                          icon: Icons.bathtub,
                          screenWidth: screenWidth,
                        ),
                        FeatureItem(
                          text: '4',
                          icon: Icons.chair,
                          screenWidth: screenWidth,
                        ),
                      ],
                    ),
                  ),
                  PropertyDescription(
                    standardPadding: standardPadding,
                    smallPadding: smallPadding,
                    regularFontSize: regularFontSize,
                    toggleExtendedDetails: _toggleExtendedDetails,
                    showExtendedDetails: _showExtendedDetails,
                    smallFontSize: smallFontSize,
                  ),
                  if (_showExtendedDetails) ...[
                    PropertyInformation(
                      screenWidth: screenWidth,
                      padding: standardPadding,
                      fontSize: regularFontSize,
                    ),

                    PropertyFeatures(
                      screenWidth: screenWidth,
                      padding: standardPadding,
                      fontSize: regularFontSize,
                      smallFontSize: smallFontSize,
                    ),

                    PropertyComponents(
                      screenWidth: screenWidth,
                      padding: standardPadding,
                      fontSize: regularFontSize,
                      smallFontSize: smallFontSize,
                    ),

                    AdditionalFeatures(
                      screenWidth: screenWidth,
                      padding: standardPadding,
                      fontSize: regularFontSize,
                    ),

                    LocationMapWidget(
                      screenWidth: screenWidth,
                      padding: standardPadding,
                      fontSize: regularFontSize,
                      smallFontSize: smallFontSize,
                      propertyLatitude: 30.0444,
                      propertyLongitude: 31.2357,
                      propertyTitle: "شقة سكنية بحى الجامعه",
                    ),

                    ReviewsSection(
                      screenWidth: screenWidth,
                      padding: standardPadding,
                      fontSize: regularFontSize,
                      smallFontSize: smallFontSize,
                    ),

                    RecommendedProperties(
                      screenWidth: screenWidth,
                      padding: standardPadding,
                      fontSize: regularFontSize,
                      smallFontSize: smallFontSize,
                    ),

                   
                  ],
                ],
              ),
            ),
          ),
          ContactButtons(
            standardPadding: standardPadding,
            regularFontSize: regularFontSize,
            smallPadding: smallPadding,
            iconSize: iconSize,
            screenHeight: screenHeight,
          ),
        ],
      ),
    );
  }
}
