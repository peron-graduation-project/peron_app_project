import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/images.dart';
import 'package:peron_project/core/navigator/page_routes_name.dart';
import 'package:peron_project/core/widgets/custom_button.dart';

class AfterExitScreen extends StatelessWidget {
  const AfterExitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var heightScreen=MediaQuery.of(context).size.height;
    var widthScreen=MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        height: heightScreen,
        width:widthScreen,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Images.sign,
            ),
             SizedBox(height: heightScreen*0.07),
            CustomButton(
              textColor: AppColors.primaryColor,
              text: 'تسجيل دخول',
              backgroundColor: Colors.white,
              side: BorderSide(
                  color: AppColors.primaryColor
              ),
              onPressed: (){
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  PageRouteName.login,
                      (route) => false,
                );
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              textColor: Colors.white,
              onPressed: (){
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  PageRouteName.signup,
                      (route) => false,
                );
              },
              text: 'إنشاء حساب ',
              backgroundColor: AppColors.primaryColor,
            ),

          ],
        ),
      ),
    );
  }
}
