import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/colors.dart';

class AnimatedBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const AnimatedBottomNavBar({super.key, required this.selectedIndex, required this.onItemSelected});

  final List<IconData> iconList = const [
    Icons.home,
    Icons.favorite,
    Icons.chat,
    Icons.person,
  ];

  final List<String> labels = const ["الرئيسية", "المفضلة", "الدردشات", "الحساب"];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double iconSize = screenWidth * 0.07;
    double fontSize = screenWidth * 0.03;
    double height = screenWidth * 0.18;

    return AnimatedBottomNavigationBar.builder(
      itemCount: iconList.length,
      tabBuilder: (int index, bool isActive) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconList[index],
              size: isActive ? iconSize * 1.2 : iconSize,
              color: isActive ? Colors.white : Colors.white70,
            ),
            const SizedBox(height: 4),
            Text(
              labels[index],
              style: TextStyle(
                fontSize: isActive ? fontSize * 1.1 : fontSize,
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.white : Colors.white70,
              ),
            ),
          ],
        );
      },
      activeIndex: selectedIndex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.smoothEdge,
      backgroundColor: AppColors.primaryColor,
      height: height.clamp(60, 85),
      onTap: onItemSelected,
      leftCornerRadius: 8,
      rightCornerRadius: 8,
    );
  }
}
