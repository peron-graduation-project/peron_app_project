import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/widgets/custom_arrow_back.dart';
import 'package:peron_project/features/main/presentation/manager/get%20recommended/get_recommended_properties_cubit.dart';
import 'package:peron_project/features/main/presentation/view/widgets/recommend_property_card.dart';

import '../../manager/get recommended/get_recommended_properties_state.dart';

class RecommendedViewBody extends StatelessWidget {
  const RecommendedViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: const CustomArrowBack(),
        title: Text("موصى به لك", style: theme.headlineMedium!.copyWith(fontSize: 20)),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(
            thickness: 1,
            height: 1,
            color: AppColors.dividerColor,
          ),
        ),
      ),
      body: BlocBuilder<GetRecommendedPropertiesCubit, GetRecommendedPropertiesState>(
        builder: (context, state) {
          if (state is GetRecommendedPropertiesStateLoading) {
            return  Center(child: CircularProgressIndicator(
              backgroundColor: AppColors.primaryColor,
            ));
          } else if (state is GetRecommendedPropertiesStateSuccess) {
            final recommendedProperties = state.properties;
            return GridView.builder(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.02,
                  vertical: 10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: screenWidth > 600 ? 3 : 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemCount: recommendedProperties.length,
              itemBuilder: (context, index) {
                final property = recommendedProperties[index];
                return RecommendedPropertyCard(property: property);
              },
            );
          } else if (state is GetRecommendedPropertiesStateFailure) {
            return Center(child: Text("حدث خطأ أثناء تحميل العقارات الموصى بها: ${state.errorMessage}"));
          } else {
            return Center(child: CircularProgressIndicator(
              backgroundColor: AppColors.primaryColor,
            ));
          }
        },
      ),
    );
  }
}