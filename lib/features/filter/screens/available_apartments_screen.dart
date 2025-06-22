import 'package:flutter/material.dart';
import 'package:peron_project/core/widgets/custom_arrow_back.dart';
import 'package:peron_project/features/filter/models/property_model.dart';
import 'package:peron_project/features/filter/widgets/property_card.dart';
import 'package:peron_project/features/main/presentation/view/widgets/search_bar.dart';

class PropertiesScreen extends StatelessWidget {
  final List<PropertyModel> filteredProperties;

  const PropertiesScreen({super.key, required this.filteredProperties});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: sh * 0.04,
                right: 16,
                left: 16,
              ),
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: sh * 0.015),
              child: Container(
                height: 1,
                width: double.infinity,
                color: const Color(0xFFE1E1E1),
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: CustomSearchBar(),
            ),

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
