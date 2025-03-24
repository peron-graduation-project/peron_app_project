import 'package:flutter/material.dart';
import 'package:peron_project/core/navigator/page_routes_name.dart';
import 'package:peron_project/features/profile/presentation/view/view/profile_screen.dart';
import 'package:peron_project/features/profile/presentation/view/widgets/accountOption.dart';
import 'package:peron_project/features/profile/presentation/view/widgets/logOutButton.dart';
import 'package:peron_project/features/profile/presentation/view/widgets/profileSection.dart';

import 'settings_screen.dart';




class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("حسابي", style: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.w600)),
        
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(right: screenWidth*0.03),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, size: screenWidth*0.045),
            onPressed: () {},
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(thickness: 1.5),
            SizedBox(height: screenHeight * 0.01),
            ProfileSection(screenWidth: screenWidth, screenHeight: screenHeight),
            AccountOption(
              icon: Icons.person,
              title: "الملف الشخصي",
              screenWidth: screenWidth,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen())),
            ),
            AccountOption(
              icon: Icons.settings_outlined,
              title: "الإعدادات",
              screenWidth: screenWidth,
              onTap: () {
                Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Settings()),
                    );
              }
            ),
            AccountOption(
              icon: Icons.privacy_tip_outlined,
              title: "سياسة الخصوصية",
              screenWidth: screenWidth,
              onTap: () {
                  Navigator.pushNamed(
                    context,
                    PageRouteName.privacyPolicyScreen,
                  );
                },
            ),
            AccountOption(
              icon: Icons.list_alt_rounded,
              title: "إعلاناتي",
              screenWidth: screenWidth,
              onTap: () {}
            ),
            AccountOption(
              icon: Icons.share,
              title: "مشاركة التطبيق",
              screenWidth: screenWidth,
              onTap: (){}
            ),
            SizedBox(height: screenHeight * 0.011),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: LogoutButton(screenWidth: screenWidth),
            ),
          ],
        ),
      ),
    );
  }
}