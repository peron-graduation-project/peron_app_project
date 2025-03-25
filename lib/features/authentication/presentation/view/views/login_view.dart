import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/core/helper/shared_prefs_helper.dart';
import 'package:peron_project/core/network/api_service.dart';
import 'package:peron_project/features/authentication/data/repos/login/login_repo_imp.dart';
import 'package:peron_project/features/authentication/presentation/manager/login/login_cubit.dart';

import 'login_body_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final sharedPrefs = SharedPrefsHelper();
    return BlocProvider(
      create: (_) => LoginCubit(
        loginRepo: LoginRepoImpl(
          apiService: ApiService(Dio()),
          sharedPrefsHelper: sharedPrefs,
        ),
        prefsHelper: sharedPrefs,
      ),
      child: Scaffold(
        body: LoginBodyView(),
      ),
    );
  }
}