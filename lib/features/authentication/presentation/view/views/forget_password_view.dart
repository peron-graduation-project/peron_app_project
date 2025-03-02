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
import 'package:peron_project/features/authentication/data/repos/send_verification_code_repo_imp.dart';
import 'package:peron_project/features/authentication/presentation/manager/send%20verification%20code/send_verification_code_cubit.dart';
import 'package:peron_project/features/authentication/presentation/manager/send%20verification%20code/send_verification_code_state.dart';

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

  void _onPhoneNumberChanged(PhoneNumber number) {
    setState(() {
      _phoneNumber = number;
    });
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
                InternationalPhoneNumberInput(
                  initialValue: PhoneNumber(isoCode: 'EG', dialCode: "+20"),
                  onInputChanged: _onPhoneNumberChanged,
                  locale: 'ar',
                  selectorConfig: const SelectorConfig(
                    useBottomSheetSafeArea: true,
                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                  ),
                  ignoreBlank: false,
                  autoValidateMode: AutovalidateMode.disabled,
                  textFieldController: _controller,
                  formatInput: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى إدخال رقم الهاتف';
                    }
                    return null;
                  },
                  searchBoxDecoration: InputDecoration(
                    hintText: "ابحث عن الدولة...",
                    hintStyle: TextStyle(color: AppColors.primaryColor),
                  ),
                  keyboardType: TextInputType.phone,
                  inputDecoration: InputDecoration(
                    errorBorder:OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(12),
                    ) ,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    labelText: "رقم الهاتف",
                    labelStyle: const TextStyle(color: Colors.black54),
                    prefixIcon: const Icon(Icons.phone, color: Colors.black54),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
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
