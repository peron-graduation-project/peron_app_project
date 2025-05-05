import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/images.dart';
import 'package:peron_project/core/network/api_service.dart';
import 'package:peron_project/core/widgets/custom_arrow_back.dart';
import 'package:peron_project/core/widgets/custom_button.dart';
import 'package:peron_project/features/authentication/data/repos/forget%20password/forget_password_imp.dart';
import 'package:peron_project/features/authentication/data/repos/send%20otp/send_repo_imp.dart';
import '../../../../../core/helper/app_snack_bar.dart';
import '../../../../../core/navigator/page_routes_name.dart';
import '../../manager/forgot password/forgot_password_cubit.dart';
import '../../manager/forgot password/forgot_password_state.dart';
import '../../../../../core/widgets/build_text_form_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (_) => ForgetPasswordCubit(
        ForgetPasswordImp(apiService: ApiService(Dio())),
        SendOtpRepoImp(apiService: ApiService(Dio())),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("نسيت كلمة السر", style: theme.headlineMedium),
          centerTitle: true,
          leading: const CustomArrowBack(),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.06, vertical: size.height * 0.03),
          child: Form(
            key: _formKey,
            child: BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
              listener: (context, state) {
                if (state is ForgetPasswordSuccess) {
                  AppSnackBar.showFromTop(
                    context: context,
                    title: 'Success',
                    message: state.message,
                    contentType: ContentType.success,
                  );
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    PageRouteName.checkOtp,
                        (context) => false,
                    arguments: _emailController.text,
                  );
                } else if (state is ForgetPasswordFailure) {
                  AppSnackBar.showFromTop(
                    context: context,
                    title: 'Error',
                    message: state.errorMessage,
                    contentType: ContentType.failure,
                  );
                }
              },
              child: ListView(
                children: [
                  SvgPicture.asset(Images.forgetPass),
                  SizedBox(height: size.height * 0.03),
                  Text(
                    "بمجرد إدخالك لبريدك الإلكتروني، ستتلقى رسالة بها رمز التحقق الخاص بك.",
                    style: theme.bodyMedium?.copyWith(color: Colors.black54),
                  ),
                  SizedBox(height: size.height * 0.03),
                  buildTextField("البريد الإلكتروني", TextInputType.emailAddress, controller: _emailController),
                  SizedBox(height: size.height * 0.05),
                  BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                    builder: (context, state) {
                      return SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          isLoading: state is ForgetPasswordLoading,
                          textColor: Colors.white,
                          text: 'إرسال',
                          backgroundColor: AppColors.primaryColor,
                          onPressed: state is ForgetPasswordLoading
                              ? null
                              : () {
                            if (_formKey.currentState!.validate()) {
                              context.read<ForgetPasswordCubit>().forgetPassword(_emailController.text.trim());
                            }
                          },
                        ),
                      );
                    },
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
