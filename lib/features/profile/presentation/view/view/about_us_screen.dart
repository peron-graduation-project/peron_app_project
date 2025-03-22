import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/colors.dart';

import '../widgets/about_item.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;
    
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04, 
                vertical: size.height * 0.015
              ),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey, width: 0.1),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "من نحن",
                      style: TextStyle(
                        fontSize: isSmallScreen ? 14 : 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.chevron_right,
                        size: isSmallScreen ? 20 : 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.04),
              child: Column(
                children: [
                  Container(
                    width: size.width * 0.25,
                    height: size.width * 0.25,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/peron.png',
                        width: size.width * 0.175,
                        height: size.width * 0.175,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.012),
                  Text(
                    "بيرون",
                    style: TextStyle(
                      fontSize: isSmallScreen ? 20 : 22,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: Column(
                children: [
                  AboutItem(title: "موقع الويب", onTap: () {}),
                  AboutItem(title: "فيسبوك", onTap: () {}),
                  AboutItem(title: "انستجرام", onTap: () {}),
                  AboutItem(title: "شروط الاستخدام", onTap: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
