import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/features/main/data/models/recommended_property.dart';
import 'package:peron_project/features/main/presentation/manager/get%20Search/get_search_cubit.dart';
import 'package:peron_project/features/main/presentation/manager/get%20Search/get_search_state.dart';
import 'package:peron_project/features/main/presentation/manager/get%20recommended/get_recommended_properties_cubit.dart';
import 'package:peron_project/features/main/presentation/manager/get%20recommended/get_recommended_properties_state.dart';
import 'package:peron_project/features/main/presentation/view/widgets/most_rent_property_card.dart';

import '../../manager/get highest price/get_highest_price_properties_cubit.dart';
import '../../manager/get highest price/get_highest_price_properties_state.dart';

import '../../manager/get lowest price/get_lowest_price_cubit.dart';
import '../../manager/get lowest price/get_lowest_price_state.dart';
import '../../manager/get most area/get_most_area_cubit.dart';
import '../../manager/get most area/get_most_area_state.dart';
import '../../manager/sort button/sort_button_cubit.dart';
import '../../manager/sort button/sort_button_state.dart';

class MostRentPropertyWidget extends StatelessWidget {
  const MostRentPropertyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SortCubit, SortState>(
      builder: (context, sortState) {
        final selectedSort = sortState is SortStateInitial
            ? sortState.selectedSort
            : (sortState as SortStateUpdated).selectedSort;

        return BlocBuilder<GetSearchPropertiesCubit, GetSearchPropertiesState>(
          builder: (context, searchState) {
            final isSearchActive = searchState is GetSearchPropertiesStateSuccess && searchState.properties.isNotEmpty;

            if (isSearchActive) {
              final properties = searchState.properties;
              return _buildHorizontalPropertyList(
                context,
                properties.map((p) => RecommendedProperty.fromProperty(p)).toList(),
              );
            }

            if (searchState is GetSearchPropertiesStateEmpty) {
              context.read<GetSearchPropertiesCubit>().clearSearch();
            }
            if (selectedSort == "الأعلى سعرا") {
              return BlocBuilder<GetHighestPricePropertiesCubit, GetHighestPricePropertiesState>(
                builder: (context, state) {
                  if (state is GetHighestPricePropertiesStateLoading) {
                    return Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
                  } else if (state is GetHighestPricePropertiesStateSuccess) {
                    return _buildHorizontalPropertyList(context, state.properties);
                  } else {
                    return const Center(child: Text('لا توجد عقارات متاحة.'));
                  }
                },
              );
            } else if (selectedSort == "الأقل سعرا") {
              return BlocBuilder<GetLowestPricePropertiesCubit, GetLowestPricePropertiesState>(
                builder: (context, state) {
                  if (state is GetLowestPricePropertiesStateLoading) {
                    return Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
                  } else if (state is GetLowestPricePropertiesStateSuccess) {
                    return _buildHorizontalPropertyList(context, state.properties);
                  } else {
                    return const Center(child: Text('لا توجد عقارات متاحة.'));
                  }
                },
              );
            } else if (selectedSort == "الأكثر مساحة") {
              return BlocBuilder<GetMostAreaCubit, GetMostAreaState>(
                builder: (context, state) {
                  if (state is GetMostAreaStateLoading) {
                    return Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
                  } else if (state is GetMostAreaStateSuccess) {
                    return _buildHorizontalPropertyList(context, state.properties);
                  } else {
                    return const Center(child: Text('لا توجد عقارات متاحة.'));
                  }
                },
              );
            } else {
              return BlocBuilder<GetRecommendedPropertiesCubit, GetRecommendedPropertiesState>(
                builder: (context, state) {
                  if (state is GetRecommendedPropertiesStateLoading) {
                    return Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
                  }
                  else if (state is GetRecommendedPropertiesStateSuccess) {

                    return _buildHorizontalPropertyList(context, state.properties);
                  }
                  else if (state is GetRecommendedPropertiesStateFailure) {
                    return Center(
                      child: const Text('فشل في تحميل العقارات.', style: TextStyle(fontSize: 16)),
                    );
                  }
                  else {
                    return const Center(child: Text('لا توجد عقارات متاحة.'));
                  }
                },
              );
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