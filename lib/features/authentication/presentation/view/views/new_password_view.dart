import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/helper/colors.dart';
import '../../../../../core/helper/images.dart';
import '../../../../../core/navigator/page_routes_name.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../../core/widgets/build_text_form_field.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../data/repos/reset password/reset_password_repo_impl.dart';
import '../../../data/repos/send otp/send_repo_imp.dart';
import '../../manager/reset password/reset_password_cubit.dart';
import '../../manager/reset password/reset_password_state.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String email = arguments['email'];
    final String otpCode = arguments['otpCode'];
    print(otpCode);

    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context).textTheme;

    return BlocProvider(
      create: (context) => ResetPasswordCubit(
        ResetPasswordRepoImpl(apiService: ApiService(Dio())),
        SendOtpRepoImp(apiService: ApiService(Dio())),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("كلمة السر الجديدة", style: theme.headlineMedium),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.height * 0.03,
          ),
          child: ListView(
            children: [
              Center(child: SvgPicture.asset(Images.newPassword)),
              SizedBox(height: size.height * 0.04),
              buildTextField(
                "كلمة السر",
                hintText: 'Aa@12345',
                TextInputType.visiblePassword,
                obscureText: true,
                controller: passwordController,
              ),
              SizedBox(height: size.height * 0.03),
              buildTextField(
                "تأكيد كلمة السر",
                hintText: 'Aa@12345',
                TextInputType.visiblePassword,
                obscureText: true,
                controller: confirmPasswordController,
              ),
              SizedBox(height: size.height * 0.05),
              BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
                listener: (context, state) {
                  if (state is ResetPasswordSuccess) {
                    _showSuccessDialog(context);
                  } else if (state is ResetPasswordFailure) {
                    _showSnackBar(context, state.errorMessage);
                  }
                },
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      isLoading: state is ResetPasswordLoading,
                      textColor: Colors.white,
                      text: "تأكيد",
                      backgroundColor: AppColors.primaryColor,
                      onPressed: state is ResetPasswordLoading ? null : () => _onConfirmPressed(context, email, otpCode),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onConfirmPressed(BuildContext context, String email, String otpCode) {
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (password.isEmpty || confirmPassword.isEmpty) {
      _showSnackBar(context, "من فضلك تأكد من ملء جميع الحقول");
      return;
    }

    if (password.length < 8 || confirmPassword.length < 8) {
      _showSnackBar(context, "كلمة المرور يجب أن تحتوي على 8 أحرف على الأقل");
      return;
    }

    if (password != confirmPassword) {
      _showSnackBar(context, 'كلمتا السر غير متطابقتين!');
      return;
    }

    context.read<ResetPasswordCubit>().resetPassword(
      email: email,
      otpCode: otpCode,
      password: password,
      confirmedPassword: confirmPassword,
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: AppColors.scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Color(0xFF0F7757), size: 75),
              const SizedBox(height: 10),
              const Text("تم تغيير كلمة المرور", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              const SizedBox(height: 10),
              const Text(
                "تم تغيير كلمة المرور الخاصة بك بنجاح",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  textColor: Colors.white,
                  text: 'تسجيل الدخول',
                  backgroundColor: AppColors.primaryColor,
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      PageRouteName.login,
                      arguments: false,
                          (route) => false,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
