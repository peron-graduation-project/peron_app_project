import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/colors.dart';

import '../widgets/about_item.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                        fontSize: 16,
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
                      child: Icon(Icons.chevron_right),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/peron.png',
                        width: 70,
                        height: 70,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "بيرون",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
