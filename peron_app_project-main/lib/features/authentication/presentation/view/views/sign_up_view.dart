import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/navigator/page_routes_name.dart';
import 'package:peron_project/core/utils/api_service.dart';
import 'package:peron_project/core/widgets/custom_button.dart';
import 'package:peron_project/features/authentication/data/repos/signup/signup_repo_imp.dart';
import 'package:peron_project/features/authentication/presentation/manager/signup/signup_cubit.dart';
import 'package:peron_project/features/authentication/presentation/manager/signup/signup_state.dart';
import 'package:peron_project/features/authentication/presentation/view/widgets/phone_field.dart';

import '../../../../../core/widgets/build_text_form_field.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _formSignInKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool acceptAllTerms = true;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    var screenSize = MediaQuery.of(context).size;
    bool isWideScreen = screenSize.width > 600;

    return BlocProvider(
      create: (context) => SignupCubit(SignupRepoImpl(apiService: ApiService(Dio()))),
      child: Scaffold(
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
                    buildTextField("الإسم", TextInputType.name, controller: _fullNameController),
                    const SizedBox(height: 20.0),
                    buildTextFieldPattern(
                      label: "البريد الإلكتروني",
                      type: TextInputType.emailAddress,
                      text: 'البريد الإلكتروني',
                      pattern: r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                      controller: _emailController,
                    ),
                    const SizedBox(height: 20.0),
                    PhoneFieldInput(controller: _phoneController),
                    const SizedBox(height: 20.0),
                    buildTextField("كلمة السر", TextInputType.visiblePassword, obscureText: true, controller: _passwordController),
                    const SizedBox(height: 20.0),
                    buildTextField("تأكيد كلمة السر", TextInputType.visiblePassword, obscureText: true, controller: _confirmPasswordController),
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

                    BlocConsumer<SignupCubit, SignupState>(
                      listener: (context, state) {
                        if (state is SignupSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message), backgroundColor: Colors.green),
                          );
                          Navigator.pushNamedAndRemoveUntil(context, PageRouteName.home, (route) => false);
                        } else if (state is SignupFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.errorMessage), backgroundColor: Colors.red),
                          );
                        }
                      },
                      builder: (context, state) {
                        return SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            textColor: Colors.white,
                            text: state is SignupLoading ? "جاري التسجيل..." : "إنشاء حساب",
                            backgroundColor: AppColors.primaryColor,
                            onPressed: state is SignupLoading
                                ? null
                                : () {
                              if (_formSignInKey.currentState!.validate() && acceptAllTerms) {
                                BlocProvider.of<SignupCubit>(context).signup(
                                  fullName: _fullNameController.text.trim(),
                                  email: _emailController.text.trim(),
                                  phoneNumber: _phoneController.text.trim(),
                                  password: _passwordController.text.trim(),
                                  confirmPassword: _confirmPasswordController.text.trim(),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('يرجى إدخال البيانات والموافقة على الشروط والأحكام'),
                                  ),
                                );
                              }
                            },
                          ),
                        );
                      },
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
      ),
    );
  }
}
