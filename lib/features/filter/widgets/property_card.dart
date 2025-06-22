import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/fonts.dart';
import 'package:peron_project/features/filter/models/property_model.dart';

class PropertyCard extends StatelessWidget {
  final PropertyModel property;
  final VoidCallback onTap;

  const PropertyCard({super.key, required this.property, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: 180,
                  child: PageView.builder(
                    itemCount: property.images?.length ?? 0,
                    itemBuilder: (context, index) {
                      return CachedNetworkImage(
                        imageUrl: property.images![index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 180,
                        placeholder:
                            (context, url) => Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              ),
                            ),
                        errorWidget:
                            (context, url, error) => const Icon(Icons.error),
                      );
                    },
                  ),
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
                          property.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                            fontFamily: Fonts.primaryFontFamily,
                          ),
                        ),
                      ),
                      Text(
                        '${property.price} ج.م',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 22,
                          fontFamily: Fonts.primaryFontFamily,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Color(0xFF0F8E65),
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          property.location,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 69, 69, 69),
                            fontSize: 15,
                            fontWeight: FontWeight.w100,
                            fontFamily: Fonts.primaryFontFamily,
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
                      buildPropertyInfoRow(Icons.chair, property.bedrooms),
                      buildPropertyInfoRow(Icons.bathtub, property.bathrooms),
                      if (property.area != null)
                        buildPropertyInfoRow(Icons.square_foot, property.area!),
                      const Spacer(),
                      Text(
                        'نُشرت في: ${property.publishedDateFormatted}',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 171, 171, 171),
                          fontSize: 12,
                          fontWeight: FontWeight.w100,
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

  Widget buildPropertyInfoRow(IconData icon, int value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color.fromARGB(255, 195, 194, 194)),
        const SizedBox(width: 2),
        Text(
          "$value",
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w100,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
