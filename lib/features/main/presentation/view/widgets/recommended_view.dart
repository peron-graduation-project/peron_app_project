import 'package:flutter/material.dart';
import 'package:peron_project/features/main/presentation/view/widgets/favorite_manager.dart';
import 'package:peron_project/features/main/presentation/view/widgets/recommend_property_card.dart';
import 'package:provider/provider.dart';
import 'package:peron_project/core/widgets/custom_arrow_back.dart';

class RecommendedViewBody extends StatelessWidget {
  const RecommendedViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: CustomArrowBack(),
        title: Text("موصى به لك", style: theme.headlineMedium!.copyWith(fontSize: 20)),
        centerTitle: true,
      ),
      body: Consumer<FavoriteManager>(
        builder: (context, favoriteManager, child) {
          final recommendedFavorites = favoriteManager.favorites;

          return recommendedFavorites.isEmpty
              ? Center(
            child: Text(
              "لا توجد عقارات مفضلة حتى الآن",
              style: theme.bodyMedium,
            ),
          )
              : Column(
            children: [
              const Divider(thickness: 1, indent: 10, endIndent: 10),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.02,
                      vertical: 10
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: screenWidth > 600 ? 3 : 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: recommendedFavorites.length,
                  itemBuilder: (context, index) {
                    final property = recommendedFavorites[index];
                    return RecommendedPropertyCard(property: property);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
