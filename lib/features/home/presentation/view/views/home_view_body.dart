import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peron_project/core/network/api_service.dart';
import 'package:peron_project/features/chats/presentation/view/views/chat_view.dart';
import 'package:peron_project/features/favourite/data/repos/addFavorite/addFav_imp.dart';
import 'package:peron_project/features/favourite/presentation/manager/addFavorite/addFavorite_cubit.dart';
import 'package:peron_project/features/favourite/presentation/view/views/favourite_view.dart';
import 'package:peron_project/features/main/presentation/view/views/main_view.dart';
import 'package:peron_project/features/profile/domain/repos/get%20profile/get_profile_repo_imp.dart';
import 'package:peron_project/features/profile/presentation/view/view/accountScreen.dart';

import '../../../../profile/presentation/manager/get profile/get_profile_cubit.dart';
import '../widgets/animated_bottom_nav_bar.dart';
import '../widgets/custom_floating_action_button.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  HomeViewBodyState createState() => HomeViewBodyState();
}

class HomeViewBodyState extends State<HomeViewBody> {
  int _selectedIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    final profileRepo = ProfileRepoImp(ApiService(Dio()));
    final profileCubit = GetProfileCubit(profileRepo);
    profileCubit.getProfile();

    _screens = [
      BlocProvider(
  create: (context) => AddfavoriteCubit(AddfavImp(ApiService(Dio()))),
  child: MainView(),
),
      const FavouriteView(),
      const ChatView(),
      BlocProvider.value(
        value: profileCubit,
        child: AccountScreen(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      floatingActionButton: CustomFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}