import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/application_theme_manager.dart';
import 'package:peron_project/core/helper/media_query.dart';
import 'package:peron_project/core/navigator/page_routes_name.dart';
import 'package:peron_project/core/navigator/routes_generator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:peron_project/features/profile/presentation/view/views/accountScreen.dart';
import 'package:peron_project/features/profile/presentation/view/views/profile_screen.dart';
import 'package:provider/provider.dart';

import 'features/main/presentation/view/widgets/favorite_manager.dart';
void main() {
  runApp(
    MultiProvider(providers: 
    [ChangeNotifierProvider(create: (context)=>FavoriteManager())],
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
home: AccountScreen(),
        );
      }
    );
  }
}

