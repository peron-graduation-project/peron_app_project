import 'package:flutter/material.dart';
import 'package:peron_project/core/widgets/custom_arrow_back.dart';
import 'package:peron_project/features/main/presentation/view/widgets/search_bar.dart';
import 'package:peron_project/features/search/presentation/view/views/search_body_view.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CustomArrowBack(),
            CustomSearchBar(),
          ],
        ),
      ),
      body: SearchBodyView(),
    );
  }
}
