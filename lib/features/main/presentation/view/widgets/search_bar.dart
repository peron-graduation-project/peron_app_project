import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helper/colors.dart';
import '../../../../filter/screens/filter_screen.dart';
import '../../manager/get Search/get_search_cubit.dart';
import '../../manager/get most area/get_most_area_cubit.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController searchController = TextEditingController();

  void _onSearchChanged(String value) {
    final trimmedValue = value.trim();
    if (trimmedValue.isNotEmpty) {
      context.read<GetSearchPropertiesCubit>().getSearchProperties(trimmedValue);
    } else {
      context.read<GetMostAreaCubit>().getMostArea();
  }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 5)],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              cursorColor: AppColors.primaryColor,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  onPressed: () {
                    final query = searchController.text.trim();
                    if (query.isNotEmpty) {
                      context.read<GetSearchPropertiesCubit>().getSearchProperties(query);
                    } else {
                      context.read<GetMostAreaCubit>().getMostArea();
                    }
                  },
                  icon: Icon(Icons.search, color: Colors.grey),
                ),
                hintText: "ابحث عن اسم المنطقة او المكان",
                hintStyle: theme.displayMedium!.copyWith(color: Color(0xff818181)),
                border: InputBorder.none,
              ),
            ),
          ),
          VerticalDivider(color: Colors.grey.shade400, thickness: 1, width: 20, indent: 10, endIndent: 10),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              final query = searchController.text.trim();
              if (query.isNotEmpty) {
                context.read<GetSearchPropertiesCubit>().getSearchProperties(query);
              } else {
                context.read<GetMostAreaCubit>().getMostArea();
              }
              Navigator.push(context, MaterialPageRoute(builder: (_) => FilterScreen()));
            },
            icon: Icon(Icons.tune_outlined, color: AppColors.primaryColor, size: 25),
          ),
        ],
      ),
    );
  }
}
