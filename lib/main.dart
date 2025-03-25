import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/core/helper/application_theme_manager.dart';
import 'package:peron_project/core/helper/media_query.dart';
import 'package:peron_project/core/navigator/page_routes_name.dart';
import 'package:peron_project/core/navigator/routes_generator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'core/network/api_service.dart';
import 'features/main/presentation/view/widgets/favorite_manager.dart';
import 'features/notification/domain/repo/get_notification_repo_imp.dart';
import 'features/notification/presentation/manager/get notifications/notification_cubit.dart';
void main() {
  runApp(
    MultiProvider(providers:
    [
      BlocProvider(
        create: (_) => NotificationCubit(
          NotificationRepoImp(apiService: ApiService(Dio())),
        )..fetchNotifications(),
      ),
      ChangeNotifierProvider(create: (context)=>FavoriteManager())],
  child:  const PeronApp()));
}

class PeronApp extends StatelessWidget {
  const PeronApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Builder(
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
            Locale('ar','AE'), // English
          ],
          initialRoute: PageRouteName.initialRoute,
          onGenerateRoute: RoutesGenerator.onGenerateRoute,
        );
      }
    );
  }
}

