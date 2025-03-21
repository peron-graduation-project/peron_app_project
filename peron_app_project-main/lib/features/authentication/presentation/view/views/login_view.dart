import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/fonts.dart';
import 'package:peron_project/core/navigator/page_routes_name.dart';
import 'package:peron_project/core/utils/api_service.dart';
import 'package:peron_project/core/widgets/custom_arrow_back.dart';
import 'package:peron_project/core/widgets/custom_button.dart';
import 'package:peron_project/features/authentication/data/repos/login/login_repo_imp.dart';

import '../../../../../core/widgets/build_text_form_field.dart';
import '../../manager/login/login_cubit.dart';
import '../../manager/login/login_state.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool rememberPassword = true;
  final _formSignInKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        loginRepo: LoginRepoImp(apiService: ApiService(Dio()))
      ),
      child: Builder(
        builder: (context) {
          var theme = Theme.of(context).textTheme;
          var screenSize = MediaQuery.of(context).size;
          var showIcon = ModalRoute.of(context)?.settings.arguments as bool? ?? false;

          return Scaffold(
            appBar: AppBar(
              title: Text("تسجيل الدخول", style: theme.headlineMedium),
              centerTitle: true,
              leading: showIcon ? const CustomArrowBack() : null,
            ),
            body: BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccess) {
                  if (state.token.isNotEmpty) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      PageRouteName.home,
                          (route) => false,
                    );
                  }
                } else if (state is LoginFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
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
                        buildTextFieldPattern(
                          controller: _emailController,
                          label: "البريد الإلكتروني",
                          type: TextInputType.emailAddress,
                          text: 'البريد الإلكتروني',
                          pattern: r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$",
                        ),
                        SizedBox(height: screenSize.height * 0.02),
                        buildTextField(
                          "كلمة السر",
                          TextInputType.visiblePassword,
                          obscureText: true,
                          controller: _passwordController,
                        ),
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
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  PageRouteName.forgetPassword,
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: screenSize.height * 0.03),
                        SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            textColor: Colors.white,
                            text: 'تسجيل دخول',
                            backgroundColor: AppColors.primaryColor,
                            onPressed: () {
                              if (_formSignInKey.currentState!.validate()) {
                                context.read<LoginCubit>().login(
                                  _emailController.text.trim(),
                                  _passwordController.text.trim(),
                                );
                              }
                            },
                          ),
                        ),
                        if (state is LoginLoading)
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                        SizedBox(height: screenSize.height * 0.04),
                        Row(
                          children: [
                            const Expanded(child: Divider()),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Text("أو", style: theme.bodyLarge),
                            ),
                            const Expanded(child: Divider()),
                          ],
                        ),
                        SizedBox(height: screenSize.height * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(Icons.facebook, size: 37, color: Colors.blue),
                            const Icon(Icons.apple, size: 44, color: Colors.black),
                            SvgPicture.asset(
                              "assets/icons/icons8-google.svg",
                              height: 34,
                              width: 34,
                            ),
                          ],
                        ),
                        SizedBox(height: screenSize.height * 0.20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "ليس لديك حساب؟",
                              style: theme.displaySmall?.copyWith(
                                color: Colors.black,
                                fontFamily: Fonts.primaryFontFamily,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                " إنشاء حساب",
                                style: theme.displaySmall?.copyWith(
                                  decoration: TextDecoration.underline,
                                  color: AppColors.primaryColor,
                                  fontFamily: Fonts.primaryFontFamily,
                                ),
                              ),
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
        },
      ),
    );
  }
}
