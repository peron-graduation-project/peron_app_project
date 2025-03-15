import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:peron_project/features/main/presentation/view/widgets/most_rent_property_card.dart';

import '../../../../main/presentation/view/widgets/favorite_manager.dart';

class FavouriteViewBody extends StatelessWidget {
  const FavouriteViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "المفضلة",
          style: theme.headlineMedium!.copyWith(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Consumer<FavoriteManager>(
        builder: (context, favoriteManager, child) {
          final favoriteProperties = favoriteManager.mostRentFavorites; 

          return Column(
            children: [
              const Divider(thickness: 1, indent: 8, endIndent: 8), 
              Expanded(
                child: favoriteProperties.isEmpty
                    ? Center(
                        child: Text(
                          "لا توجد عقارات مفضلة حتى الآن",
                          style: theme.bodyLarge,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 6.0,
                            mainAxisSpacing: 1.0,
                            childAspectRatio: 0.55,
                          ),
                          itemCount: favoriteProperties.length,
                          itemBuilder: (context, index) {
                            final property = favoriteProperties[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: MostRentPropertyCard(property: property),
                            );
                          },
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}