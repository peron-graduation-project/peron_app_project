
import 'package:flutter/material.dart';
import 'package:peron_project/features/chats/presentation/view/views/chat_view.dart';
import 'package:peron_project/features/favourite/presentation/view/views/favourite_view.dart';
import 'package:peron_project/features/main/presentation/view/views/main_view.dart';
import 'package:peron_project/features/profile/presentation/view/views/accountScreen.dart';

import '../widgets/animated_bottom_nav_bar.dart';
import '../widgets/custom_floating_action_button.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  HomeViewBodyState createState() => HomeViewBodyState();
}

class HomeViewBodyState extends State<HomeViewBody> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const MainView(),
    const FavouriteView(),
    const ChatView(),
    AccountScreen(),

  ];

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