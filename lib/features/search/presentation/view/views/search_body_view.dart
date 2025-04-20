import 'package:flutter/material.dart';
import 'package:peron_project/features/main/presentation/view/widgets/location_selector.dart';

import '../../../../main/presentation/view/widgets/search_bar.dart';

class SearchBodyView extends StatelessWidget {
  const SearchBodyView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CustomSearchBar(),
        LocationSelector(
          isShown: false,
        ),
      ],
    );
  }
}
