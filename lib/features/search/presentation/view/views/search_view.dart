import 'package:flutter/material.dart';
import 'package:peron_project/core/widgets/custom_arrow_back.dart';
import 'package:peron_project/features/search/presentation/view/views/search_body_view.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: CustomArrowBack(),
        title: Text(
          "البحث",
          style: theme.headlineMedium!.copyWith(fontSize: 20),
        ),),
      body: SearchBodyView(),
    );
  }
}
