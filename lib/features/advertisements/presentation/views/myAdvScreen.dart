import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peron_project/core/helper/fonts.dart';
import 'package:peron_project/features/advertisements/presentation/manager/propert_create/property_create_cubit.dart';
import 'package:peron_project/features/advertisements/presentation/views/add_property_screen.dart';
import 'package:peron_project/features/advertisements/presentation/widgets/property_card.dart';
import 'package:peron_project/features/advertisements/presentation/widgets/tab_item.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/manager/get%20property/get_property_cubit.dart';
import 'package:peron_project/features/detailsAboutProperty/presentation/manager/get%20property/get_property_state.dart';

import '../../../../core/helper/colors.dart';
import '../../../../core/utils/property_model.dart';
import '../../../../core/widgets/custom_arrow_back.dart';
import '../widgets/deleted_property_card.dart';
import '../widgets/no_published.dart';

class MyAdvertisementsPage extends StatefulWidget {
  final int? initialPublishedCount;
  final int? currentSelectedIndex;

  const MyAdvertisementsPage({
    super.key,
    this.initialPublishedCount,
    this.currentSelectedIndex,
  });

  @override
  State<MyAdvertisementsPage> createState() => _MyAdvertisementsPageState();
}
class _MyAdvertisementsPageState extends State<MyAdvertisementsPage> {
  late int _selectedTabIndex;

  // late int publishedAdsCount;
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
  @override
  void initState() {
    super.initState();

    _selectedTabIndex = widget.currentSelectedIndex ?? 0;
    pendingAdsCount = _selectedTabIndex == 0 ? 0 : 1;

    context.read<GetPropertyCubit>().getProperties(
      index: _selectedTabIndex,
      id: context.read<PropertyCreateCubit>().getId,
    );
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
    var theme = Theme
        .of(context)
        .textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "إعلاناتى",
          style: theme.headlineMedium!.copyWith(fontSize: 20),
        ),
        centerTitle: true,
        leading: CustomArrowBack(
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(
            thickness: 1,
            height: 1,
            color: AppColors.dividerColor,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12),
            child: GestureDetector(
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
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: BlocBuilder<GetPropertyCubit, GetPropertyState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TabItem(
                      title: "منشور",
                      length: context.watch<GetPropertyCubit>().getPropertiesLengthByIndex(0),
                      index: 0,
                      selectedIndex: _selectedTabIndex,
                      onTap: (index) {
                        setState(() {
                          _selectedTabIndex = index;
                          if (context.read<GetPropertyCubit>().publishedProperties.isEmpty) {
                            context.read<GetPropertyCubit>().getProperties(
                              index: index,
                              id: context.read<PropertyCreateCubit>().getId,
                            );
                          } else {
                            context.read<GetPropertyCubit>().emit(
                              GetPropertyStateSuccess(
                                properties: context.read<GetPropertyCubit>().publishedProperties,
                              ),
                            );
                          }
                        });
                      },
                    ),
                    TabItem(
                      title: "معلق",
                      length: context.watch<GetPropertyCubit>().getPropertiesLengthByIndex(1),
                      index: 1,
                      selectedIndex: _selectedTabIndex,
                      onTap: (index) {
                        setState(() {
                          _selectedTabIndex = index;
                          context.read<GetPropertyCubit>().getProperties(
                            index: index,
                            id: context.read<PropertyCreateCubit>().getId,
                          );
                        });
                      },
                    ),
                    TabItem(
                      title: "محذوف",
                      length: context.watch<GetPropertyCubit>().getPropertiesLengthByIndex(2),
                      index: 2,
                      selectedIndex: _selectedTabIndex,
                      onTap: (index) {
                        setState(() {
                          _selectedTabIndex = index;
                          context.read<GetPropertyCubit>().getProperties(
                            index: index,
                            id: context.read<PropertyCreateCubit>().getId,
                          );
                        });
                      },
                    ),
                  ],
                );
              },
            ),

          ),
          Expanded(child: _getContentByTabIndex()),
          // Expanded(
          //   child: SingleChildScrollView(child: _getContentByTabIndex()),
          // ),
        ],
      ),
    );
  }

  Widget _getContentByTabIndex() {
    return BlocBuilder<GetPropertyCubit, GetPropertyState>(
      builder: (context, state) {
        if (state is GetPropertyStateLoading) {
          return Center(child: CircularProgressIndicator(
            color: AppColors.primaryColor,
          ));
        } else if (state is GetPropertyStateSuccess) {
          final List<Property>? properties = state.properties??[];

          if (_selectedTabIndex == 0) {
            if (properties?.isEmpty ?? true) {
              return const NoPublishedAdsContent();
            } else {
              return PropertyCard();
            }
          } else if (_selectedTabIndex == 1) {
            return PropertyCard();
          } else if (_selectedTabIndex == 2) {
            return DeletedPropertyCard();
          } else {
            return const SizedBox();
          }
        } else if (state is GetPropertyStateFailure) {
          return Center(child: Text('حدث خطأ أثناء تحميل البيانات'));
        }

        return const SizedBox(); // Default empty while waiting
      },
    );
  }

  }
