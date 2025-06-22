import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/colors.dart';

import '../screens/filter_screen.dart';

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
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                hintText: "ابحث عن اسم المنطقة او المكان",
                hintStyle: TextStyle(
                  fontFamily: 'Tajawal', // الخط المطلوب
                  fontWeight: FontWeight.w500, // الوزن 500
                  fontSize: 14, // الحجم 14px
                  height: 1.0, // line-height 100%
                  letterSpacing: 0, // letter-spacing 0%
                  color: Color(0xff818181), // اللون
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          VerticalDivider(color: Colors.grey.shade400, thickness: 1, width: 20, indent: 10, endIndent: 10),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              // الانتقال إلى شاشة الفلتر عند الضغط على الأيقونة
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FilterScreen(), // الانتقال إلى شاشة الفلتر
                ),
              );
            },
            icon: Icon(Icons.tune_outlined, color: AppColors.primaryColor, size: 25),
          ),
        ],
      ),
    );
  }
}
