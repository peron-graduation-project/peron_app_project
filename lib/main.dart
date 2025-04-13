import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/core/helper/application_theme_manager.dart';
import 'package:peron_project/core/helper/media_query.dart';
import 'package:peron_project/core/navigator/page_routes_name.dart';
import 'package:peron_project/core/navigator/routes_generator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/api_service.dart';
import 'features/main/presentation/view/widgets/favorite_manager.dart';
import 'features/notification/domain/repo/get notification/notification_repo_imp.dart';
import 'features/notification/presentation/manager/get notifications/notification_cubit.dart';
import 'features/profile/domain/repos/get_profile_repo_imp.dart';
import 'features/profile/presentation/manager/get profile/get_profile_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => GetNotificationCubit(
            NotificationRepoImpl(ApiService(Dio())),
          )..getNotifications(),
        ),
        ChangeNotifierProvider(create: (context) => FavoriteManager()),
        BlocProvider<GetProfileCubit>(
          create: (context) {
            final profileRepo = ProfileRepoImp(ApiService(Dio()), sharedPreferences);
            final profileCubit = GetProfileCubit(profileRepo);
            profileCubit.getProfile();
            return profileCubit;
          },
        ),
      ],
      child: const PeronApp(),
    ),
  );
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
            const Locale('ar', 'AE'), // Arabic
          ],
          initialRoute: PageRouteName.initialRoute,
          onGenerateRoute: RoutesGenerator.onGenerateRoute,
        );
      },
    );
  }
}