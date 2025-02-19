import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/navigator/page_routes_name.dart';

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

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text("تسجيل الدخول", style: theme.headlineMedium),
        centerTitle: true,
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
                  buildTextField("الإيميل/الهاتف", TextInputType.emailAddress),
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
                      ),
                    ],
                  ),
                  SizedBox(height: screenSize.height * 0.03),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                      ),
                      onPressed: () {
                        if (_formSignInKey.currentState!.validate()) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            PageRouteName.home,
                                (route) => false,
                          );
                        }
                      },
                      child: Text("تسجيل دخول", style: theme.labelLarge?.copyWith(color: Colors.white)),
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
                  SizedBox(height: screenSize.height * 0.08),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("ليس لديك حساب؟", style: theme.bodyMedium?.copyWith(color: Colors.black)),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, PageRouteName.signup);
                        },
                        child: Text(" إنشاء حساب", style: theme.bodyMedium?.copyWith(decoration: TextDecoration.underline)),
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

  Widget buildTextField(String label, TextInputType type, {bool obscureText = false}) {
    return TextFormField(
      keyboardType: type,
      obscureText: obscureText,
      obscuringCharacter: '*',
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'من فضلك أدخل $label';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black12),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
