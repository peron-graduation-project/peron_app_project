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

class PropertiesScreen extends StatelessWidget {
  final List<Property> filteredProperties;

  const PropertiesScreen({super.key, required this.filteredProperties});

  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "الشقق",
          style: theme.headlineMedium!.copyWith(fontSize: 20),
        ),
        centerTitle: true,
        leading: CustomArrowBack(
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(
            thickness: 1,
            height: 1,
            color: AppColors.dividerColor,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
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
    );
  }
}
