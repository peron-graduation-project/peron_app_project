import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/utils/property_model.dart';
import 'package:peron_project/features/main/data/models/recommended_property.dart';
import 'package:peron_project/features/main/presentation/manager/get%20Search/get_search_cubit.dart';
import 'package:peron_project/features/main/presentation/manager/get%20Search/get_search_state.dart';
import 'package:peron_project/features/main/presentation/manager/get%20recommended/get_recommended_properties_cubit.dart';
import 'package:peron_project/features/main/presentation/manager/get%20recommended/get_recommended_properties_state.dart';
import 'package:peron_project/features/main/presentation/view/widgets/most_rent_property_card.dart';

class MostRentPropertyWidget extends StatelessWidget {
  const MostRentPropertyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSearchPropertiesCubit, GetSearchPropertiesState>(
      builder: (context, searchState) {
        
        if (searchState is GetSearchPropertiesStateSuccess) {
          final List<Property> properties = searchState.properties;
          if (properties.isEmpty) {
            return const Center(child: Text('لا توجد نتائج بحث.'));
          }

          return _buildHorizontalPropertyList(
            context,
            properties.map((p) => RecommendedProperty.fromProperty(p)).toList(),
          );
        }

        
        if (searchState is GetSearchPropertiesStateLoading) {
          return Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
        }

        return BlocBuilder<GetRecommendedPropertiesCubit, GetRecommendedPropertiesState>(
          builder: (context, state) {
            if (state is GetRecommendedPropertiesStateLoading) {
              return Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
            } else if (state is GetRecommendedPropertiesStateSuccess) {
              final List<RecommendedProperty> properties = state.properties;
              return _buildHorizontalPropertyList(context, properties);
            } else if (state is GetRecommendedPropertiesStateFailure) {
              return Center(child: Text('حدث خطأ: ${state.errorMessage}'));
            } else {
              return const Center(child: Text('لا توجد عقارات موصى بها.'));
            }
          },
        );
      },
    );
  }

  Widget _buildHorizontalPropertyList(BuildContext context, List<RecommendedProperty> properties) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final itemWidth = screenWidth > 600 ? screenWidth * 0.3 : screenWidth * 0.5;
        final itemHeight = itemWidth * 1.5;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SizedBox(
            height: itemHeight,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: properties.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: itemWidth,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: MostRentPropertyCard(property: properties[index]),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
