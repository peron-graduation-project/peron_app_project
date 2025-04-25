import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/core/helper/application_theme_manager.dart';
import 'package:peron_project/core/helper/media_query.dart';
import 'package:peron_project/core/navigator/page_routes_name.dart';
import 'package:peron_project/core/navigator/routes_generator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:peron_project/features/favourite/data/repos/addFavorite/addFav_imp.dart';
import 'package:peron_project/features/favourite/data/repos/removeFavorite/removeFav_imp.dart';
import 'package:peron_project/features/favourite/presentation/manager/addFavorite/addFavorite_cubit.dart';
import 'package:peron_project/features/favourite/presentation/manager/deleteFavorite/deleteFavorite_cubit.dart';
import 'package:peron_project/features/main/domain/repo/get%20recommended/get_recommended_repo_imp.dart';
import 'package:peron_project/features/main/domain/repo/get%20search/get_search_repo.dart';
import 'package:peron_project/features/main/domain/repo/get%20search/get_search_repo_imp.dart';
import 'package:peron_project/features/main/presentation/manager/get%20Search/get_search_cubit.dart';
import 'package:peron_project/features/main/presentation/manager/get%20recommended/get_recommended_properties_cubit.dart';
import 'package:peron_project/features/myAds/presentation/view/views/modifyProperty.dart';
import 'package:peron_project/features/profile/domain/repos/app%20rating/app_rating_repo_imp.dart';
import 'package:peron_project/features/profile/domain/repos/get%20inquiry/get_inquiry_repo_imp.dart';
import 'package:peron_project/features/profile/presentation/manager/app%20rating/send%20app%20rating/send_app_rating_cubit.dart';
import 'package:peron_project/features/profile/presentation/manager/get%20inquiry/get_inquiry_cubit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/api_service.dart';
import 'features/main/presentation/view/widgets/favorite_manager.dart';
import 'features/map/domain/repos/get nearest/get_nearest_repo_imp.dart';
import 'features/map/presentation/manager/get_nearest_cubit.dart';

import 'features/notification/domain/repo/notification/notification_repo_imp.dart';
import 'features/notification/presentation/manager/get notifications/notification_cubit.dart';
import 'features/profile/domain/repos/delete account/delete_account_repo_imp.dart';
import 'features/profile/domain/repos/get profile/get_profile_repo_imp.dart';
import 'features/profile/domain/repos/update profile/update_profile_repo_imp.dart';
import 'features/profile/presentation/manager/delete account/delete_account_cubit.dart';
import 'features/profile/presentation/manager/get profile/get_profile_cubit.dart';
import 'features/profile/presentation/manager/update profile/update_profile_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final profileRepo = ProfileRepoImp(ApiService(Dio()), sharedPreferences);
            final profileCubit = GetProfileCubit(profileRepo);
            return profileCubit..getProfile();
          },
        ),
        BlocProvider(
          create: (context) => GetRecommendedPropertiesCubit(GetRecommendedRepoImp(ApiService(Dio())))..getRecommendedProperties(),
        ),
        BlocProvider(
          create: (context) => AddfavoriteCubit(AddfavImp(ApiService(Dio()))),
        ),
        BlocProvider<GetNearestCubit>(
          create: (context) => GetNearestCubit(GetNearestRepoImp(ApiService(Dio()))),
        ),
        BlocProvider(
        create: (context) => GetSearchPropertiesCubit(GetSearchRepoImp(ApiService(Dio()))),
        
),


        BlocProvider(
          create: (context) => DeletefavoriteCubit(DeletefavImp(ApiService(Dio()))),
        ),
        BlocProvider(
          create: (context) => SendAppRatingCubit(AppRatingRepoImp(ApiService(Dio()))),
        ),
        BlocProvider(
          create: (context) => DeleteAccountCubit(DeleteAccountRepoImp(ApiService(Dio()))),
        ),
        BlocProvider(
          create: (context) => UpdateProfileCubit(
            UpdateProfileRepoImp(
              ApiService(Dio()),
              context.read<GetProfileCubit>().getProfileRepo as ProfileRepoImp,
            ),
            context.read<GetProfileCubit>(),
          ),
        ),

        ChangeNotifierProxyProvider2<AddfavoriteCubit, DeletefavoriteCubit, FavoriteManager>(
          create: (context) => FavoriteManager(),
          update: (context, addCubit, deleteCubit, favoriteManager) =>
          favoriteManager!
            ..setAddCubit(addCubit)
            ..setDeleteCubit(deleteCubit),
        ),
        BlocProvider(
          create: (_) => GetNotificationCubit(
            NotificationRepoImpl(ApiService(Dio())),
          )..getNotifications(),
        ),
        BlocProvider(
          create: (_) => GetInquiryCubit(
            GetInquiryRepoImp(ApiService(Dio())),
          )..getInquires(),
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
            const Locale('ar', 'AE'), 
          ],
          initialRoute: PageRouteName.initialRoute,
          onGenerateRoute: RoutesGenerator.onGenerateRoute,
          // home: EditPropertyScreen(),
        );
      },
    );
  }
}