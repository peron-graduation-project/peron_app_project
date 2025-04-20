import 'package:flutter/material.dart';

import '../../../../../core/helper/colors.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

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
              cursorColor: AppColors.primaryColor,
              onTap: (){
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                hintText: "ابحث عن اسم المنطقة او المكان",
                hintStyle: theme.displayMedium!.copyWith(color: Color(0xff818181)),
                border: InputBorder.none,
              ),
            ),
          ),
          VerticalDivider(color: Colors.grey.shade400, thickness: 1, width: 20, indent: 10, endIndent: 10),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            icon: Icon(Icons.tune_outlined, color: AppColors.primaryColor, size: 25),
          ),
        ],
      ),
    );
  }
}
