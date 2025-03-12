import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/fonts.dart';
import 'package:peron_project/core/navigator/page_routes_name.dart';
import 'package:peron_project/core/widgets/custom_arrow_back.dart';
import 'package:peron_project/core/widgets/custom_button.dart';

import '../../../../../core/widgets/build_text_form_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool rememberPassword = true;
  final _formSignInKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    var screenSize = MediaQuery.of(context).size;
    var showIcon=ModalRoute.of(context)?.settings.arguments as bool;

    return Scaffold(
      appBar: AppBar(
        title: Text("تسجيل الدخول", style: theme.headlineMedium),
        centerTitle: true,
        leading:showIcon? CustomArrowBack():null,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.08,
              vertical: screenSize.height * 0.05,
            ),
            child: Form(
              key: _formSignInKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextFieldPattern(label: "البريد الإلكتروني",type:  TextInputType.emailAddress,text:'البريد الإلكتروني',pattern: r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+" ),
                  SizedBox(height: screenSize.height * 0.02),
                  buildTextField("كلمة السر", TextInputType.visiblePassword, obscureText: true),
                  SizedBox(height: screenSize.height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: rememberPassword,
                            onChanged: (bool? value) {
                              setState(() {
                                rememberPassword = value ?? false;
                              });
                            },
                            activeColor: AppColors.primaryColor,
                          ),
                          Text("تذكرني", style: theme.bodyMedium),
                        ],
                      ),
                      GestureDetector(
                        child: Text("هل نسيت كلمة السر؟", style: theme.labelSmall),
                        onTap:() {
                          Navigator.pushNamed(
                            context,
                            PageRouteName.forgetPassword,
                          );
                        }
                      ),

                    ],
                  ),
                  SizedBox(height: screenSize.height * 0.03),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(textColor: Colors.white, text: 'تسجيل دخول', backgroundColor: AppColors.primaryColor,
                    onPressed: (){
    if (_formSignInKey.currentState!.validate()) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            PageRouteName.home,
                (route) => false,
          );
        }
    },
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.04),
                  Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text("أو", style: theme.bodyLarge),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  SizedBox(height: screenSize.height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.facebook, size: 37, color: Colors.blue),
                      Icon(Icons.apple, size: 44, color: Colors.black),
                      SvgPicture.asset("assets/icons/icons8-google.svg", height: 34, width: 34),
                    ],
                  ),
                  SizedBox(height: screenSize.height * 0.20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("ليس لديك حساب؟", style: theme.displaySmall?.copyWith(color: Colors.black,fontFamily: Fonts.primaryFontFamily,)),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(" إنشاء حساب", style: theme.displaySmall?.copyWith(decoration: TextDecoration.underline,color: AppColors.primaryColor,fontFamily: Fonts.primaryFontFamily)),

                      ),
                      SizedBox(height: screenSize.height*0.10,)
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
