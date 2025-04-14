import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/navigator/page_routes_name.dart';
import 'package:peron_project/core/network/api_service.dart';
import 'package:peron_project/core/widgets/custom_arrow_back.dart';
import 'package:peron_project/features/profile/domain/repos/delete%20account/delete_account_repo_imp.dart';
import 'package:peron_project/features/profile/presentation/manager/delete%20account/delete_account_cubit.dart';
import 'package:peron_project/features/profile/presentation/view/widgets/accountOption.dart';
import 'package:peron_project/features/profile/presentation/view/widgets/delete_account_dialog.dart';

import '../widgets/lang_selection_dialog.dart';
import '../widgets/rating_dialog.dart';
import 'about_us_screen.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "الاعدادات",
          style: theme.headlineMedium!.copyWith(fontSize: 20),
        ),
        leading: CustomArrowBack(),
        automaticallyImplyLeading: false,
        centerTitle: true,
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
        padding: EdgeInsets.only(top: 12),
        child: Column(
          children: [
            AccountOption(
              title: 'اللغة',
              icon: Icons.language,
              onTap: () {
                return showChangeLanguageDialog(context);
              },
              screenWidth: screenWidth,
            ),
            AccountOption(
              title: 'قم بتقييمنا',
              icon: Icons.star_border,
              onTap: () {
                return showRatingDialog(context);
              },
              screenWidth: screenWidth,
            ),
            AccountOption(
              title: 'من نحن',
              icon: Icons.info_outline,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUs()),
                );
              },
              screenWidth: screenWidth,
            ),
            AccountOption(
              title: 'تحتاج إلي المساعدة؟',
              icon: Icons.help_outline,
              onTap: () {
                Navigator.pushNamed(context, PageRouteName.helpScreen);
              },
              screenWidth: screenWidth,
            ),
            AccountOption(
              showArrow: false,
              textColor: Colors.red,
              iconColor: Colors.red,
              title: 'حذف الحساب',
              icon: Icons.delete_outline,
              onTap: () {
                showDeleteAccountDialog(context); // Pass this context
              },
              screenWidth: screenWidth,
            ),
          ],
        ),
      ),
    );
  }
}