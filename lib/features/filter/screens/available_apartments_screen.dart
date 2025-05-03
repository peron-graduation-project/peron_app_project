import 'package:flutter/material.dart';
import 'package:peron_project/core/widgets/custom_arrow_back.dart';
import 'package:peron_project/features/filter/models/property_model.dart';
import 'package:peron_project/features/filter/widgets/property_card.dart';
import 'package:peron_project/features/main/presentation/view/widgets/search_bar.dart';
//import 'package:peron_project/screens/property_details_screen.dart';  //   التفاصيل

class PropertiesScreen extends StatelessWidget {
  final List<PropertyModel> filteredProperties;

  const PropertiesScreen({super.key, required this.filteredProperties});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  children: [
                    const CustomArrowBack(),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'الشقق',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: CustomSearchBar(),
              ),
              const SizedBox(height: 16),

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
                                  SizedBox(height: 100),
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
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (_) => PropertyDetailsScreen(property: property),
                              //   ),
                              // );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
