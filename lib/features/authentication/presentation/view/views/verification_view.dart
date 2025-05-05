import 'dart:async';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peron_project/core/helper/app_snack_bar.dart';
import 'package:peron_project/core/network/api_service.dart';
import 'package:peron_project/features/authentication/data/repos/resend%20otp/resend_otp_repo_imp.dart';
import 'package:peron_project/features/authentication/presentation/manager/resend%20otp/resend_otp_state.dart';

import '../../../../../core/helper/colors.dart';
import '../../../../../core/helper/images.dart';
import '../../../../../core/navigator/page_routes_name.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../data/repos/verify otp/verify_otp_repo_imp.dart';
import '../../manager/resend otp/resend_otp_cubit.dart';
import '../../manager/verify otp/verify_otp_cubit.dart';
import '../../manager/verify otp/verify_otp_state.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as String;
    String email = arguments;
    print(email);
    return MultiBlocProvider(
  providers: [
    BlocProvider(
      create: (context) => VerifyOtpCubit(verifyOtpRepo: VerifyOtpRepoImpl(apiService: ApiService(Dio())), email: email),
),
    BlocProvider(
      create: (context) => ResendOtpCubit(email: email, resendOtpRepo: ResendOtpRepoImp(apiService: ApiService(Dio()))),
    ),
  ],
  child: _VerificationScreenBody(email: email,),
);
  }
}

class _VerificationScreenBody extends StatefulWidget {
  final String email;


  const _VerificationScreenBody({required this.email,});

  @override
  _VerificationScreenBodyState createState() => _VerificationScreenBodyState();
}

class _VerificationScreenBodyState extends State<_VerificationScreenBody> {
  int _timerSeconds = 60;
  Timer? _timer;
  bool _canResend = false;
  final List<TextEditingController> _otpControllers = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _otpFocusNodes = List.generate(4, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer?.cancel();
    _timerSeconds = 60;
    _canResend = false;
    setState(() {});

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds > 0) {
        setState(() {
          _timerSeconds--;
        });
      } else {
        timer.cancel();
        setState(() {
          _canResend = true;
        });
      }
    });
  }

  void resendOtp() {
    if (!_canResend) return;

    context.read<ResendOtpCubit>().resendOtp();
  }

  void onOtpEntered(String value, int index) {
    if (value.isNotEmpty) {
      String newValue = value.substring(value.length - 1);
      setState(() {
        _otpControllers[index].text = newValue;
      });
    } else {
      if (index > 0) {
        FocusScope.of(context).requestFocus(_otpFocusNodes[index - 1]);
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _otpFocusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    String? verifiedOtp;
    String otpCode = '';
    return Scaffold(
      appBar: AppBar(
        title: Text("تحقق من البريد الإلكتروني", style: theme.headlineMedium),
        centerTitle: true,
      ),
      body: MultiBlocListener(
        listeners: [
        BlocListener<VerifyOtpCubit, VerifyOtpState>(
      listenWhen: (previous, current) => current is VerifyOtpSuccess,
      listener: (context, state) {
        final successState = state as VerifyOtpSuccess;
        verifiedOtp = successState.otp;
        print("تم التحقق من OTP: $verifiedOtp");
        AppSnackBar.showFromTop(
          context: context,
          title: 'Success',
          message:successState.message,
          contentType: ContentType.success,
        );
        Navigator.pushNamedAndRemoveUntil(
            context, PageRouteName.login, (route) => false,);
      },
      ),

        BlocListener<VerifyOtpCubit, VerifyOtpState>(
            listenWhen: (previous, current) => current is VerifyOtpFailure,
            listener: (context, state) {
              if (state is VerifyOtpFailure) {
                debugPrint("❌ خطأ عند التحقق من OTP: ${state.errorMessage}");
                AppSnackBar.showFromTop(
                  context: context,
                  title: 'Error',
                  message:state.errorMessage,
                  contentType: ContentType.failure,
                );
              }
            },
          ),
          BlocListener<ResendOtpCubit, ResendOtpState>(
            listenWhen: (previous, current) => current is OtpResentSuccess,
            listener: (context, state) {
              if (state is OtpResentSuccess) {
                AppSnackBar.showFromTop(
                  context: context,
                  title: 'Success',
                  message:'تم إرسال رمز جديد',
                  contentType: ContentType.success,
                );
                startTimer();
              }
            },
          ),
        ],
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.height * 0.03,
          ),
          child: ListView(
            children: [
              SvgPicture.asset(Images.verificationPass),
              SizedBox(height: size.height * 0.02),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Text("قم بإدخال رمز التحقق المرسل إليك", style: theme.headlineSmall, textAlign: TextAlign.center),
              ),
              SizedBox(height: size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4,
                      (index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
                    child: SizedBox(
                      width: size.width * 0.15,
                      height: size.height * 0.07,
                      child: TextField(
                        controller: _otpControllers[index],
                        focusNode: _otpFocusNodes[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        onChanged: (value) => onOtpEntered(value, index),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(1),
                        ],
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.primaryColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          counterText: '',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: _canResend ? resendOtp : null,
                    child: Text(
                      "إعادة الإرسال",
                      style: theme.displaySmall!.copyWith(color: _canResend ? AppColors.primaryColor : Colors.grey),
                    ),
                  ),
                  Spacer(),
                  Text(
                    '$_timerSeconds ثانية',
                    style: theme.displaySmall!.copyWith(color: Color(0xff292828)),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  textColor: Colors.white,
                  text: "إرسال",
                  backgroundColor: AppColors.primaryColor,
                  isLoading: context.watch<VerifyOtpCubit>().state is VerifyOtpLoading,
                  onPressed: () {
                    otpCode = List.generate(
                      _otpControllers.length,
                          (index) => _otpControllers[_otpControllers.length - 1 - index].text.trim(),
                    ).join('');

                    debugPrint("📤 يتم إرسال OTP: $otpCode");
                    if (otpCode.length == 4 && otpCode.runes.every((r) => r >= 48 && r <= 57)) {
                      context.read<VerifyOtpCubit>().verifyOtp(otpCode: otpCode,);
                    } else {
                      AppSnackBar.showFromTop(
                        context: context,
                        title: 'Error',
                        message:'رجى إدخال الرمز بالكامل والتأكد أنه أرقام فقط',
                        contentType: ContentType.failure,
                      );
                    }
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
