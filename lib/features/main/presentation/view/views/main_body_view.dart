import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/colors.dart';
import '../../../../chatPot/presentation/view/views/chatPot_body_screen.dart';
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
          child: Stack(
            children: [
              ListView(
                children: [
                  const LocationNotificationHeader(),
                  const SizedBox(height: 20),
                  CustomSearchBar(),
                  const SizedBox(height: 20),
                  const SectionTitle(title: "الأكثر تقييما"),
                  MostRentPropertyWidget(),
                  const SectionTitle(title: "موصى به لك", showViewAll: true),
                  RecommendedPropertyWidget(),
                ],
              ),

              Positioned(
                bottom: MediaQuery.of(context).size.height / 6 - 80,
                right:0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>WelcomeScreen ()),
                    );                  },
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.chat, color: Colors.white),
                  ),
                ),
              ),
            ],
          )

        ),
      ),
          );
  }
}



