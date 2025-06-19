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
  final int _currentImageIndex = 0;
  bool _showExtendedDetails = false;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    context.read<ReviewCubit>().getRates(widget.propertyId);
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }


  void _toggleExtendedDetails() {
    setState(() {
      _showExtendedDetails = !_showExtendedDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetPropertyCubit(GetPropertyRepoImp(ApiService(Dio())))
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
            final property = state.propertyDetails!;
            final List<String> _imagesPaths = state.propertyDetails!.images??[];
            void goToImage(int index) {
              if (index >= 0 && index < _imagesPaths.length) {
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            }


            final screenSize = MediaQuery.of(context).size;
            final screenWidth = screenSize.width;
            final screenHeight = screenSize.height;

            final imageHeight = screenHeight * 0.5;
            final iconSize = screenWidth * 0.055;
            final standardPadding = screenWidth * 0.0;
            final smallPadding = standardPadding * 0.3;
            final titleFontSize = screenWidth * 0.055;
            final priceFontSize = screenWidth * 0.06;
            final regularFontSize = screenWidth * 0.045;
            final smallFontSize = screenWidth * 0.04;
            final smallCircleSize = screenWidth * 0.09;
            return Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          PropertyImageSlider(
                            imagesPaths: property.images ?? [],
                            currentImageIndex: _currentImageIndex,
                            goToImage: goToImage,
                            imageHeight: imageHeight,
                            standardPadding: standardPadding,
                            screenHeight: screenHeight,
                            smallCircleSize: smallCircleSize,
                            pageController: _pageController,
                          ),

                          PropertyHeader(
                            property: property,
                            standardPadding: standardPadding,
                            titleFontSize: titleFontSize,
                            priceFontSize: priceFontSize,
                            smallPadding: smallPadding,
                            regularFontSize: regularFontSize,
                            smallFontSize: smallFontSize,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0,right: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(width: 10),
                                FeatureItem(
                                  text: "${property.bedrooms}",
                                  icon: Icons.chair,
                                  screenWidth: screenWidth,
                                ),
                                const SizedBox(width: 12),
                                FeatureItem(
                                  text: "${property.bathrooms}",
                                  icon: Icons.bathtub,
                                  screenWidth: screenWidth,
                                ),
                                const SizedBox(width: 12),
                                FeatureItem(
                                  text: "${property.bedrooms}",
                                  icon: Icons.bed,
                                  screenWidth: screenWidth,
                                ),
                                const SizedBox(width: 12),
                                FeatureItem(
                                  text: "${property.area}",
                                  icon: Icons.swap_horiz,
                                  screenWidth: screenWidth,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12,),
                          PropertyDescription(
                            description: property.description ?? "لا يوجد وصف للشقة",
                            standardPadding: standardPadding,
                            smallPadding: smallPadding,
                            regularFontSize: regularFontSize,
                            toggleExtendedDetails: _toggleExtendedDetails,
                            showExtendedDetails: _showExtendedDetails,
                            smallFontSize: smallFontSize,
                          ),
                          if (_showExtendedDetails) ...[
                            PropertyInformation(
                              smallFontSize: smallFontSize,
                              property: property,
                              screenWidth: screenWidth,
                              fontSize: regularFontSize,
                              padding: standardPadding,
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
                    property: property,
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
            return const Scaffold(); // Initial state
          }
        },
      ),
    );
  }
}
