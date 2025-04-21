import 'package:flutter/material.dart';
import 'package:peron_project/features/main/presentation/view/widgets/recommended_view.dart';
import 'package:peron_project/features/main/presentation/view/widgets/sort_button.dart';

import '../../../../../core/helper/colors.dart';

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
              : SortButton(),
        ],
      ),
    );
  }
}
