import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/fonts.dart';
import 'package:peron_project/core/network/api_service.dart';
import 'package:peron_project/core/utils/property_model.dart';
import 'package:peron_project/features/myAds/domain/repos/edit%20property/edit_property_repo_imp.dart';
import 'package:peron_project/features/myAds/presentation/manager/update%20property/update_property_cubit.dart';
import 'package:peron_project/features/myAds/presentation/view/views/modifyProperty.dart';

class PropertyItem extends StatelessWidget {
  final Property property;
  const PropertyItem({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  SizedBox(
                    height: 180,
                    child: PageView.builder(
                      itemCount: property.images?.length,
                      onPageChanged: (index) {
                        // setState(() {
                        //   _currentImageIndex = index;
                        // });
                      },
                      itemBuilder: (context, index) {
                        print('hna property.images ${property.images?[index]}');
                        return CachedNetworkImage(
                          imageUrl: '${property.images?[index]}',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 180,
                          placeholder:
                              (context, url) =>  Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                          errorWidget:
                              (context, url, error) => const Icon(Icons.error),
                        );
                        //  Image.network(
                        //   property.images![index],
                        //   width: double.infinity,
                        //   height: 180,
                        //   fit: BoxFit.cover,
                        // );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => BlocProvider(
                                  create:
                                      (context) => UpdatePropertyCubit(
                                        UpdatePropertyRepoImp(
                                          ApiService(Dio()),
                                        ),
                                      ),
                                  child: EditPropertyScreen(property: property),
                                ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F8E65),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
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
