import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/fonts.dart';
import 'package:peron_project/core/utils/property_model.dart';

class PropertyItem extends StatelessWidget {
  final Property property;
  const PropertyItem({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    const baseImageUrl = 'https://sakaniapi1.runasp.net';

    String _buildImageUrl(String rawPath) =>
        rawPath.startsWith('http') ? rawPath : baseImageUrl + rawPath;

    double _extractPrice() {
      if (property.price != null && property.price! > 0) {
        return property.price!;
      }
      try {
        final map = property.toJson();
        dynamic raw;
        if (map.containsKey('Price')) {
          raw = map['Price'];
        } else if (map.containsKey('price')) {
          raw = map['price'];
        }
        if (raw is num) return raw.toDouble();
        if (raw is String) return double.tryParse(raw) ?? 0.0;
      } catch (_) {}
      return 0.0;
    }

    final priceValue = _extractPrice();

    return Container(
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
            child: SizedBox(
              height: 180,
              width: double.infinity,
              child: PageView.builder(
                itemCount: property.images?.length ?? 0,
                itemBuilder: (context, index) {
                  final rawPath = property.images![index];
                  return CachedNetworkImage(
                    imageUrl: _buildImageUrl(rawPath),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 180,
                    placeholder: (c, u) => Center(
                      child: CircularProgressIndicator(color: AppColors.primaryColor),
                    ),
                    errorWidget: (c, u, e) => Icon(Icons.error, color: AppColors.primaryColor),
                  );
                },
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
                        property.title ?? "",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w200,
                          color: Colors.black,
                          fontFamily: Fonts.primaryFontFamily,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: Text(
                        property.price.toString(),
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
                        property.location ?? '',
                        style: TextStyle(
                          color: Color.fromARGB(255, 69, 69, 69),
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
                    buildPropertyInfoRow(Icons.chair, property.bedrooms ?? 0),
                    SizedBox(width: 10),
                    buildPropertyInfoRow(
                      Icons.bathtub,
                      property.bathrooms ?? 0,
                    ),
                    SizedBox(width: 10),
                    buildPropertyInfoRow(Icons.bed, property.bedrooms ?? 0),
                    SizedBox(width: 10),
                    buildPropertyInfoRow(Icons.swap_horiz, property.area ?? 0),
                    SizedBox(width: 10),
                    const Spacer(),
                    Text(
                      'نُشرت في: ${property.createdAt}',
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
    );
  }

  Widget buildPropertyInfoRow(IconData icon, int value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color.fromARGB(255, 195, 194, 194)),
        SizedBox(width: 2),
        Text(
          "$value",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w100,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
