import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/features/main/data/models/recommended_property.dart';
import 'package:peron_project/features/main/presentation/view/widgets/recommend_property_card.dart';
import '../../manager/get recommended/get_recommended_properties_cubit.dart';
import '../../manager/get recommended/get_recommended_properties_state.dart';

class RecommendedPropertyWidget extends StatelessWidget {
  const RecommendedPropertyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetRecommendedPropertiesCubit, GetRecommendedPropertiesState>(
      builder: (context, state) {
        if (state is GetRecommendedPropertiesStateLoading) {
          return  Center(child: CircularProgressIndicator(
            backgroundColor: AppColors.primaryColor,
          ));
        } else if (state is GetRecommendedPropertiesStateSuccess) {
          final List<RecommendedProperty> properties = state.properties;
          return LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.maxWidth;
              final itemWidth = screenWidth > 600 ? screenWidth * 0.3 : screenWidth * 0.5;
              final itemHeight = itemWidth * 1.26;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                  height: itemHeight,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: properties.take(4).length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: itemWidth,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: RecommendedPropertyCard(property: properties[index]),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        } else if (state is GetRecommendedPropertiesStateFailure) {
          return Center(child: Text('حدث خطأ: ${state.errorMessage}'));
        } else {
          return const Center(child: Text('لا توجد بيانات موصى بها.'));
        }
      },
    );
  }
}