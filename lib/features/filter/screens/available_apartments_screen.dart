import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/utils/property_model.dart';
import 'package:peron_project/core/widgets/custom_arrow_back.dart';
import 'package:peron_project/core/network/api_service.dart';
import 'package:peron_project/features/detailsAboutProperty/domain/repos/get%20property/get_property_repo_imp.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/manager/get%20property/get_property_cubit.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/view/views/property_details.dart';
import 'package:peron_project/features/filter/widgets/property_card.dart';
import 'package:peron_project/features/main/presentation/view/widgets/search_bar.dart';

class PropertiesScreen extends StatelessWidget {
  final List<Property> filteredProperties;

  const PropertiesScreen({Key? key, required this.filteredProperties}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header with back arrow and title
            Padding(
              padding: EdgeInsets.only(top: sh * 0.04, right: 16, left: 16),
              child: Stack(
                children: [
                  const Align(
                    alignment: Alignment.centerRight,
                    child: CustomArrowBack(),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'الشقق',
                      style: TextStyle(
                        fontSize: sw * 0.06,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Divider
            Padding(
              padding: EdgeInsets.only(top: sh * 0.015),
              child: Container(
                height: 1,
                width: double.infinity,
                color: const Color(0xFFE1E1E1),
              ),
            ),

            // Search bar
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: CustomSearchBar(),
            ),

            // List of properties
            Expanded(
              child: filteredProperties.isEmpty
                  ? LayoutBuilder(
                      builder: (context, constraints) {
                        final width = constraints.maxWidth;
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 100),
                                Text(
                                  'لا توجد شقق متاحة',
                                  style: TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontWeight: FontWeight.w500,
                                    fontSize: width * 0.08,
                                    height: 1.2,
                                    color: const Color(0xFF282929),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : ListView.builder(
                      itemCount: filteredProperties.length,
                      itemBuilder: (ctx, index) {
                        final property = filteredProperties[index];
                        return PropertyCard(
                          property: property,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider(
                                  create: (_) => GetPropertyCubit(
                                    GetPropertyRepoImp(ApiService(Dio())),
                                  )..getPropertyDetails(id: property.propertyId!),
                                  child: PropertyDetailScreen(
                                    propertyId: property.propertyId!,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
