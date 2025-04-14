import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/core/navigator/page_routes_name.dart';
import 'package:peron_project/core/network/api_service.dart';
import 'package:peron_project/core/widgets/custom_button.dart';
import 'package:peron_project/features/authentication/presentation/manager/logout/logout_cubit.dart';
import 'package:peron_project/features/profile/presentation/view/view/profile_screen.dart';
import 'package:peron_project/features/profile/presentation/view/widgets/accountOption.dart';
import 'package:peron_project/features/profile/presentation/view/widgets/profileSection.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../core/helper/colors.dart';
import '../../../../authentication/data/repos/logout/logout_repo_imp.dart';
import '../../../../authentication/presentation/manager/logout/logout_state.dart';
import 'settings_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => LogoutCubit(LogoutRepoImp(ApiService(Dio()))),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "حسابي",
            style: theme.headlineMedium!.copyWith(fontSize: 20),
          ),
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
          padding: const EdgeInsets.only(top: 16.0),
          child: ListView(
            children: [
              ProfileSection(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              AccountOption(
                icon: Icons.person,
                title: "الملف الشخصي",
                screenWidth: screenWidth,
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ProfileScreen()),
                    ),
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
                },
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
                onTap: () {},
              ),
              AccountOption(
                icon: Icons.library_books,
                title: "حجوزاتي",
                screenWidth: screenWidth,
                onTap: () {},
              ),
              AccountOption(
                icon: Icons.share,
                title: "مشاركة التطبيق",
                screenWidth: screenWidth,
                onTap: () async{
    String appLink = "";
    if (Platform.isAndroid) {
    appLink = "https://play.google.com/store/apps/details?id=com.example.your_app_id";
    } else if (Platform.isIOS) {
    appLink = "https://apps.apple.com/app/your-app-name/idYOUR_APP_ID";
    }

    if (appLink.isNotEmpty) {
    await Share.share('Check out my awesome app! $appLink');
    } else {
     print('App link not available for this platform.');
    }
    },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 17.0, right: 17, top: 6),
                child: BlocConsumer<LogoutCubit, LogoutState>(
                  listener: (context, state) {
                    if (state is LogoutSuccess) {
                      Navigator.of(
                        context,
                      ).pushNamedAndRemoveUntil(PageRouteName.afterExit, (route) => false);
                    } else if (state is LogoutFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.errorMessage),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                      isLoading: state is LogoutLoading,
                      textColor: Colors.white,
                      text: 'تسجيل الخروج',
                      backgroundColor: AppColors.primaryColor,
                      onPressed:
                          state is LogoutLoading
                              ? null
                              : () {
                                context.read<LogoutCubit>().logout();
                              },
                    );
                  },
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
