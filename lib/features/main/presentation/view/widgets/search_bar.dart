
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/features/filter/screens/filter_screen.dart';
import 'package:peron_project/features/main/presentation/manager/get%20Search/get_search_cubit.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    final TextEditingController searchController = TextEditingController();

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
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  context.read<GetSearchPropertiesCubit>().getSearchProperties(value.trim());
                }

              },
              decoration: InputDecoration(
                prefixIcon: IconButton(onPressed: (){
                  if (searchController.text.trim().isNotEmpty) {
                    context.read<GetSearchPropertiesCubit>().getSearchProperties(searchController.text.trim());
                  }
                }, icon: Icon(Icons.search, color: Colors.grey)),
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
              }
               Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => FilterScreen()),
               );
            },
            icon: Icon(Icons.tune_outlined, color: AppColors.primaryColor, size: 25),
          ),
        ],
      ),
    );
  }
}
