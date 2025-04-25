import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/features/main/presentation/manager/get%20lowest%20price/get_lowest_price_cubit.dart';
import 'package:peron_project/features/main/presentation/view/widgets/recommended_view.dart';
import 'package:peron_project/features/main/presentation/view/widgets/sort_button.dart';

import '../../../../../core/helper/colors.dart';
import '../../manager/get highest price/get_highest_price_properties_cubit.dart';
import '../../manager/get most area/get_most_area_cubit.dart';
import '../../manager/get recommended/get_recommended_properties_cubit.dart';
import '../../manager/sort button/sort_button_cubit.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final bool showViewAll;

  const SectionTitle({
    super.key,
    required this.title,
    this.showViewAll = false,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GetRecommendedPropertiesCubit>().getRecommendedProperties();
    });

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.03,
        vertical: screenHeight * 0.01,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: theme.labelLarge!.copyWith(
              color: Color(0xff282929),
              fontSize: screenWidth > 600 ? 20 : 16,
            ),
          ),
          showViewAll
              ? GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecommendedViewBody()),
              );
            },
            child: Text(
              "عرض الكل",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: screenWidth > 600 ? 16 : 14,
              ),
            ),
          )
              : SortButton(
            onSelected: (selectedSort) async {
              context.read<SortCubit>().updateSort(selectedSort);

              if (selectedSort == "الأعلى سعرا") {
                await context.read<GetHighestPricePropertiesCubit>().getHighestPriceProperties();
              } else if (selectedSort == "الأقل سعرا") {
                await context.read<GetLowestPricePropertiesCubit>().getLowestPriceProperties();
              } else if (selectedSort == "الأكثر مساحة") {
                await context.read<GetMostAreaCubit>().getMostArea();
              } else if (selectedSort == "الأكثر تقييما") {
                await context.read<GetRecommendedPropertiesCubit>().getRecommendedProperties();
              }
            },
          ),

        ],
      ),
    );
  }
}
