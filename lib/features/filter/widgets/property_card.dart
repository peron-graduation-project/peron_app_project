import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/fonts.dart';
import 'package:peron_project/core/utils/property_model.dart';

class PropertyCard extends StatelessWidget {
  final Property property;
  final VoidCallback onTap;

  const PropertyCard({
    Key? key,
    required this.property,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFmt = property.createdAt != null
        ? DateFormat('dd/MM/yyyy').format(property.createdAt!)
        : '-';

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
            if (property.images != null && property.images!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    height: 180,
                    child: PageView.builder(
                      itemCount: property.images!.length,
                      itemBuilder: (context, index) {
                        final rawUrl = property.images![index];
                        final path = rawUrl.startsWith('/') ? rawUrl : '/$rawUrl';
                        final imageUrl = rawUrl.startsWith('http')
                            ? rawUrl
                            : 'https://sakaniapi1.runasp.net$path';

                        return CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 180,
                          placeholder: (ctx, url) => Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          errorWidget: (ctx, url, error) => const Icon(Icons.broken_image, size: 48),
                        );
                      },
                    ),
                  ),
                ),
              )
            else
              Container(
                height: 180,
                alignment: Alignment.center,
                child: const Icon(Icons.photo, size: 64, color: Colors.grey),
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
                          property.title ?? '-',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                            fontFamily: Fonts.primaryFontFamily,
                          ),
                        ),
                      ),
                      Text(
                        '${property.price?.toStringAsFixed(0) ?? '-'} ج.م',
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

                  // الموقع
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Color(0xFF0F8E65), size: 16),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          property.location ?? '-',
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
                    children: [
                      _buildInfo(Icons.chair, property.bedrooms ?? 0),
                      const SizedBox(width: 10),
                      _buildInfo(Icons.bathtub, property.bathrooms ?? 0),
                      const SizedBox(width: 10),
                      if (property.area != null) _buildInfo(Icons.square_foot, property.area!),
                      const Spacer(),
                      Text(
                        'نُشرت في: $dateFmt',
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

  Widget _buildInfo(IconData icon, int val) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color.fromARGB(255, 195, 194, 194)),
        const SizedBox(width: 2),
        Text(
          '$val',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w100, color: Colors.grey),
        ),
      ],
    );
  }
}
