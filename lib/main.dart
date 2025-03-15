import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:dio/dio.dart';
import 'package:peron_project/core/helper/application_theme_manager.dart';
import 'package:peron_project/core/helper/media_query.dart';
import 'package:peron_project/core/navigator/page_routes_name.dart';
import 'package:peron_project/core/navigator/routes_generator.dart';
import 'package:peron_project/features/notification/presentation/manager/get%20notifications/notification_cubit.dart';
import 'package:peron_project/core/utils/api_service.dart';

import 'features/notification/domain/repo/get_notification_repo_imp.dart';

void main() {
  runApp(const PeronApp());
}

class PeronApp extends StatelessWidget {
  const PeronApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NotificationCubit(
            NotificationRepoImp(apiService:  ApiService(Dio())),
          )..fetchNotifications(),
        ),
      ],
      child: Builder(
        builder: (context) {
          MediaQueryHelper.init(context);
          return MaterialApp(
            title: 'Peron App',
            theme: ApplicationThemeManager.lightThemeMode,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              Locale('ar', 'EG'),
            ],
            initialRoute: PageRouteName.initialRoute,
            onGenerateRoute: RoutesGenerator.onGenerateRoute,
          );
        },
      ),
    );
  }
}
