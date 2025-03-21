import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:peron_project/core/helper/colors.dart';
import 'package:peron_project/core/helper/images.dart';
import 'package:peron_project/core/utils/api_service.dart';
import 'package:peron_project/core/widgets/custom_arrow_back.dart';
import 'package:peron_project/core/widgets/custom_button.dart';
import 'package:peron_project/features/authentication/data/repos/send%20verification%20code/send_verification_code_repo_imp.dart';
import 'package:peron_project/features/authentication/presentation/manager/send%20verification%20code/send_verification_code_cubit.dart';
import 'package:peron_project/features/authentication/presentation/manager/send%20verification%20code/send_verification_code_state.dart';
import 'package:peron_project/features/authentication/presentation/view/widgets/phone_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'EG');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => SendVerificationCodeCubit(
        SendVerificationCodeRepoImp(apiService: ApiService(Dio())),
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
            child: ListView(
              children: [
                SvgPicture.asset(Images.forgetPass),
                SizedBox(height: size.height * 0.03),
                Text(
                  "بمجرد إدخالك رقم الهاتف، ستتلقى رسالة بها رمز التحقق الخاص بك.",
                  style: theme.bodyMedium?.copyWith(color: Colors.black54),
                ),
                SizedBox(height: size.height * 0.03),
                PhoneFieldInput(),
                SizedBox(height: size.height * 0.05),
                BlocConsumer<SendVerificationCodeCubit, SendVerificationCodeState>(
                  listener: (context, state) {
                    if (state is SendVerificationCodeSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("تم إرسال رمز التحقق بنجاح")),
                      );
                    } else if (state is SendVerificationCodeFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage,), backgroundColor: Colors.red),
                      );
                    }
                  },
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        textColor: Colors.white,
                        text: state is SendVerificationCodeLoading ? '...جاري الإرسال' : 'إرسال',
                        backgroundColor: state is SendVerificationCodeLoading ? Colors.grey : AppColors.primaryColor,
                        onPressed: state is SendVerificationCodeLoading
                            ? null
                            : () {
                          if (_formKey.currentState!.validate()) {
                            context.read<SendVerificationCodeCubit>().sendVerificationCode(
                              _phoneNumber.phoneNumber ?? '',
                            );
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
    );
  }
}