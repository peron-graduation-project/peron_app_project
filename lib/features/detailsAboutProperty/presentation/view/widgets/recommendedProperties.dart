import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/core/helper/fonts.dart';
import 'package:peron_project/core/utils/property_model.dart';
import 'package:peron_project/features/main/presentation/manager/get%20Search/get_search_cubit.dart';
import 'package:peron_project/features/main/presentation/manager/get%20Search/get_search_state.dart';

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
                  ],
                ),
              ),
              SizedBox(height: 12),
              Directionality(
                textDirection: TextDirection.rtl,
                child: SizedBox(
                  height: 180,
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
      imagePath: property.images != null && property.images!.isNotEmpty
          ? property.images![0]
          : "",
      propertyType: property.rentType ??
          "غير محدد",
      location: property.location ?? "موقع غير محدد",
      price: property.price != null ? property.price.toString() : "سعر غير محدد",
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
    String? imagePath,
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
                    child: imagePath != null
                        ? Image.network(
                            imagePath,
                            height: 90,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 90,
                                width: double.infinity,
                                color: Colors.grey[300],
                                child: Icon(Icons.broken_image),
                              );
                            },
                          )
                        : Container(
                            height: 90,
                            width: double.infinity,
                            color: Colors.grey[300],
                            child: Icon(Icons.image_not_supported),
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
