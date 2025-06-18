import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/core/network/api_service.dart';
import 'package:peron_project/features/detailsAboutProperty/domain/repos/get%20property/get_property_repo_imp.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/manager/get%20property/get_property_cubit.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/manager/get%20property/get_property_state.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/views/cubit/review_cubit.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/widgets/additionalFeatures.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/widgets/contactButtons.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/widgets/featureItem.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/widgets/locationMapWidget.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/widgets/propertyComponents.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/widgets/propertyDescription.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/widgets/propertyHeader.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/widgets/propertyImageSlider.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/widgets/propertyInformation.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/widgets/recommendedProperties.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/widgets/reviewsSection.dart';

import '../../../../../core/helper/colors.dart';

class PropertyDetailScreen extends StatefulWidget {
  final int propertyId;

  const PropertyDetailScreen({super.key, required this.propertyId});

  @override
  State<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
  int _currentImageIndex = 0;
  bool _showExtendedDetails = false;

  @override
  void initState() {
    context.read<ReviewCubit>().getRates(widget.propertyId);
    super.initState();
  }

  final List<String> _imagesPaths = [
    'assets/images/appartment.jpg',
    'assets/images/appartment2.jpg',
    'assets/images/appartment3.jpg',
  ];

  void goToImage(int index) {
    if (index >= 0 && index < _imagesPaths.length) {
      // Update currentImageIndex (e.g., via a callback or state management)
    }
  }

  void _toggleExtendedDetails() {
    setState(() {
      _showExtendedDetails = !_showExtendedDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              GetPropertyCubit(GetPropertyRepoImp(ApiService(Dio())))
                ..getPropertyDetails(id: widget.propertyId),
      child: BlocBuilder<GetPropertyCubit, GetPropertyState>(
        builder: (context, state) {
          if (state is GetPropertyStateLoading) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              ),
            );
          } else if (state is GetPropertyStateFailure) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<GetPropertyCubit>().getPropertyDetails(
                          id: widget.propertyId,
                        );
                      },
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is GetPropertyStateSuccess) {
            final property = state.propertyDetails;
            final screenSize = MediaQuery.of(context).size;
            final screenWidth = screenSize.width;
            final screenHeight = screenSize.height;

            final imageHeight = screenHeight * 0.5;
            final iconSize = screenWidth * 0.055;
            final smallIconSize = iconSize * 0.9;

            final standardPadding = screenWidth * 0.0;
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
                            imagesPaths: property?.images ?? [],
                            currentImageIndex: _currentImageIndex,
                            goToImage: goToImage,
                            imageHeight: imageHeight,
                            standardPadding: standardPadding,
                            screenHeight: screenHeight,
                            smallCircleSize: smallCircleSize,
                          ),
                          PropertyHeader(
                            property: state.propertyDetails!,
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
                            padding: EdgeInsets.only(right: 10
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(width: 10),
                                FeatureItem(
                                  text: "${property?.bedrooms}",
                                  icon: Icons.chair,
                                  screenWidth: screenWidth,
                                ),
                                const SizedBox(width: 12),
                                FeatureItem(
                                  text: "${property?.bathrooms}",
                                  icon: Icons.bathtub,
                                  screenWidth: screenWidth,
                                ),
                                const SizedBox(width: 12),
                                FeatureItem(
                                  text: "${property?.bedrooms}",
                                  icon: Icons.bed,
                                  screenWidth: screenWidth,
                                ),
                                const SizedBox(width: 12),
                                FeatureItem(
                                  text: "${property?.area}",
                                  icon: Icons.swap_horiz,
                                  screenWidth: screenWidth,
                                ),
                              ],
                            ),
                          ),
                          PropertyDescription(
                            description: "${property?.description}",
                            standardPadding: standardPadding,
                            smallPadding: smallPadding,
                            regularFontSize: regularFontSize,
                            toggleExtendedDetails: _toggleExtendedDetails,
                            showExtendedDetails: _showExtendedDetails,
                            smallFontSize: smallFontSize,
                          ),
                          if (_showExtendedDetails) ...[
                            PropertyInformation(
                              property: property!,
                              screenWidth: screenWidth,
                              padding: standardPadding,
                              fontSize: regularFontSize,
                            ),
                           
                            PropertyComponents(
                              property: property,
                              screenWidth: screenWidth,
                              padding: standardPadding,
                              fontSize: regularFontSize,
                              smallFontSize: smallFontSize,
                            ),
                            AdditionalFeatures(
                              property: property,
                              screenWidth: screenWidth,
                              padding: standardPadding,
                              fontSize: regularFontSize,
                            ),
                            LocationMapWidget(
                              screenWidth: screenWidth,
                              padding: standardPadding,
                              fontSize: regularFontSize,
                              smallFontSize: smallFontSize,
                              property: property,
                            ),

                            ReviewsSection(
                              screenWidth: screenWidth,
                              padding: standardPadding,
                              fontSize: regularFontSize,
                              smallFontSize: smallFontSize,
                              propertId: widget.propertyId,
                            ),
                            RecommendedProperties(
                              location: property.location ?? "",
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
                    property: property!,
                    standardPadding: standardPadding,
                    regularFontSize: regularFontSize,
                    smallPadding: smallPadding,
                    iconSize: iconSize,
                    screenHeight: screenHeight,
                  ),
                ],
              ),
            );
          } else {
            return const Scaffold(); // للحالة initial
          }
        },
      ),
    );
  }
}
