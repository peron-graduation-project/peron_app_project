import 'package:flutter/material.dart';
import '../widgets/location_selector.dart';
import '../widgets/property_widget.dart';
import '../widgets/search_bar.dart';
import '../widgets/section_title.dart';

class MainBodyView extends StatelessWidget {
  const MainBodyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: MediaQuery.of(context).size.height * 0.02,
          ),
          child: ListView(
            children: [
              const LocationSelector(),
              const SizedBox(height: 20),
              CustomSearchBar(),
              const SizedBox(height: 20),
              const SectionTitle(title: "الأكثر ايجاراً"),
              PropertyWidget(),
              const SectionTitle(title: "موصى به لك", showViewAll: true),
               PropertyWidget(),
            ],
          ),
        ),
      ),
    );
  }
}




