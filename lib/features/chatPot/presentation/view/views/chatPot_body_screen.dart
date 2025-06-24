import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/network/api_service.dart';
import 'package:peron_project/core/widgets/custom_arrow_back.dart';
import 'package:peron_project/features/chatPot/domain/repos/get%20chatPot/get_chatpot_repo_imp.dart';
import 'package:peron_project/features/chatPot/presentation/view/views/chatPot_view_screen.dart';

import '../../manager/chatPot_cubit.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: CustomArrowBack(),
          title: Text(
            "مساعد بيرون",
            style: theme.headlineMedium!.copyWith(fontSize: screenWidth * 0.05),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04, vertical: screenHeight * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.04),
                  SvgPicture.asset(
                    "assets/icons/icons8-chatgpt.svg",
                    color: AppColors.primaryColor,
                    height: screenHeight * 0.15,
                    width: screenWidth * 0.3,
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Text(
                    'مرحباً بك في  ',
                    style: TextStyle(
                      fontSize: screenWidth * 0.065,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    ' مساعد بيرون  ',
                    style: TextStyle(
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Text(
                    'ابدأ المحادثة الآن مع المساعد ويمكنك    ',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: screenWidth * 0.045, color: Colors.grey),
                  ),
                  Text(
                    '   الاستفسار عن أى شيء    ',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: screenWidth * 0.045, color: Colors.grey),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  SizedBox(
                    width: screenWidth * 0.85,
                    height: screenHeight * 0.06,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(screenWidth * 0.02),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider(
                              create: (_) => ChatBotCubit(GetChatBotRepoImpl(ApiService(Dio()))),
                              child: ChatpotViewScreen(),
                            ),
                          ),
                        );

                      },
                      child: Text(
                        'ابدأ الآن',
                        style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.045),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
