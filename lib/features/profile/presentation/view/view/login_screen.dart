import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peron_project/core/helper/images.dart';
import 'package:peron_project/features/profile/presentation/view/widgets/custom_elevated_button.dart';
import 'package:peron_project/features/profile/presentation/view/widgets/custom_outlined_button.dart';


class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                     Images.sign,
                    width: 250,
                    height: 250,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 64),

                CustomOutlinedButton(
                  text: 'إنشاء حساب',
                  onPressed: () {
                   /* Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );*/
                  },
                ),
                SizedBox(height: 10),

                CustomElevatedButton(
                  text: 'تسجيل دخول',
                  onPressed: () {
                    /* Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AuthScreen()),
                    );*/
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
