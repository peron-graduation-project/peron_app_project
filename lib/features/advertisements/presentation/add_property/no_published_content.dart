import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peron_project/features/advertisements/presentation/widgets/no_published.dart';
import 'package:peron_project/features/advertisements/presentation/widgets/property_card.dart';
import 'package:peron_project/features/advertisements/presentation/widgets/tab_item.dart';

class MyAdvertisementsPage extends StatefulWidget {
  const MyAdvertisementsPage({Key? key}) : super(key: key);

  @override
  State<MyAdvertisementsPage> createState() => _MyAdvertisementsPageState();
}

class _MyAdvertisementsPageState extends State<MyAdvertisementsPage> {
  int _selectedTabIndex = 0;

  int publishedAdsCount = 0;
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

  void _addNewProperty() {
    setState(() {
      publishedAdsCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'اعلاناتي',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(height: 0.5, color: Colors.grey),
        ),
          actions: [

          GestureDetector(
            onTap: _addNewProperty,
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF0F8E65),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SvgPicture.asset(
                "assets/icons/addHome.svg",
                color: Colors.white,
              ),
            ),
          ),
        ],
      
        leading: IconButton(
          icon: const Icon(Icons.chevron_right, color: Colors.black),
          onPressed: () {},
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
                  title: '($deletedAdsCount)محذوف',
                  index: 2,
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
                  title: '($publishedAdsCount)منشور',
                  index: 0,
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
            child: SingleChildScrollView(
              child: _getContentByTabIndex(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getContentByTabIndex() {
    switch (_selectedTabIndex) {
      case 0: 
        return Center(
          child: publishedAdsCount > 0
              ? PropertyCard()
              : NoPublishedAdsContent(onAddProperty: _addNewProperty),
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
