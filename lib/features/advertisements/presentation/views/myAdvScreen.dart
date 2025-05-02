import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peron_project/core/helper/fonts.dart';
import 'package:peron_project/core/network/api_service.dart';
import 'package:peron_project/features/advertisements/presentation/views/add_property_screen.dart';
import 'package:peron_project/features/advertisements/presentation/widgets/no_published.dart';
import 'package:peron_project/features/advertisements/presentation/widgets/property_card.dart';
import 'package:peron_project/features/advertisements/presentation/widgets/tab_item.dart';
import 'package:peron_project/features/detailsAboutProperty/domain/repos/get%20property/get_property_repo_imp.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/manager/get%20property/get_property_cubit.dart';

class MyAdvertisementsPage extends StatefulWidget {
  final int initialPublishedCount;

  const MyAdvertisementsPage({
    super.key,
    this.initialPublishedCount = 0,
  });

  @override
  State<MyAdvertisementsPage> createState() => _MyAdvertisementsPageState();
}

class _MyAdvertisementsPageState extends State<MyAdvertisementsPage> {
  int _selectedTabIndex = 0;

  late int publishedAdsCount;
  int pendingAdsCount = 0;
  int deletedAdsCount = 0;

  final List<Map<String, dynamic>> property = [
    {
      "id": 1,
      "price": "200",
      "image": "assets/images/appartment4.jpg",
      "title": "شقه سكنيه شارع قناة السويس",
      "rating": 5,
      "location": "شارع قناه السويس بجانب مشاوي المحمدي.",
      "rooms": 3,
      "bathrooms": 3,
      "area": 130,
      "beds": 6,
    },
  ];

  @override
  void initState() {
    super.initState();
    publishedAdsCount =
        widget.initialPublishedCount;
  }

  void _navigateToAddPropertyScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddPropertyScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery
        .of(context)
        .size;
    final isSmallScreen = screenSize.width < 360;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'اعلاناتي',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
            fontFamily: Fonts.primaryFontFamily,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(height: 0.5, color: Colors.grey),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12),
            child: GestureDetector(
              // Changed onTap to use the navigation function
              onTap: _navigateToAddPropertyScreen,
              child: Container(
                height: 40,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F8E65),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 4.0,
                        top: 4,
                        bottom: 4,
                      ),
                      child: Text(
                        "أضف",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: Fonts.primaryFontFamily,
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: SvgPicture.asset(
                        width: 25,
                        height: 25,
                        "assets/icons/addHome.svg",
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],

        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TabItem(
                  title: '($publishedAdsCount)منشور',
                  index: 0,
                  selectedIndex: _selectedTabIndex,
                  onTap: (index) {
                    setState(() {
                      _selectedTabIndex = index;
                    });
                  },
                ),
                TabItem(
                  title: '($pendingAdsCount)معلق',
                  index: 1,
                  selectedIndex: _selectedTabIndex,
                  onTap: (index) {
                    setState(() {
                      _selectedTabIndex = index;
                    });
                  },
                ),
                TabItem(
                  title: '($deletedAdsCount)محذوف',
                  index: 2,
                  selectedIndex: _selectedTabIndex,
                  onTap: (index) {
                    setState(() {
                      _selectedTabIndex = index;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(child: _getContentByTabIndex()),
          ),
        ],
      ),
    );
  }

  Widget _getContentByTabIndex() {
    switch (_selectedTabIndex) {
      case 0:
        return Center(
            child:
          publishedAdsCount > 0
              ?  BlocProvider(
            create: (context) => GetPropertyCubit(GetPropertyRepoImp(ApiService(Dio()))),
            child: PropertyCard(),
          )
              : NoPublishedAdsContent(
                onAddProperty:
                    _navigateToAddPropertyScreen,
              ),
        );
      case 1:
        return const SizedBox();
      case 2:
        return const SizedBox();
      default:
        return const SizedBox();
    }
  }
}
