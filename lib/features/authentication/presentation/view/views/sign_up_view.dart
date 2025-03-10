import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/navigator/page_routes_name.dart';
import 'package:peron_project/core/widgets/custom_button.dart';
import 'package:peron_project/features/authentication/presentation/view/widgets/phone_field.dart';

import '../../../../../core/widgets/build_text_form_field.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _formSignInKey = GlobalKey<FormState>();
  bool acceptAllTerms = true;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    var screenSize = MediaQuery.of(context).size;
    bool isWideScreen = screenSize.width > 600;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text("إنشاء حساب", style: theme.headlineMedium),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double paddingHorizontal = isWideScreen ? screenSize.width * 0.2 : 20;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: 20),
            child: Form(
              key: _formSignInKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildTextField("الإسم", TextInputType.name,),
                  const SizedBox(height: 20.0),
                  buildTextFieldPattern(label: "البريد الإلكتروني",type:  TextInputType.emailAddress,text:'البريد الإلكتروني',pattern: r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+" ),
                  const SizedBox(height: 20.0),
                PhoneFieldInput(),
                  const SizedBox(height: 20.0),
                  buildTextField("كلمة السر", TextInputType.visiblePassword, obscureText: true),
                  const SizedBox(height: 20.0),
                  buildTextField("تأكيد كلمة السر", TextInputType.visiblePassword, obscureText: true),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      Checkbox(
                        value: acceptAllTerms,
                        onChanged: (bool? value) {
                          setState(() {
                            acceptAllTerms = value ?? false;
                          });
                        },
                        activeColor: AppColors.primaryColor,
                      ),
                      Flexible(
                        child: Text(
                          'أوافق على خصوصية الشروط والأحكام',
                          style: theme.displayMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      textColor: Colors.white,
                      text: "إنشاء حساب",
                      backgroundColor: AppColors.primaryColor,
                      onPressed: () {
                        if (_formSignInKey.currentState!.validate() && acceptAllTerms) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            PageRouteName.home,
                                (route) => false,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('يرجى إدخال البيانات و الموافقة على الشروط والأحكام'),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: const [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text("أو", style: TextStyle(fontSize: 18)),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 27),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.facebook, size: 37, color: Colors.blue),
                      const SizedBox(width: 20),
                      Icon(Icons.apple, size: 44, color: Colors.black),
                      const SizedBox(width: 20),
                      SvgPicture.asset("assets/icons/icons8-google.svg", height: 34, width: 34),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("هل لديك حساب؟", style: theme.displaySmall?.copyWith(color: Colors.black)),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, PageRouteName.login, arguments: true);
                        },
                        child: Text(" تسجيل دخول", style: theme.displaySmall),
                      ),
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