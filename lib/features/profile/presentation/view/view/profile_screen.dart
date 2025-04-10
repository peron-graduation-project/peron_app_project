import 'package:flutter/material.dart';
import 'package:peron_project/core/widgets/custom_arrow_back.dart';
import 'package:peron_project/features/profile/presentation/view/widgets/accountOption.dart';
import 'package:peron_project/features/profile/presentation/view/widgets/change_password_dialog.dart';
import 'package:peron_project/features/profile/presentation/view/widgets/profileSection.dart';

import '../../../../../core/helper/colors.dart';




class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var theme=Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "الملف الشخصي",
          style: theme.headlineMedium!.copyWith(fontSize: 20),
        ),
        centerTitle: true,
        leading: CustomArrowBack(),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(
            thickness: 1,
            height: 1,
            color: AppColors.dividerColor,
          ),
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          children: [
           ProfileSection(screenWidth: screenWidth, screenHeight: screenHeight) ,
            AccountOption(icon: Icons.person, title: "تاليا أنس", screenWidth: screenWidth,),
            AccountOption(icon: Icons.email_outlined, title: "talia155@gmail.com", screenWidth: screenWidth,),
            GestureDetector(
              onTap: () {
                showChangePasswordDialog(context);
              },
              child: AccountOption(icon: Icons.lock, title: 'تغير كلمة المرور', screenWidth: screenWidth)
            ),
          ],
        ),
      ),
    );
  }
}