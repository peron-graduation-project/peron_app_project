import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/images.dart';
import 'package:peron_project/core/widgets/custom_button.dart';

import '../../../../../core/navigator/page_routes_name.dart';
import '../../../../../core/widgets/custom_arrow_back.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          "تحقق من البريد الإلكتروني", style: theme.headlineMedium
        ),
        centerTitle: true,
        leading: CustomArrowBack(),

      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05,vertical: size.height*0.03),
        child: ListView(
          children: [
            SvgPicture.asset(
              Images.verificationPass,
            ),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Text(
"قم بإدخال رمز التحقق المرسل إليك"   ,
                style: theme.headlineSmall,
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                    (index) =>
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.015,
                      ),
                      child: SizedBox(
                        width: size.width * 0.15,
                        height: size.height * 0.07,
                        child: TextField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:  BorderSide(
                                color: AppColors.primaryColor,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            SizedBox(
              width: double.infinity,
              child: CustomButton(textColor: Colors.white, text: "إرسال", backgroundColor: AppColors.primaryColor,onPressed: (){
                Navigator.pushNamed(
                  context,
                  PageRouteName.newPass,
                );
              },),
            ),
          ],
        ),
      ),
    );
  }
}