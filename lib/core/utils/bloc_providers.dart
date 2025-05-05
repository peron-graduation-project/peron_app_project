import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/favourite/data/repos/addFavorite/addFav_imp.dart';
import '../../../features/favourite/data/repos/get%20favorite/get_favorite_repo_imp.dart';
import '../../../features/favourite/data/repos/removeFavorite/removeFav_imp.dart';
import '../../../features/favourite/presentation/manager/addFavorite/addFavorite_cubit.dart';
import '../../../features/favourite/presentation/manager/deleteFavorite/deleteFavorite_cubit.dart';
import '../../../features/favourite/presentation/manager/get%20favorite/get_favorite_cubit.dart';
import '../../../features/main/domain/repo/get%20highest%20price/get_highest_price_repo_imp.dart';
import '../../../features/main/domain/repo/get%20most%20area/get_most_area_repo_imp.dart';
import '../../../features/main/domain/repo/get%20recommended/get_recommended_repo_imp.dart';
import '../../../features/main/domain/repo/get%20search/get_search_repo_imp.dart';
import '../../../features/main/presentation/manager/get%20Search/get_search_cubit.dart';
import '../../../features/main/presentation/manager/get%20lowest%20price/get_lowest_price_cubit.dart';
import '../../../features/main/presentation/manager/get%20most%20area/get_most_area_cubit.dart';
import '../../../features/main/presentation/manager/get%20recommended/get_recommended_properties_cubit.dart';
import '../../../features/main/domain/repo/get%20lowest%20price/get_lowest_price_repo_imp.dart';
import '../../../features/main/presentation/manager/get%20highest%20price/get_highest_price_properties_cubit.dart';
import '../../../features/main/presentation/manager/sort%20button/sort_button_cubit.dart';
import '../../../features/main/presentation/view/widgets/favorite_manager.dart';
import '../../../features/map/domain/repos/get%20nearest/get_nearest_repo_imp.dart';
import '../../../features/map/presentation/manager/get_nearest_cubit.dart';
import '../../../features/notification/domain/repo/notification/notification_repo_imp.dart';
import '../../../features/notification/presentation/manager/get%20notifications/notification_cubit.dart';
import '../../../features/profile/domain/repos/app%20rating/app_rating_repo_imp.dart';
import '../../../features/profile/domain/repos/delete%20account/delete_account_repo_imp.dart';
import '../../../features/profile/domain/repos/get%20inquiry/get_inquiry_repo_imp.dart';
import '../../../features/profile/domain/repos/get%20profile/get_profile_repo_imp.dart';
import '../../../features/profile/domain/repos/update%20profile/update_profile_repo_imp.dart';
import '../../../features/profile/presentation/manager/delete%20account/delete_account_cubit.dart';
import '../../../features/profile/presentation/manager/get%20inquiry/get_inquiry_cubit.dart';
import '../../../features/profile/presentation/manager/get%20profile/get_profile_cubit.dart';
import '../../../features/profile/presentation/manager/update%20profile/update_profile_cubit.dart';
import '../../features/chats/domain/repos/get chats/get_chats_repo_imp.dart';
import '../../features/chats/presentation/manager/get chats/get_chats_cubit.dart';
import '../../features/profile/presentation/manager/app rating/send app rating/send_app_rating_cubit.dart';
import '../network/api_service.dart';

Future<List<SingleChildWidget>> getAppProviders(SharedPreferences sharedPreferences) async {
final apiService=ApiService(Dio());
  final profileRepo = ProfileRepoImp(apiService, sharedPreferences);
  final profileCubit = GetProfileCubit(profileRepo);
  await profileCubit.getProfile();

  return [
    BlocProvider<GetProfileCubit>.value(value: profileCubit),

    BlocProvider(create: (_) => SortCubit()),

    BlocProvider(create: (_) => GetRecommendedPropertiesCubit(GetRecommendedRepoImp(apiService))..getRecommendedProperties()),
    BlocProvider(create: (_) => GetMostAreaCubit(GetMostAreaRepoImp(apiService))..getMostArea()),
    BlocProvider(create: (_) => GetLowestPricePropertiesCubit(GetLowestPriceRepoImp(apiService))..getLowestPriceProperties()),
    BlocProvider(create: (_) => GetHighestPricePropertiesCubit(GetHighestPriceRepoImp(apiService))..getHighestPriceProperties()),

    BlocProvider(create: (_) => GetFavoriteCubit(GetFavoriteRepoImp(apiService))),
    BlocProvider(create: (_) => AddfavoriteCubit(AddfavImp(apiService))),
    BlocProvider(create: (_) => DeletefavoriteCubit(DeletefavImp(apiService))),

    BlocProvider(create: (_) => GetNearestCubit(GetNearestRepoImp(apiService))),
    BlocProvider(create: (_) => GetSearchPropertiesCubit(GetSearchRepoImp(apiService))),

    BlocProvider(create: (_) => GetNotificationCubit(NotificationRepoImpl(apiService))..getNotifications()),
    BlocProvider(create: (_) => GetInquiryCubit(GetInquiryRepoImp(apiService))..getInquires()),

    BlocProvider(create: (_) => GetChatsCubit(GetChatsRepoImp(apiService))..getChats()),

    BlocProvider(create: (_) => SendAppRatingCubit(AppRatingRepoImp(apiService))),
    BlocProvider(create: (_) => DeleteAccountCubit(DeleteAccountRepoImp(apiService))),

    BlocProvider(
      create: (context) => UpdateProfileCubit(
        UpdateProfileRepoImp(apiService, profileRepo),
        profileCubit,
      ),
    ),

    ChangeNotifierProxyProvider2<AddfavoriteCubit, DeletefavoriteCubit, FavoriteManager>(
      create: (_) => FavoriteManager(),
      update: (_, addCubit, deleteCubit, manager) =>
      manager!..setAddCubit(addCubit)..setDeleteCubit(deleteCubit),
    ),
  ];
}
