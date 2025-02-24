import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/images.dart';
import 'package:peron_project/core/widgets/custom_arrow_back.dart';
import 'package:peron_project/core/widgets/custom_button.dart';

import '../../../../../core/navigator/page_routes_name.dart';
import '../../../../../core/widgets/build_text_form_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          "نسيت كلمة السر",style: theme.headlineMedium,
        ),
        centerTitle: true,
        leading: CustomArrowBack(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05,vertical: size.height*0.03),
        child: ListView(
          children: [
            Center(
              child: SvgPicture.asset(
               Images.forgetPass,
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Text(
                "بمجرد إدخالك البريد الإلكتروني أو رقم الهاتف، ستتلقى رسالة بها رمز التحقق الخاص بك.",
                style: theme.headlineSmall,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            buildTextField("الإيميل/الهاتف", TextInputType.emailAddress),
            SizedBox(height: size.height * 0.03),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                textColor: Colors.white,
                text: 'إرسال',
                backgroundColor: AppColors.primaryColor,
                onPressed: (){
                Navigator.pushNamed(
                  context,
                  PageRouteName.verificationPass,
                );
              },),
            )
          ],
        ),
      ),
    );
  }
}