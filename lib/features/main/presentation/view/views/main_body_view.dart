import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../map/domain/repos/get nearest/get_nearest_repo_imp.dart';
import '../../../../map/presentation/manager/get_nearest_cubit.dart';
import '../widgets/location_notification_header .dart';
import '../widgets/most_rent_property_widget.dart';
import '../widgets/recommended_property_widget.dart';
import '../widgets/search_bar.dart';
import '../widgets/section_title.dart';

class MainBodyView extends StatelessWidget {
  const MainBodyView({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: MediaQuery.of(context).size.height * 0.02,
          ),
          child: ListView(
            children: [
              const LocationNotificationHeader(),
              const SizedBox(height: 20),
              CustomSearchBar(),
              const SizedBox(height: 20),
              const SectionTitle(title: "الأكثر ايجاراً"),
              MostRentPropertyWidget(),
              const SectionTitle(title: "موصى به لك",showViewAll: true, ),
              RecommendedPropertyWidget(),

            ],
          ),
        ),
      ),
          );
  }
}



