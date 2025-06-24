import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/core/helper/fonts.dart';
import 'package:peron_project/core/utils/property_model.dart';
import 'package:peron_project/features/main/presentation/manager/get%20Search/get_search_cubit.dart';
import 'package:peron_project/features/main/presentation/manager/get%20Search/get_search_state.dart';
import '../views/property_details.dart';

class RecommendedProperties extends StatefulWidget {
  final double screenWidth;
  final double padding;
  final double fontSize;
  final double smallFontSize;
  final String location;

  const RecommendedProperties({
    super.key,
    required this.location,
    required this.screenWidth,
    required this.padding,
    required this.fontSize,
    required this.smallFontSize,
  });

  @override
  State<RecommendedProperties> createState() => _RecommendedPropertiesState();
}

class _RecommendedPropertiesState extends State<RecommendedProperties> {
  final Set<int> _favoriteIndices = {};

  @override
  void initState() {
    super.initState();
    context.read<GetSearchPropertiesCubit>().getSearchProperties(widget.location);
  }

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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final cardWidth = screenWidth * 0.38;
    final cardImageHeight = screenHeight * 0.13;
    final iconSize = screenWidth * 0.04;
    final padding = screenWidth * 0.03;
    final titleFontSize = screenWidth * 0.035;
    final smallFontSize = screenWidth * 0.03;

    return BlocBuilder<GetSearchPropertiesCubit, GetSearchPropertiesState>(
      builder: (context, state) {
        if (state is GetSearchPropertiesStateLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is GetSearchPropertiesStateFailure) {
          return Center(
            child: Text(
              'فشل في جلب البيانات: ${state.errorMessage}',
              style: TextStyle(color: Colors.red),
            ),
          );
        }

        if (state is GetSearchPropertiesStateEmpty) {
          return Center(
            child: Text(
              'لا توجد عقارات متاحة في هذا الموقع',
              style: TextStyle(color: Colors.grey),
            ),
          );
        }

        if (state is GetSearchPropertiesStateSuccess) {
          List<Property> properties = state.properties;
          return Column(
            children: [
              Divider(thickness: 0.3),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'مقترح به لك',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: widget.fontSize,
                        fontWeight: FontWeight.w300,
                        fontFamily: Fonts.primaryFontFamily,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Directionality(
                textDirection: TextDirection.rtl,
                child: SizedBox(
                  height: screenHeight * 0.24,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: widget.padding),
                    itemCount: properties.length,
                    itemBuilder: (context, index) {
                      Property property = properties[index];
                      return Row(
                        children: [
                          _buildPropertyCard(
                            context,
                            index: index,
                            property: property,
                            imagePath: property.images != null && property.images!.isNotEmpty
                                ? property.images![0]
                                : "",
                            propertyType: property.rentType ?? "غير محدد",
                            location: property.location ?? "موقع غير محدد",
                            price: property.price != null ? property.price.toString() : "سعر غير محدد",
                            cardWidth: cardWidth,
                            cardImageHeight: cardImageHeight,
                            iconSize: iconSize,
                            smallFontSize: smallFontSize,
                            padding: padding,
                          ),
                          SizedBox(width: 12),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }

        return Container();
      },
    );
  }

  Widget _buildPropertyCard(
      BuildContext context, {
        required int index,
        required String imagePath,
        required String propertyType,
        required String location,
        required String price,
        required Property property,
        required double cardWidth,
        required double cardImageHeight,
        required double iconSize,
        required double smallFontSize,
        required double padding,
      }) {
    bool isFavorite = _favoriteIndices.contains(index);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PropertyDetailScreen(propertyId: property.propertyId ?? 24)),
        );
      },
      child: Container(
        width: cardWidth,
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
              padding: EdgeInsets.only(top: padding),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: padding),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: imagePath.isNotEmpty
                          ? Image.network(
                        imagePath,
                        height: cardImageHeight,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: cardImageHeight,
                            width: double.infinity,
                            color: Colors.grey[300],
                            child: Icon(Icons.broken_image, size: iconSize),
                          );
                        },
                      )
                          : Container(
                        height: cardImageHeight,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: Icon(Icons.image_not_supported, size: iconSize),
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
                          size: iconSize + 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Icon(Icons.home, color: Colors.grey, size: iconSize),
                      SizedBox(width: 4),
                      Text(
                        "النوع",
                        style: TextStyle(
                          fontSize: smallFontSize * 0.9,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[400],
                          fontFamily: Fonts.primaryFontFamily,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        propertyType,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: smallFontSize,
                          fontWeight: FontWeight.normal,
                          fontFamily: Fonts.primaryFontFamily,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.grey, size: iconSize),
                      SizedBox(width: 4),
                      Text(
                        "الموقع",
                        style: TextStyle(
                          fontSize: smallFontSize * 0.9,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[400],
                          fontFamily: Fonts.primaryFontFamily,
                        ),
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          location,
                          style: TextStyle(
                            fontSize: smallFontSize,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontFamily: Fonts.primaryFontFamily,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(Icons.monetization_on, color: Colors.grey, size: iconSize),
                      SizedBox(width: 4),
                      Text(
                        'السعر:',
                        style: TextStyle(
                          fontSize: smallFontSize * 0.9,
                          color: Colors.grey[400],
                          fontWeight: FontWeight.normal,
                          fontFamily: Fonts.primaryFontFamily,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        price,
                        style: TextStyle(
                          fontSize: smallFontSize,
                          fontWeight: FontWeight.w200,
                          color: Color(0xff0F7757),
                          fontFamily: Fonts.primaryFontFamily,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        'ج.م',
                        style: TextStyle(
                          fontSize: smallFontSize,
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
      ),
    );
  }
}
