import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:peron_project/features/advertisements/presentation/widgets/property_card.dart';
import 'package:peron_project/features/myAds/presentation/view/views/modifyProperty.dart';
import 'package:peron_project/features/profile/presentation/view/view/accountScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/helper/application_theme_manager.dart';
import 'core/helper/media_query.dart';
import 'core/navigator/page_routes_name.dart';
import 'core/navigator/routes_generator.dart';
import 'core/utils/bloc_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  final providers = await getAppProviders(sharedPreferences);

  runApp(MultiProvider(providers: providers, child: const PeronApp()));
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
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('ar', 'AE')],
          initialRoute: PageRouteName.initialRoute,
          onGenerateRoute: RoutesGenerator.onGenerateRoute,
        );
      },
    );
  }
}